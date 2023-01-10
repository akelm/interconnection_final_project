package org.uksw.akelm;

import org.graphstream.algorithm.Toolkit;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;

import java.util.*;
import java.util.stream.DoubleStream;

import static org.uksw.akelm.Tools.distance;
import static org.uksw.akelm.Tools.nodeDistance;

public class EdgeMarkovianGraph extends RandomGraph {

    private final double p;
    private final double q;
    private final double[] doubleArr;
    private int doubleArrPointer;
    Node[] allNodes;

    public EdgeMarkovianGraph(int n, int ttl, int envSize, boolean showDynamics, double p, double q) {

        super(n, ttl, envSize, showDynamics);
        this.p = p;
        this.q = q;
        this.params.put("p", this.p);
        this.params.put("q", this.q);
        long rndCount = (((long) n *n) - n)/2 * (maxIter+1);
        this.doubleArr = alea.doubles(rndCount).toArray();
        this.doubleArrPointer = 0;
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
        for (int i = 0; i < (allNodes.length - 1); i++) {
            Node u = allNodes[i];
            for (int j = i + 1; j < allNodes.length; j++) {
                Node v = allNodes[j];
                double randomNumber = doubleArr[doubleArrPointer];
                doubleArrPointer+=1;
                if (!u.hasEdgeBetween(v)) {
                    if (randomNumber > this.q) {
                        this.graph.addEdge(u.getId() + "--" + v.getId(), u.getId(), v.getId());
                    }
                } else {
                    if (randomNumber > this.p) {
                        this.graph.removeEdge((u.getEdgeBetween(v)).getId());
                    }
                }
            }
        }
    }


    @Override
    protected void setDirections() {
        this.allNodes = this.graph.getNodeSet().toArray(new Node[this.n]);
    }


    @Override
    public void moveNodes() {
    }


    public static void main(String[] args) {
        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        new EdgeMarkovianGraph(300, 1, 1000, true, 0.1, 0.99).moveAndBroadcast();
    }
}
