package org.uksw.akelm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.*;

public class PyImportable {

    public PyImportable() {
        System.setProperty("org.graphstream.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
    }

    public static void main(String[] args) throws InterruptedException {
        PyImportable obj = new PyImportable();
        List<double[][]> res = obj.getManhattanGraph(15, 300, 5, 1000, false, 120, 10);
        System.out.println(res.size());
        System.out.println(Arrays.deepToString(res.get(10)));
    }

    public List<double[][]> getManhattanGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, int d, int nbParallelStreets) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(n_iter);

        List<Callable<double[][]>> callableTasks = new ArrayList<>();

        Callable<double[][]> c = () -> {   // Lambda Expression
            ManhattanGraph man = new ManhattanGraph(n, ttl, envSize, showDynamics, d, nbParallelStreets);
            return man.moveAndBroadcast();
        };


        for (int i = 0; i < n_iter; i++) {
            callableTasks.add(c);
        }
        List<Future<double[][]>> futures = executor.invokeAll(callableTasks);
        executor.shutdown();
        List<double[][]> results = new ArrayList<>();
        for (Future<double[][]> task : futures) {
            try {
                double[][] res = task.get();
                results.add(res);
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }

        return results;
    }

    public List<double[][]> getEdgeMarkovianGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, double p, double q) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(n_iter);

        List<Callable<double[][]>> callableTasks = new ArrayList<>();

        Callable<double[][]> c = () -> {   // Lambda Expression
            EdgeMarkovianGraph man = new EdgeMarkovianGraph(n, ttl, envSize, showDynamics, p, q);
            return man.moveAndBroadcast();
        };


        for (int i = 0; i < n_iter; i++) {
            callableTasks.add(c);
        }
        List<Future<double[][]>> futures = executor.invokeAll(callableTasks);
        executor.shutdown();
        List<double[][]> results = new ArrayList<>();
        for (Future<double[][]> task : futures) {
            try {
                double[][] res = task.get();
                results.add(res);
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }

        return results;

    }

    public List<double[][]> getFakeEdgeMarkovianGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, double p, double q) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(n_iter);

        List<Callable<double[][]>> callableTasks = new ArrayList<>();

        Callable<double[][]> c = () -> {   // Lambda Expression
            FakeEdgeMarkovianGraph man = new FakeEdgeMarkovianGraph(n, ttl, envSize, showDynamics, p, q);
            return man.moveAndBroadcast();
        };


        for (int i = 0; i < n_iter; i++) {
            callableTasks.add(c);
        }
        List<Future<double[][]>> futures = executor.invokeAll(callableTasks);
        executor.shutdown();
        List<double[][]> results = new ArrayList<>();
        for (Future<double[][]> task : futures) {
            try {
                double[][] res = task.get();
                results.add(res);
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }

        return results;

    }

    public List<double[][]> getRWPGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, int d) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(n_iter);

        List<Callable<double[][]>> callableTasks = new ArrayList<>();

        Callable<double[][]> c = () -> {   // Lambda Expression
            RWPGraph man = new RWPGraph(n, ttl, envSize, showDynamics, d);
            return man.moveAndBroadcast();
        };


        for (int i = 0; i < n_iter; i++) {
            callableTasks.add(c);
        }
        List<Future<double[][]>> futures = executor.invokeAll(callableTasks);
        executor.shutdown();
        List<double[][]> results = new ArrayList<>();
        for (Future<double[][]> task : futures) {
            try {
                double[][] res = task.get();
                results.add(res);
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }

        return results;

    }


}
