 import 'dart:collection';

import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Graph.dart';
import 'package:concordi_around/Vertex.dart';

class DijkstraAlgorithm {

      List<Vertex> nodes;
      List<Edge> edges;
     Set<Vertex> settledNodes;
     Set<Vertex> unSettledNodes;
     Map<Vertex, Vertex> predecessors;
     Map<Vertex, int> distance;

     DijkstraAlgorithm(Graph graph) {
        // create a copy of the array so that we can operate on this array
        this.nodes = graph.getVertexes();
        this.edges = graph.getEdges();
    }

     void execute(Vertex source) {
        settledNodes = new HashSet<Vertex>();
        unSettledNodes = new HashSet<Vertex>();
        distance = new Map<Vertex, int>();
        predecessors = new HashMap<Vertex, Vertex>();
        distance[source] = 0;
        unSettledNodes.add(source);
        while (unSettledNodes.length > 0) {
            Vertex node = getMinimum(unSettledNodes);
            settledNodes.add(node);
            unSettledNodes.remove(node);
            findMinimalDistances(node);
        }
    }

     void findMinimalDistances(Vertex node) {
        List<Vertex> adjacentNodes = getNeighbors(node);
        for (Vertex target in adjacentNodes) {
            if (getShortestDistance(target) > getShortestDistance(node)
                    + getDistance(node, target)) {
                distance[target] = getShortestDistance(node)
                        + getDistance(node, target);
                predecessors[target] = node;
                unSettledNodes.add(target);
            }
        }

    }

     int getDistance(Vertex node, Vertex target) {
        for (Edge edge in edges) {
            if (edge.getSource()==(node)
                    && edge.getDestination()==(target)) {
                return edge.getWeight();
            }
        }
        throw new Exception("Should not happen");
    }

     List<Vertex> getNeighbors(Vertex node) {
        List<Vertex> neighbors = new List<Vertex>();
        for (Edge edge in edges) {
            if (edge.getSource()==(node)
                    && !isSettled(edge.getDestination())) {
                neighbors.add(edge.getDestination());
            }
        }
        return neighbors;
    }

     Vertex getMinimum(Set<Vertex> vertexes) {
        Vertex minimum = null;
        for (Vertex vertex in vertexes) {
            if (minimum == null) {
                minimum = vertex;
            } else {
                if (getShortestDistance(vertex) < getShortestDistance(minimum)) {
                    minimum = vertex;
                }
            }
        }
        return minimum;
    }

     bool isSettled(Vertex vertex) {
        return settledNodes.contains(vertex);
    }

     int getShortestDistance(Vertex destination) {
        int d = distance[destination];
        if (d == null) {
            return 100000;
        } else {
            return d;
        }
    }

    /*
     * This method returns the path from the source to the selected target and
     * NULL if no path exists
     */
     LinkedList<Vertex> getPath(Vertex target) {
        LinkedList<Vertex> path = new LinkedList<Vertex>();
        LinkedList<Vertex> path2 = new LinkedList<Vertex>();

        Vertex step = target;
        // check if a path exists
        if (predecessors[step] == null) {
            return null;
        }
        path.add(step);
        while (predecessors[step] != null) {
            step = predecessors[step];
            path.add(step);
        }
        // Put it into the correct order
        // var lol = path.toList().reversed;
        // for(Vertex item in lol){
        //   path2.add(item);
        // }
        return path;
    }

}