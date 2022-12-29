package org.uksw.akelm;

import org.graphstream.graph.Node;

import java.util.Objects;


import static org.uksw.akelm.Tools.*;

public class RWPGraph extends RandomGraph {

    private final int d;


    public RWPGraph(int n, int ttl, int envSize, boolean showDynamics, int d) {
        super(n, ttl, envSize, showDynamics);
        this.d = d;
        this.params.put("d", (double) this.d);
    }

    public void verifyEdges() {
        for(Node u:this.graph.getNodeSet()) {
            for(Node v:this.graph.getNodeSet()) {
                if(!Objects.equals(u.getId(), v.getId())) {
                    if((nodeDistance(u,v) < this.d) && (!u.hasEdgeBetween(v))) {
                        this.graph.addEdge(u.getId()+"--"+v.getId(),u.getId(),v.getId());
                    } else if((nodeDistance(u,v) > this.d) && (u.hasEdgeBetween(v))) {
                        this.graph.removeEdge((u.getEdgeBetween(v)).getId());
                    }
                }
            }
        }
    }

    @Override
    protected void setDirections() {
        for (Node u : this.graph.getNodeSet()) {

            u.setAttribute("ydest", alea.nextDouble() * envSize);
            u.setAttribute("xdest", alea.nextDouble() * envSize);

        }
    }

    @Override
    public void moveNodes() {
        for (Node u : this.graph.getNodeSet()) {
            if (arrivedAtDestination(u)) {
                u.setAttribute("ydest", alea.nextDouble() * envSize);
                u.setAttribute("xdest", alea.nextDouble() * envSize);
            } else {
                moveStraight(u);
            }
        }
    }

    /**
     * this method computes the next position of node u
     *
     * @param u
     */
    public void moveStraight(Node u) {
        double ux = u.getAttribute("x");
        double uy = u.getAttribute("y");
        double dx = u.getAttribute("xdest");
        double dy = u.getAttribute("ydest");
        if (distance(ux, uy, dx, dy) > proximityThreshold) {
            double xMove = dx - ux;
            double yMove = dy - uy;
            double Norm = Math.sqrt(xMove * xMove + yMove * yMove);
            double newX = ux + speed * (xMove / Norm);
            double newY = uy + speed * (yMove / Norm);
            u.addAttribute("x", newX);
            u.addAttribute("y", newY);
        } else {
            u.addAttribute("x", dx);
            u.addAttribute("y", dy);
        }
    }
    public static void main(String[] args) {
        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        new RWPGraph(100, 5, 1000, true, 50).moveAndBroadcast();
    }
}
