package org.uksw.akelm;

import org.graphstream.graph.Node;

import java.util.Objects;
import java.util.Random;

import static org.uksw.akelm.Tools.*;

public class ManhattanGraph extends RandomGraph {

    private final int distanceInterStreets;
    private final int nbParallelStreets;
    private final int d;

    public ManhattanGraph(int n, int ttl, int envSize, boolean showDynamics,  int d, int nbParallelStreets) {

        super(n, ttl, envSize, showDynamics);
        this.d = d;
        this.nbParallelStreets = nbParallelStreets;
        this.distanceInterStreets = (int) (envSize / nbParallelStreets);
        this.params.put("d", (double) this.d);
    }

    public void verifyEdges() {
        for (Node u : this.graph.getNodeSet()) {
            for (Node v : this.graph.getNodeSet()) {
                if (!Objects.equals(u.getId(), v.getId())) {
                    if ((nodeDistance(u, v) < this.d) && (!u.hasEdgeBetween(v))) {
                        this.graph.addEdge(u.getId() + "--" + v.getId(), u.getId(), v.getId());
                    } else if ((nodeDistance(u, v) > this.d) && (u.hasEdgeBetween(v))) {
                        this.graph.removeEdge((u.getEdgeBetween(v)).getId());
                    }
                }
            }
        }
    }

    public void chooseFirstDestination(Node u) {
        double x = u.getAttribute("x");
        double y = u.getAttribute("y");
        if (alea.nextBoolean()) {
            if (x / distanceInterStreets < 1) x = distanceInterStreets;
            else x = (int) (x / distanceInterStreets) * distanceInterStreets;
            u.setAttribute("x", x);
            u.setAttribute("xdest", x);
            u.setAttribute("ydest", (double) (1 + alea.nextInt(nbParallelStreets - 1)) * distanceInterStreets);
        } else {
            if (y / distanceInterStreets < 1) y = distanceInterStreets;
            else y = (int) (y / distanceInterStreets) * distanceInterStreets;
            u.setAttribute("y", y);
            u.setAttribute("xdest", (double) (1 + alea.nextInt(nbParallelStreets - 1)) * distanceInterStreets);
            u.setAttribute("ydest", y);
        }
    }

    @Override
    protected void setDirections() {
        for (Node u : this.graph.getNodeSet()) {
            chooseFirstDestination(u);
        }
    }

    @Override
    public void moveNodes() {
        for (Node u : this.graph.getNodeSet()) {
            if (arrivedAtDestination(u)) {
                if (alea.nextBoolean()) { // movement on the x axis
                    u.setAttribute("xdest", (double) (1 + alea.nextInt(nbParallelStreets - 1)) * distanceInterStreets);
                    u.setAttribute("ydest", (double) u.getAttribute("y"));
                } else {
                    u.setAttribute("xdest", (double) u.getAttribute("x"));
                    u.setAttribute("ydest", (double) (1 + alea.nextInt(nbParallelStreets - 1)) * distanceInterStreets);
                }
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
        new ManhattanGraph(100, 5, 1000,  true, 50, 10).moveAndBroadcast();
    }
}
