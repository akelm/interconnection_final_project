package org.uksw.akelm;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Sets;

import java.util.Arrays;
import java.util.List;
import java.util.Set;

public class Main {
    // params
    static int[] nArray = {50, 100, 200, 300};
    static int[] dArray = {20, 30, 50, 70, 80, 100, 120};
    static int[] ttlArray = {1, 2, 3, 4, 5};
    static double[][] pqArray = {{0.05, 0.95}, {0.1, 0.9}, {0.3, 0.7}, {0.5, 0.5}, {0.7, 0.3}, {0.9, 0.1}, {0.95, 0.05}};
    static double[] pArray = {0.05, 0.1, 0.3, 0.5, 0.7, 0.9, 0.95};
    static int numExp = 5;
    static int envSize = 1000;
    static int nbParallelStreets = 10;

    public static void main(String[] args) {
        // napisac symulacje markovian w pythonie
        Set<Double> ttlSet = ImmutableSet.of(1., 2., 3., 4., 5.);
        Set<Double> pSet = ImmutableSet.of(0.05, 0.1, 0.3, 0.5, 0.7, 0.9, 0.95);
        Set<List<Double>> cartProd =
                Sets.cartesianProduct(ImmutableList.of(ttlSet, pSet));
        long start = System.currentTimeMillis();
        cartProd.stream().parallel().forEach(lst -> {

            double[][] arr = new FakeEdgeMarkovianGraph(120,  lst.get(0).intValue(), envSize, false, lst.get(1), 1-lst.get(1)).moveAndBroadcast();

        });
        long finish = System.currentTimeMillis();
        long timeElapsed = finish - start;
        System.out.println(timeElapsed);

//        for (int i = 0; i < numExp; i++) {
//            for (int n : nArray) {
//                System.out.println(n);
//                for (int ttl : ttlArray) {
//                    for (int d : dArray) {
//                        new ManhattanGraph(n, ttl, envSize, false, d, nbParallelStreets).moveAndBroadcast();
//                        new RWPGraph(n, ttl, envSize,false, d).moveAndBroadcast();
//                    }
//                    for (double[] pq : pqArray) {
//                        new EdgeMarkovianGraph(n, ttl, envSize, false, pq[0], pq[1]).moveAndBroadcast();
//                    }
//                }
//            }
//        }
    }


}
