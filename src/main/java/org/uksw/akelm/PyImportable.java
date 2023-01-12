package org.uksw.akelm;

public class PyImportable {

    public PyImportable() {
        System.setProperty("org.graphstream.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
    }

    public double[][][] getManhattanGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, int d, int nbParallelStreets) {
        return new ManhattanGraph(n, ttl, envSize, showDynamics, d, nbParallelStreets).moveAndBroadcast(n_iter);
    }

    public double[][][] getEdgeMarkovianGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, double p, double q) {
        return new EdgeMarkovianGraph(n, ttl, envSize, showDynamics, p, q).moveAndBroadcast(n_iter);
    }

    public double[][][] getFakeEdgeMarkovianGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, double p, double q) {
        return new FakeEdgeMarkovianGraph(n, ttl, envSize, showDynamics, p, q).moveAndBroadcast(n_iter);
    }

    public double[][][] getRWPGraph(int n_iter, int n, int ttl, int envSize, boolean showDynamics, int d) {
        return new RWPGraph(n, ttl, envSize, showDynamics, d).moveAndBroadcast(n_iter);
    }


}
