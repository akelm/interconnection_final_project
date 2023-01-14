import pandas as pd

from config import plot_params_dict
from plot_generic import get_most_current_dfs, plot_info, plot_succ

if __name__ == "__main__":

    dfs_dict = get_most_current_dfs()
    succ_df = pd.concat(list(dfs_dict.values()))
    succ_df[['name', 'n', 'ttl', 'd', 'p', 'res_list']]\
        .rename(columns={"res_list":"iter_X_info_nerv_dens_conn_X_exp"})\
        .reset_index(drop=True).to_json("all.json",orient="table")
    joint_df = succ_df.groupby("ttl").get_group(5)

    for key, model_df in dfs_dict.items():
        plot_info(key, model_df, **plot_params_dict["info"])

    for key in ("nerv", "dens", "conn"):
        plot_info(key, joint_df, **plot_params_dict[key])

    plot_succ("succ", succ_df, **plot_params_dict["succ"])


