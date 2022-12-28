package org.uksw.akelm;

import org.graphstream.algorithm.Toolkit;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Objects;

import static org.uksw.akelm.Tools.distance;
import static org.uksw.akelm.Tools.nodeDistance;

public class EdgeMarkovianGraph extends RandomGraph {

    private final double p;
    private final double q;
    Node[] allNodes;

    public EdgeMarkovianGraph(int n, int ttl, int envSize, int d, boolean showDynamics, double p, double q) {

        super(n, ttl, envSize, d, showDynamics);
        this.p = p;
        this.q = q;
    }

//    public SingleGraph initUnconnectedGraph(int n) {
//        SingleGraph rgg  = super.initUnconnectedGraph(n);
////        return initEdges(rgg);
//        return rgg;
//    }

//    private SingleGraph initEdges(SingleGraph aGraph) {
//        double pEdge = this.p/(this.p + this.q);
//        Node[] graphNodes = aGraph.getNodeSet().toArray(new Node[this.n]);
//        for (int i=0; i<(graphNodes.length-1); i++) {
//            Node u = graphNodes[i];
//            for (int j=i+1; j<graphNodes.length; j++) {
//                Node v = graphNodes[j];
//                if (alea.nextDouble() < pEdge) {
//                    aGraph.addEdge(u.getId()+"--"+v.getId(),u.getId(),v.getId());
//                }
//            }
//        }
//        return aGraph;
//    }


    public void verifyEdges() {
        this.allNodes = this.graph.getNodeSet().toArray(new Node[this.n]);
        for (int i = 0; i < (allNodes.length - 1); i++) {
            Node u = allNodes[i];
            for (int j = i + 1; j < allNodes.length; j++) {
                Node v = allNodes[j];
                if (!u.hasEdgeBetween(v)) {
                    if (alea.nextDouble() > this.q) {
                        this.graph.addEdge(u.getId() + "--" + v.getId(), u.getId(), v.getId());
                    }
                } else {
                    if (alea.nextDouble() > this.p) {
                        this.graph.removeEdge((u.getEdgeBetween(v)).getId());
                    }
                }
            }
        }
    }


    @Override
    protected void setDirections() {
    }


    @Override
    public void moveNodes() {
    }


    public static void main(String[] args) {
        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        new EdgeMarkovianGraph(100, 5, 1000, 50, true, 0.1, 0.99).moveAndBroadcast();
    }
}
