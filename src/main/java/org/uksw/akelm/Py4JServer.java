package org.uksw.akelm;
import py4j.GatewayServer;

public class Py4JServer {
    public ManhattanGraph getManhattanGraph(int n, int ttl, int envSize,  boolean showDynamics, int d, int nbParallelStreets){
        return new ManhattanGraph(n,  ttl, envSize,  showDynamics, d, nbParallelStreets);
    }

    public EdgeMarkovianGraph getEdgeMarkovianGraph(int n, int ttl, int envSize, boolean showDynamics, double p, double q){
        return new EdgeMarkovianGraph(n, ttl, envSize, showDynamics,  p, q);
    }

    public RWPGraph getRWPGraph(int n, int ttl, int envSize,  boolean showDynamics, int d){
        return new RWPGraph(n,  ttl, envSize, showDynamics, d);
    }

    public static void main(String[] args) {
        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        Py4JServer app = new Py4JServer();
        // app is now the gateway.entry_point
        GatewayServer server = new GatewayServer(app);
        server.start();
    }

}
