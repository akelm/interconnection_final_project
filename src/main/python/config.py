import copy

import numpy as np

nArray = [50, 100, 200, 300]

dArray = [20, 30, 50, 70, 80, 100, 120]

ttlArray = [1, 2, 3, 4, 5]

pqArray = [[x * x * np.pi / 1000 / 1000, 1 - x * x * np.pi / 1000 / 1000] for x in dArray]
pArr, qArr = zip(*pqArray)

numExp = 15

max_iter = 1000

nbParallelStreets = 10

filenames_dict = {
    "man": "res_manh",
    "rwp": "res_rwp",
    "edge": "res_edge",
}

title_labels = {
    "man": "Manhattan model",
    "rwp": "RWP model",
    "edge": "Edge Markovian model",
    "nerv": "Edge nervousness",
    "dens": "Graph density",
    "conn": "Number of connected components normalized to the number of nodes"}

legend_cols = {
    "edge": ["p"],
    "rwp": ["d"],
    "man": ["d"],
    "nerv": ["d", "p"],
    "dens": ["d", "p"],
    "conn": ["d", "p"]}

labels = {
    "edge": "p=%.3f",
    "rwp": "d=%d",
    "man": "d=%d",
    "nerv": f"d=%d or p=%.3f",
    "dens": f"d=%d or p=%.3f",
    "conn": f"d=%d or p=%.3f", }

values_dict = {
    "n": nArray,
    "ttl": ttlArray,
    "d": dArray,
    "p": pArr,
    "name": list(title_labels.values())}

data_cols = {
    "info": 0,
    "nerv": 1,
    "dens": 2,
    "conn": 3

}

info_plot_kwargs = dict(data_col=0, figsize=(15, 10), gridsize=(5, 4), xmax=max_iter, ymax=1.1, xlabel="iteration\nn=%d", ylabel="TTL=%d\nrate of nodes\nwith info",
                        title_str="Fraction of the nodes with information in %s dynamic graph. Time traces were averaged over 15 experiments. The color area around curves is their respective standard deviation.",
                        fig_name="frac_info_%s.pdf", grp_cols=["ttl", "n"])

nerv_plot_kwargs = dict(data_col=1, figsize=(15, 10), gridsize=(3, 4), xmax=max_iter, ymax=None, xlabel="iteration\nn=%d", ylabel="%s\nedge nervousness",
                        title_str="%s for all models. Time traces were averaged over 15 experiments. The shaded area around curves is their respective standard deviation.", fig_name="%sousness.pdf",
                        grp_cols=["name", "n"])

dens_plot_kwargs = copy.deepcopy(nerv_plot_kwargs)
dens_plot_kwargs.update(fig_name="%sity.pdf", ylabel="%s\ngraph density", data_col=2, ymax=0.1)
conn_plot_kwargs = copy.deepcopy(nerv_plot_kwargs)
conn_plot_kwargs.update(fig_name="%sected_comp.pdf", ylabel="%s\nrnbConnComp/n", data_col=3, ymax=1.1)

succ_plot_kwargs = dict(figsize=(10, 15), gridsize=(5, 3), xlabel="n\n%s", ylabels=["TTL=%s\nd", "p (in Edge Markovian)\nTTL=%s"],
                        fig_name="%s_rate.pdf",
                        grp_cols=["ttl", "name"])



plot_params_dict = {
    "info": info_plot_kwargs,
    "nerv": nerv_plot_kwargs,
    "dens": dens_plot_kwargs,
    "conn": conn_plot_kwargs,
    "succ": succ_plot_kwargs
}