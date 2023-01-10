package org.uksw.akelm;

import com.google.common.collect.Sets;
import org.graphstream.graph.Node;

import java.util.*;

public class FakeEdgeMarkovianGraph extends RandomGraph {

    private final double p;
    private final double q;
    private final boolean[][] connectivityMatrix;

    private final int[] ttlArray;
    //    private final double[] doubleArr;
    private int doubleArrPointer;
    Node[] allNodes;

    public FakeEdgeMarkovianGraph(int n, int ttl, int envSize, boolean showDynamics, double p, double q) {

        super(n, ttl, envSize, showDynamics);
        this.p = p;
        this.q = q;
        this.params.put("p", this.p);
        this.params.put("q", this.q);
        this.connectivityMatrix = new boolean[n][n];
        this.ttlArray = new int[n];
    }


    public void verifyEdges() {
        for (int i = 0; i < (n - 1); i++) {
            for (int j = i + 1; j < n; j++) {
                double randomNumber = alea.nextDouble();
                if (this.connectivityMatrix[i][j]) {
                    if (randomNumber > this.p) {
                        this.connectivityMatrix[i][j]=false;
                        this.connectivityMatrix[j][i]=false;
                    }
                } 
                else {
                    if (randomNumber > this.q) {
                        this.connectivityMatrix[i][j]=true;
                        this.connectivityMatrix[j][i]=true;
                    }
                }
            }
        }
    }
    
    @Override
    public void broadcast() {
        for (int i = 0; i < n; i++) {
            if (ttlArray[i] >0 & ttlArray[i] <= ttl) {
                for (int j = 0; j < n; j++) {
                    if ( (connectivityMatrix[i][j] | connectivityMatrix[j][i]) & ttlArray[j]==0) {
                        ttlArray[j] = ttl+1;
                    }
                }
            }

        }
    }
    @Override
    public void decreaseTTL() {
        for (int i = 0; i < n; i++) {
            if (ttlArray[i] > 0) {
                ttlArray[i]-=1;
            }
        }
    }

    @Override
    protected void setDirections() {
    }


    @Override
    public void moveNodes() {
    }



    public int sumEdges() {
        int sum = 0;
        for (int i = 0; i < (n - 1); i++) {
            for (int j = i + 1; j < n; j++) {
                if (this.connectivityMatrix[i][j]) {
                    sum++;
                }
            }
        }
        return sum;
    }
    @Override
    public int countNodesWithInfo() {
        int info = 0;
        for (int i=0; i<n; i++) {
            if (ttlArray[i] >0) {
                info+=1;
            }
        }
        return info;

//        return Arrays.stream(ttlArray).map(x -> {  if (x>0) return 1; else return 0; }).sum();
    }


    public Set<Integer> getEdgeSet(){
        Set<Integer> nodeSet = new HashSet<>();
        int nodeNumber = 0;
        for (int i = 0; i < (n - 1); i++) {
            for (int j = i + 1; j < n; j++) {
                if (this.connectivityMatrix[i][j]) {
                    nodeSet.add(nodeNumber);
                }
                nodeNumber++;
            }
        }
        return nodeSet;
    }

    public int countComponents() {

        int nbZeroPrev = 1;
        for (int i=1; i<n; i++){
            int sumConn = 0;
            for (int j=0; j<i; j++) {
                if (connectivityMatrix[i][j]) {
                    sumConn++;
                }
            }
            if (sumConn==0) {
                nbZeroPrev++;
            }
        }
        return nbZeroPrev;
    }



    @Override
    public double[][]  moveAndBroadcast() {
        // init source
        ttlArray[0] = ttl;

        double[][] results = new double[maxIter][4];;

        Set<Integer> prevSet = getEdgeSet();
        int nbIterations;
        for (nbIterations = 0; nbIterations < maxIter; nbIterations++) {


            verifyEdges();
            broadcast();

            // nervousness
            Set<Integer> currSet = getEdgeSet();
            int diffCount = Sets.symmetricDifference(prevSet, currSet).size();
            int sumCount = Sets.union(prevSet, currSet).size();
            double nervousness = (double) diffCount / sumCount;  // to zapisac
            prevSet = currSet;
            // density
            double graphDensity = (double)sumEdges() / ((double)n*(n-1)/2);
            int connCompCnt = countComponents(); // to zapisac
            int nbWithInfo = countNodesWithInfo();
            double[] iterRes = {nbWithInfo, nervousness, graphDensity, connCompCnt};

            results[nbIterations] = iterRes;
            decreaseTTL();
            if (countNodesWithInfo() == 0) {
                break;
            }
        }
        return results;
    }


    public static void main(String[] args) {
        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        new FakeEdgeMarkovianGraph(100, 5, 1000, true, 0.1, 0.99).moveAndBroadcast();
    }
}
