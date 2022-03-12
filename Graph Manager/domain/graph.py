


class Graph:
    def __init__(self, vertices, edges):
        self._vertices = 0
        self._edges = 0
        self._dict_costs = {}
        self._dict_in = {}
        self._dict_out = {}
        self._copy = []

    @property #theta(1)
    def vertices(self):
        return self._vertices

    @property #theta(1)
    def edges(self):
        return self._edges

    @property #theta(1)
    def costs(self):
        return self._dict_costs

    def parse_vertices(self): #theta(1)
        return self._dict_out.keys()

    def parse_edges_in(self, vertex): #theta(1)
        return self._dict_in[vertex]

    def parse_edges_out(self, vertex): #theta(1)
        return self._dict_out[vertex]

    def degree_in(self, vertex): #theta(1)
        return len(self._dict_out[vertex])

    def degree_out(self, vertex): #theta(1)
        return len(self._dict_out[vertex])

    def is_vertex(self, vertex): #O(1)
        if vertex in self._dict_out.keys():
            return 1
        return 0

    def is_edge(self, vertex_in, vertex_out): #O(deg_out(vertex_in)+deg_in(vertex_out))
        if vertex_out not in self._dict_out[vertex_in]:
            return 0
        return 1

    def add_edge(self, vertex_in, vertex_out, cost): #O(1)
        if self.is_edge(vertex_in, vertex_out) == 0:
            self._dict_out[vertex_in].append(vertex_out)
            self._dict_in[vertex_in].append(vertex_out)
            self._dict_out[vertex_out].append(vertex_in)
            self._dict_costs[(vertex_in, vertex_out)] = cost
            self._dict_costs[(vertex_out, vertex_in)] = cost
            self._edges += 1

    def remove_edge(self, vertex_in, vertex_out): #O(1)
        if self.is_edge(vertex_in, vertex_out) == 1:
            self._dict_out[vertex_in].remove(vertex_out)
            self._dict_in[vertex_in].remove(vertex_out)
            self._dict_out[vertex_out].remove(vertex_in)
            self._dict_costs.pop((vertex_in, vertex_out))
            self._dict_costs.pop((vertex_out, vertex_in))
            self._edges -= 1

    def dfs(self, v, visited, edges):
        '''
        a recursive depth first search
        :param v: starting vertex
        :param visited: a set which keeps track of all the visited vertices
        :param edges: a list which keep track of all the visited edges
        :return: the set of visited vertices and the list of visited edges
        '''
        if v not in visited:
            visited.add(v)
            for w in self.parse_edges_out(v):
                if tuple([v, w]) not in edges and tuple([w, v]) not in edges:
                    edges.append(tuple([v, w]))
                self.dfs(w, visited, edges)
        return visited, edges

    def add_vertex(self, vertex): #O(1)
        if self.is_vertex(vertex) == 0:
            self._dict_in[vertex] = []
            self._dict_out[vertex] = []
            self._vertices += 1

    def remove_vertex(self, vertex): #O(deg_in(vertex)+deg_out(vertex))
        if self.is_vertex(vertex) == 1:
            for v in self.parse_edges_in(vertex):
                self._dict_out[v].remove(vertex)
                self._dict_costs.pop((v, vertex))
            for v in self.parse_edges_out(vertex):
                self._dict_in[v].remove(vertex)
                self._dict_costs.pop(vertex, v)
            self._dict_out.pop(vertex)
            self._dict_in.pop(vertex)
            self._vertices -= 1

    def get_cost(self, vertex_in, vertex_out): #O(1)
        if self.is_edge(vertex_in, vertex_out) == 1:
            return self._dict_costs[(vertex_in, vertex_out)]

    def modify_cost(self, vertex_in, vertex_out, new_cost): #O(1)
        if self.is_edge(vertex_in, vertex_out) == 1:
            self._dict_costs[(vertex_in, vertex_out)] = new_cost
            self._dict_costs[(vertex_out, vertex_in)] = new_cost

    def choose(self, last, visited):
        min = 10000 #we initialize the minimums
        vertex_min = -1
        for j in range(0, self._vertices):
            if visited[j] == 0: #if the vertex was not visited
                if self.get_cost(last, j) != None and self.get_cost(last, j) < min: #if we have an edge and the cost
                    # of the edge is less than the minimum
                    min = self.get_cost(last, j) #we update the minimums
                    vertex_min = j
        return vertex_min, min #the nearest neighbour is returned

    def heuristic(self, visited, path):
        save_cost = 10000 #initialize save_path and sav_cost
        save_path = []
        if path == []: #if the lists are empty
            for j in range(0, self.vertices): #initialize every element in the lists from 0 to n with 0
                visited.append(0)
                path.append(0)
                save_path.append(0)

        for i in range(0, self.vertices): #for every vertex
            for j in range(0, self.vertices):
                visited[j] = 0 #no point is visited
                path[j] = 0
            path[0] = i #first element of the path is vertex i
            visited[i] = 1 #i was visited
            count = 1 #we visited one vertex, so the count is 1
            cost = 0 #we don't have a cost yet
            for j in range(0, self.vertices-1):
                vertex_min, min = self.choose(path[count-1], visited) #we find the nearest neighbour
                if vertex_min != -1: #if the neighbour exists
                    path[count] = vertex_min #we add it to the path
                    visited[vertex_min] = 1 #we check it in the visited list
                    count+=1 #increase the count
                    cost+=min #increase the cost with min
            if self.get_cost(path[self.vertices-1], i) != None and count == self.vertices: #at the end, if the last
                # vertex of the path and the starting vertex have an edge between them and all the vertices were visited
                cost += self.get_cost(path[self.vertices-1], i) #we increase the cost to complete the cycle
                if cost < save_cost: #if the cost of the new cycle is less than the one from the saved path
                    for j in range(0, self.vertices): #we update the data
                        save_path[j] = path[j]
                    save_cost = cost
        save_path.append(save_path[0]) #at the end, we add the first vertex at the end as well so the cycle is complete
        return save_path, save_cost

    def copy(self): #O(vertices+edges)
        graph_c = Graph(self._vertices, self._edges)
        for vertex in self.parse_vertices():
            graph_c.add_vertex(vertex)
        for edge in self.costs.keys():
            graph_c.add_edge(edge[0], edge[1], self.costs[edge])
        return graph_c



