package org.uksw.akelm;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.graphstream.algorithm.ConnectedComponents;
import org.graphstream.algorithm.Toolkit;
import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;

import java.lang.reflect.Array;
import java.util.*;

import static org.uksw.akelm.Tools.*;

public abstract class RandomGraph {
    protected final int envSize;
    protected final int n;
    private final boolean showDynamics;
    public final TreeMap<String, Double> params;

    // execution parameters
    int delay = 50;
    public final static String hasInfo = "fill-color:red;";
    public final static String hasNoInfo = "fill-color:blue;";
    int maxIter = 1000;
    double proximityThreshold = 1;
    double speed = 1;
    Random alea = aleaGenerator();
    protected SingleGraph graph;
    protected final int ttl;
    private HashSet<Edge> prevSet;
    private ConnectedComponents cc;

    public RandomGraph(int n, int ttl, int envSize, boolean showDynamics) {
        this.n = n;
        this.envSize = envSize;
        this.ttl = ttl;
        this.showDynamics = showDynamics;
        this.params = new TreeMap<>();
        this.params.put("n", (double) this.n);
        this.params.put("ttl", (double) this.ttl);

    }

    public SingleGraph initUnconnectedGraph(int n) {
        SingleGraph rgg = new SingleGraph("RGG: " + n);
        // creation of nodes
        for (int u = 0; u < n; u++) {
            Node v = rgg.addNode("v_" + u);
            v.addAttribute("x", alea.nextDouble() * envSize);
            v.addAttribute("y", alea.nextDouble() * envSize);
            v.addAttribute("ttl", 0); // 0 is no message
            v.addAttribute("ui.style", hasNoInfo);
        }
        Node source = Toolkit.randomNode(rgg);
        source.addAttribute("ttl", this.ttl);
        source.addAttribute("ui.style", hasInfo);

        return rgg;
    }

    /**
     * long edges has to be removed and new ones have to be added
     * copied from FG
     */
    public abstract void verifyEdges();

    protected abstract void setDirections();


    public void decreaseTTL() {

        for (Node u : this.graph.getNodeSet()) {
            int ttl = u.getAttribute("ttl");
            if (ttl > 0) {
                u.setAttribute("ttl", ttl - 1);
            }
            if (ttl == 1) {
                u.addAttribute("ui.style", hasNoInfo);
                if (this.showDynamics) {
                    System.out.println("node " + u.getId() + " looses message");
                }
            }
        }

    }

    public int countNodesWithInfo() {
        int nbWithInfo = 0;
        for (Node u : this.graph.getNodeSet()) {
            int ttl = u.getAttribute("ttl");
            if (ttl > 0) {
                nbWithInfo += 1;
            }

        }
        return nbWithInfo;
    }
// deeper analysis of the reults
// results
    // why there os some uppred threshold on fraction o manhattan
    //
    public void broadcast() {
        for (Node u : this.graph.getNodeSet()) {
            int ttl = u.getAttribute("ttl");
            if (ttl > 0 & ttl <= this.ttl) {

                Iterator<Node> neighbors = u.getNeighborNodeIterator();
                while (neighbors.hasNext()) {
                    Node v = neighbors.next();
                    int nodeTTL = v.getAttribute("ttl");
                    if (nodeTTL == 0) {
                        if (this.showDynamics) {
                            System.out.println("node " + v.getId() + " gets message from " + u.getId());
                        }
                        v.setAttribute("ttl", this.ttl+1);
                        v.addAttribute("ui.style", hasInfo);
                    }
                }
            }
        }
    }


    protected double[] collectStatistics() {
        Set<Edge> currSet = Sets.newHashSet(this.graph.getEdgeSet());
        int diffCount = Sets.symmetricDifference(prevSet, currSet).size();
        int sumCount = Sets.union(prevSet, currSet).size();
        float nervousness = (float) diffCount / sumCount;  // to zapisac
        prevSet = Sets.newHashSet(currSet);
        double graphDensity = Toolkit.density(this.graph); // to zapisac
        int connCompCnt = this.cc.getConnectedComponentsCount(); // to zapisac
        int nbWithInfo = countNodesWithInfo();
        return new double[]{nbWithInfo, nervousness, graphDensity, connCompCnt};
    }


    public abstract void moveNodes();

    /**
     * main method for launching the simulation.
     * 1) init phase: the graph, the environment, the
     * mobility model and the broadcasting algorithm are
     * initialized.
     * 2) iterative phase: at each time step, all nodes enable
     * to communicate, perform the broadcast, then all nodes
     * are moving according to the chosen mobility model.
     * For simple flooding, this phase stops as soon as
     * during one time step no transmission has been done.
     * 3) statistical results are displayed in the console/terminal.
     */
    public double[][]  moveAndBroadcast() {
        this.graph = initUnconnectedGraph(this.n);
        double[][] results = new double[maxIter][4];;
        if (this.showDynamics) {
            this.graph.addAttribute("ui.antialias");
            this.graph.display(false);
        }
        setDirections();
        this.cc = new ConnectedComponents();
        this.cc.init(this.graph);
        this.prevSet = Sets.newHashSet(this.graph.getEdgeSet());        // execution of the algorithm
        int nbIterations;
        for (nbIterations = 0; nbIterations < maxIter; nbIterations++) {
//            hitakey(String.valueOf(countNodesWithInfo()));


            moveNodes();
            verifyEdges();
            broadcast();


            results[nbIterations] = collectStatistics();

            decreaseTTL();
            int nbWithInfo = countNodesWithInfo();
            if (this.showDynamics) {
                Tools.pause(delay);
            }
            if (this.showDynamics) {
                System.out.println("iter " + nbIterations);
                System.out.println("info " + nbWithInfo);
            }
            if (nbWithInfo == 0) {
                break;
            }
        }
        return results;
    }


    /**
     * meethod verifies if the station is at destination
     *
     * @param u
     * @return
     */
    public boolean arrivedAtDestination(Node u) {
        boolean arrived = false;
        double ux = u.getAttribute("x");
        double uy = u.getAttribute("y");
        double dx = u.getAttribute("xdest");
        double dy = u.getAttribute("ydest");
        if ((ux == dx) && (uy == dy)) arrived = true;
        return arrived;
    }

    public TreeMap<String, Double> getParams(){
        return this.params;
    }


}
