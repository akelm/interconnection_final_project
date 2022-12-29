package org.uksw.akelm;

public class Main {
    // params
    static int[] nArray = {50, 100, 200, 300};
    static int[] dArray = {20, 30, 50, 70, 80, 100, 120};
    static int[] ttlArray = {1, 2, 3, 4, 5};
    static double[][] pqArray = {{0.05, 0.95}, {0.2, 0.8}, {0.4, 0.6}, {0.6, 0.4}, {0.8, 0.2}, {0.95, 0.05}, {0.1, 0.1}, {0.7, 0.7}};
    static int numExp = 5;
    static int envSize = 1000;
    static int nbParallelStreets = 10;

    public static void main(String[] args) {
        for (int i = 0; i < numExp; i++) {
            for (int n : nArray) {
                System.out.println(n);
                for (int ttl : ttlArray) {
                    for (int d : dArray) {
                        new ManhattanGraph(n, ttl, envSize, false, d, nbParallelStreets).moveAndBroadcast();
                        new RWPGraph(n, ttl, envSize,false, d).moveAndBroadcast();
                    }
                    for (double[] pq : pqArray) {
                        new EdgeMarkovianGraph(n, ttl, envSize, false, pq[0], pq[1]).moveAndBroadcast();
                    }
                }
            }
        }
    }


}
