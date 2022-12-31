import datetime
import time
from itertools import product, chain
from multiprocessing import Pool

import joblib as joblib
import numpy as np
from py4j.java_gateway import JavaGateway

nArray = [50, 100, 200, 300]

dArray = [20, 30, 50, 70, 80, 100, 120]

ttlArray = [1, 2, 3, 4, 5]

pqArray = [[x * x * np.pi / 1000 / 1000, 1 - x * x * np.pi / 1000 / 1000] for x in dArray]
pArr, qArr = zip(*pqArray)

numExp = 15

envSize = 1000

nbParallelStreets = 10

if __name__ == "__main__":
    gateway = JavaGateway()


    def runManhattanGraph(n, ttl, d):
        res_list = []
        app = JavaGateway().entry_point
        for _ in range(numExp):
            results = app.getManhattanGraph(n, ttl, envSize, False, d, nbParallelStreets)
            res_list.append(np.array(results))
        return {

            "name": "Manhattan",
            "n": n,
            "ttl": ttl,
            "d": d,
            "res_list": res_list}


    def runEdgeMarkovianGraph(n, ttl, pq):
        p, q = pq
        res_list = []
        app = JavaGateway().entry_point
        for _ in range(numExp):
            results = app.getEdgeMarkovianGraph(n, ttl, envSize, False, p, q)
            res_list.append(np.array(results))
        return {

            "name": "EdgeMarkovian",
            "n": n,
            "ttl": ttl,
            "pq": pq,
            "res_list": res_list}


    def runFakeEdgeMarkovianGraph(n, ttl, pq):
        p, q = pq
        res_list = []
        app = JavaGateway().entry_point
        for _ in range(numExp):
            results = app.getFakeEdgeMarkovianGraph(n, ttl, envSize, False, p, q)
            res_list.append(np.array(results))
        return {

            "name": "EdgeMarkovian",
            "n": n,
            "ttl": ttl,
            "pq": pq,
            "res_list": res_list}


    def runRWPGraph(n, ttl, d):
        res_list = []
        for _ in range(numExp):
            app = JavaGateway().entry_point
            results = app.getRWPGraph(n, ttl, envSize, False, d)
            res_list.append(np.array(results))
        return {
            "name": "RWP",
            "n": n,
            "ttl": ttl,
            "d": d,
            "res_list": res_list}


    def run_first(func, *args):
        return func(*args)


    manh_params = product([runManhattanGraph], nArray, ttlArray, dArray)
    edge_params = product([runEdgeMarkovianGraph], nArray, ttlArray, pqArray)
    fakeedge_params = product([runFakeEdgeMarkovianGraph], nArray, ttlArray, pqArray)
    rwp_params = product([runRWPGraph], nArray, ttlArray, dArray)
    all_params = chain(manh_params, edge_params, rwp_params)

    with Pool(24) as pool:
        for name, params in zip(("rwp", "manh", "edge"), (rwp_params, manh_params, fakeedge_params)):
            t0 = time.time()
            result_set = pool.starmap_async(run_first, params).get()
            filename = f"res_{name}_{datetime.datetime.now().strftime('%Y_%m_%d_%H_%M_%S')}.joblib"
            joblib.dump(result_set, filename)
            print(name, time.time() - t0)
