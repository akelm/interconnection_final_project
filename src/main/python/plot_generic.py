import glob
from functools import partial, reduce
from operator import itemgetter

import joblib
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.cm import ScalarMappable

from config import filenames_dict, values_dict, legend_cols, labels, title_labels


def zeros_to_nan(arr: np.ndarray):
    arr[np.all(arr == 0, axis=1)] = np.nan
    return arr


deep_get = lambda *indices: partial(reduce, lambda x, i: x[i], indices)


def get_most_current_dfs() -> dict:
    df_dict = dict()
    for name, fname in filenames_dict.items():
        latest_fname = sorted(glob.glob(fname + "*.joblib"))[-1]
        df = pd.DataFrame(joblib.load(latest_fname))
        df["res_list_orig"] = df["res_list"].copy()
        df["res_list"] = df["res_list_orig"].transform(lambda l: [zeros_to_nan(arr) for arr in l]).transform(np.dstack)
        df["exp_mean"] = df["res_list"].transform(lambda arr: np.nanmean(arr, axis=2))
        df["exp_std"] = df["res_list"].transform(lambda arr: np.nanstd(arr, axis=2))
        df["succ_rate"] = df["res_list"].transform(lambda arr: np.mean(np.all(~np.isnan(arr), axis=1).sum(axis=0) == 1000))
        df["exp_mean"] = df[["n", "exp_mean"]].groupby("n", as_index=False).apply(lambda x: x["exp_mean"].transform(lambda arr: arr / np.array([x["n"].iloc[0], 1, 1, x["n"].iloc[0]]))).reset_index(
            level=0, drop=True)
        df["exp_std"] = df[["n", "exp_std"]].groupby("n", as_index=False).apply(lambda x: x["exp_std"].transform(lambda arr: arr / np.array([x["n"].iloc[0], 1, 1, x["n"].iloc[0]]))).reset_index(
            level=0, drop=True)
        df["name"].replace({
            "EdgeMarkovian": "Edge Markovian model",
            "RWP": "RWP model",
            "Manhattan": "Manhattan model"}, inplace=True)
        df_dict[name] = df
    df_dict["edge"]["p"] = df_dict["edge"]["pq"].transform(itemgetter(0))
    df_dict["edge"]["d"] = df_dict["man"]["d"]
    df_dict["man"]["p"] = df_dict["edge"]["p"]
    df_dict["rwp"]["p"] = df_dict["edge"]["p"]
    return df_dict


def plot_info(key, model_df, data_col, figsize, gridsize, xmax, ymax, xlabel, ylabel, title_str, fig_name, grp_cols):
    fig: plt.Figure = plt.figure(figsize=figsize)
    gs = fig.add_gridspec(*gridsize, hspace=0, wspace=0)
    axes = gs.subplots(sharex='col', sharey='row')
    for vals, df in model_df.groupby(grp_cols, sort=True):
        inds = [values_dict[n].index(v) for n, v in zip(grp_cols, vals)]
        ax: plt.Axes = deep_get(*inds)(axes)
        for _, row in df.iterrows():
            exp_mean = row["exp_mean"]
            l = np.sum(np.isfinite(exp_mean[:, data_col]))
            d = tuple(row[c] for c in legend_cols[key])
            val = exp_mean[:l, data_col]
            err = row["exp_std"][:l, data_col]
            ax.plot(range(l), val, label=labels[key] % d, linewidth=1)
            lower = val - err
            upper = val + err
            ax.fill_between(range(l), lower, upper, alpha=0.2)
        ax.set_xlim(0, xmax)
        ax.set_ylim(0, ymax)
        ax.set_xlabel(xlabel % vals[-1])
        ax.set_ylabel(ylabel % vals[0])
        ax.label_outer()
        if inds[0] == 0:
            ax3: plt.Axes = ax.twiny()
            fst, *new_xlabel = (xlabel % vals[-1]).split("\n")
            new_xlabel.append(fst)
            ax3.set_xlabel("\n".join(new_xlabel))
            ax3.set_xlim(*ax.get_xlim())
            ax3.label_outer()
        if inds[-1] == gridsize[1] - 1:
            ax2: plt.Axes = ax.twinx()
            fst, *new_ylabel = (ylabel % vals[0]).split("\n")
            new_ylabel.append(fst)
            ax2.set_ylabel("\n".join(new_ylabel))
            ax2.set_ylim(*ax.get_ylim())
            ax2.label_outer()
        ax.set_facecolor("azure")
    axes[0][3].legend(loc='upper right')
    fig.suptitle(title_str % title_labels[key])
    plt.savefig(fig_name % key, bbox_inches='tight', pad_inches=0, dpi=500)




def plot_succ(key, model_df, figsize, gridsize, xlabel, fig_name, grp_cols, ylabels):
    fig: plt.Figure = plt.figure(figsize=figsize)
    gs = fig.add_gridspec(*gridsize, hspace=0, wspace=0)
    axes = gs.subplots(sharex='col', sharey='row')
    for vals, df in model_df.groupby(grp_cols, sort=True):
        inds = [values_dict[n].index(v) for n, v in zip(grp_cols, vals)]
        ax: plt.Axes = deep_get(*inds)(axes)

        ax.scatter(df["n"], df["d"], c=df["succ_rate"], cmap="gnuplot", s=100, edgecolors="gray")
        ax.set_xlabel(xlabel % vals[-1])
        ax.set_ylabel(ylabels[0] % vals[0])
        ax.set_yticks(values_dict["d"])
        ax.set_xticks(values_dict["n"])
        ax.tick_params(axis="x", bottom=True, top=False, labelbottom=True, labeltop=False)
        ax.label_outer()
        if inds[0] == 0:
            ax3: plt.Axes = ax.twiny()
            fst, *new_xlabel = (xlabel % vals[-1]).split("\n")
            new_xlabel.append(fst)
            ax3.set_xlabel("\n".join(new_xlabel))
            ax3.set_xlim(*ax.get_xlim())
            ax3.label_outer()
        if inds[-1] == gridsize[1] - 1:
            ax2: plt.Axes = ax.twinx()
            ax2.set_ylim(*ax.get_ylim())
            ax2.set_yticks(values_dict["d"])
            ax2.set_yticklabels(["%.3f" % p for p in values_dict["p"]])
            ax2.yaxis.set_label_position("right")
            ax2.set_ylabel(ylabels[1] % vals[0])
            # ax2.label_outer()
        ax.set_facecolor("azure")
    fig.subplots_adjust(top=0.9)
    cbar_ax: plt.Axes = fig.add_axes([0.12, 0.95, 0.78, 0.01])
    plt.colorbar(ScalarMappable(cmap="gnuplot"), cax=cbar_ax, label="Success rate at information persistence up to 1000 iterations", orientation='horizontal')
    cbar_ax.xaxis.set_ticks_position('top')
    cbar_ax.xaxis.set_label_position("top")
    cbar_ax.xaxis.set_ticks([0.0, 0.5, 1.0])

    plt.savefig(fig_name % key, bbox_inches='tight', pad_inches=0, dpi=500)







