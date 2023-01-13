import datetime
import glob
import time
from itertools import product, chain

jar_path = glob.glob("../../../target/*dependencies.jar", recursive=True)[0]

import jnius_config

jnius_config.set_classpath(".", jar_path)
import joblib as joblib
import numpy as np
from jnius import autoclass

PyImportable = autoclass("org.uksw.akelm.PyImportable")
classInst = PyImportable()

from config import numExp, nbParallelStreets, max_iter, ttlArray, nArray, dArray, pqArray

if __name__ == "__main__":

    def runManhattanGraph(n, ttl, d):

        results = classInst.getManhattanGraph(numExp, n, ttl, max_iter, False, d, nbParallelStreets)

        return {

            "name": "Manhattan",
            "n": n,
            "ttl": ttl,
            "d": d,
            "res_list": np.array(results)}


    def runEdgeMarkovianGraph(n, ttl, pq):
        p, q = pq
        results = classInst.getFakeEdgeMarkovianGraph(numExp, n, ttl, max_iter, False, p, q)
        return {

            "name": "EdgeMarkovian",
            "n": n,
            "ttl": ttl,
            "pq": pq,
            "res_list": np.array(results)}


    def runRWPGraph(n, ttl, d):
        results = classInst.getRWPGraph(numExp, n, ttl, max_iter, False, d)
        return {
            "name": "RWP",
            "n": n,
            "ttl": ttl,
            "d": d,
            "res_list": np.array(results)}


    def run_first(func, *args):
        return func(*args)


    manh_params = product([runManhattanGraph], nArray, ttlArray, dArray)
    edge_params = product([runEdgeMarkovianGraph], nArray, ttlArray, pqArray)
    rwp_params = product([runRWPGraph], nArray, ttlArray, dArray)
    all_params = chain(manh_params, edge_params, rwp_params)

    for name, params in zip(("rwp", "manh", "edge"), (rwp_params, manh_params, edge_params)):
        t0 = time.time()
        res_list = []
        for ind, par in enumerate(reversed(list(params))):
            res = run_first(*par)
            res_list.append(res)
            print(ind)
        filename = f"res_{name}_{datetime.datetime.now().strftime('%Y_%m_%d_%H_%M_%S')}.joblib"
        joblib.dump(res_list, filename)
        print(name, time.time() - t0)
