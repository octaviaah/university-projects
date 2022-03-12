import random

from domain.graph import Graph
from os import path

class UI:
    def __init__(self):
        pass

    def print_menu(self):
        print("0.exit program")
        print("1.read graph from a file")
        print("2.get the number of vertices")
        print("3.print the set of vertices")
        print("4.given 2 vertices, find out whether there is an edge from the first one to the second one")
        print("5.get the in degree and out degree of a specified vertex")
        print("6.get the set of outbound edges of a vertex")
        print("7.get the set of inbound edges of a vertex")
        print("8.add a vertex")
        print("9.remove a vertex")
        print("10.add an edge")
        print("11.remove an edge")
        print("12.get cost of edge")
        print("13.modify cost of edge")
        print("14.print current graph")
        print("15.save graph")
        print("16.copy graph")
        print("17.save copy of graph")
        print("18.create random graph and save it")
        print("19.print the menu again")
        print("20.connected components with dfs")
        print("21.hamiltonian cycle using heuristic of nearest neighbour")



    def read(self, file_name, read_type):
        with open(file_name, "r") as f:
            line = f.readline().split()
            if line[0] == "Graph":
                graph = "Graph cannot be generated!"
                return graph
            n = int(line[0])
            m = int(line[1])

            graph = Graph(n, m)

            if read_type == "shown":
                try:
                    for line in f.readlines():
                        line = line.split()
                        if len(line) == 1:
                            graph.add_vertex(int(line[0]))
                        else:
                            if graph.is_vertex(int(line[0])) == 0:
                                graph.add_vertex(int(line[0]))
                            if graph.is_vertex(int(line[1])) == 0:
                                graph.add_vertex(int(line[1]))
                            graph.add_edge(int(line[0]), int(line[1]), int(line[2]))

                except EOFError as eof:
                    f.close()
                return graph
            elif read_type == "hidden":
                try:
                    for index in range(n):
                        graph.add_vertex(index)
                    for line in f.readlines():
                        line = line.split()
                        if int(line[0]) >= n:
                            if graph.is_vertex(int(line[0])) == 0:
                                graph.add_vertex(int(line[0]))
                        if int(line[1]) >= n:
                            if graph.is_vertex(int(line[1])) == 0:
                                graph.add_vertex(int(line[1]))
                        graph.add_edge(int(line[0]), int(line[1]), int(line[2]))
                except EOFError as eof:
                    f.close()
                return graph


    def write(self, file_name, graph):
        f = open(file_name, "w")
        if graph == "Graph cannot be generated!":
            f.write(graph)
        else:
            data_str = str(graph.vertices) + " " + str(graph.edges) + '\n'
            f.write(data_str)
            for vertex in graph.parse_vertices():
                if graph.parse_edges_out(vertex) == [] and graph.parse_edges_in(vertex) == []:
                    isolated_vertex_str = str(vertex) + "\n"
                    f.write(isolated_vertex_str)
                for target_vertex in graph.parse_edges_in(vertex):
                    edge_str = str(vertex) + " " + str(target_vertex) + " " + str(graph.costs[(vertex, target_vertex)]) +\
                               "\n"
                    f.write(edge_str)
        f.close()

    def random_graph(self, v, e):
        if e > v*v:
            return -1
        g = Graph(v, e)
        while e > 0:
            x = random.randrange(v)
            y = random.randrange(v)
            c = random.randrange(-100, 101)
            if g.is_vertex(x) == 0:
                g.add_vertex(x)
            if g.is_vertex(y) == 0:
                g.add_vertex(y)
            if g.is_edge(x, y) == 0:
                g.add_edge(x, y, c)
                e -= 1
        return g

    def is_integer(self, x):
        try:
            int(x)
        except ValueError:
            return False
        return True

    def connected(self, components):
        '''
        a function which finds all the connected components in a graph
        :param components: an empty dictionary, used to add the connected components(key is the component and value
        is the list of edges)
        :return: the components dictionary
        '''
        for vertex in graph._dict_out.keys():
            visited = set()
            edges = []
            result, resed = graph.dfs(vertex, visited, edges)
            if tuple(result) not in components.keys():
                components[tuple(result)] = resed
        return components



if __name__ == '__main__':
    ui = UI()
    ui.print_menu()
    was_read = 0
    while True:
        command = input("enter command: ")
        if ui.is_integer(command) is False:
            print("Command must be int")
        else:
            command = int(command)
            if command == 0:
                exit(0)
            if command == 1:
                file_name = input("enter file name(include extension): ")
                if path.exists(file_name) is False:
                    print("File does not exist")
                else:
                    read_type = input("Do you want the isolated vertices to be shown or hidden? ")
                    if read_type not in ["shown", "hidden"]:
                        print("Incorrect read type")
                    else:
                        graph = ui.read(file_name, read_type)
                        if (graph == "Graph cannot be generated!"):
                            print(graph)
                        else:
                            was_read = 1
            if command == 2:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    print("The number of vertices is " + str(graph.vertices))
            if command == 3:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    print("The list of vertices is:")
                    print(str(sorted(graph._dict_out.keys())))
            if command == 4:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    vi = int(input("enter the starting vertex: "))
                    if graph.is_vertex(vi) == 0:
                        print("Starting vertex does not exist!")
                    else:
                        vout = int(input("enter the target vertex: "))
                        if graph.is_vertex(vout) == 0:
                            print("Target vertex does not exist!")
                        elif graph.is_edge(vi, vout) == 1:
                            print("There is an edge between " + str(vi) + " and " + str(vout))
                        else:
                            print("There is no edge")
            if command == 5:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    v = int(input("enter vertex: "))
                    if graph.is_vertex(v) == 0:
                        print("Vertex does not exist!")
                    else:
                        ind = graph.degree_in(v)
                        outd = graph.degree_out(v)
                        print("The in degree is " + str(ind) + " and the out degree is " + str(outd))
            if command == 6:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    v = int(input("enter vertex: "))
                    if graph.is_vertex(v) == 0:
                        print("Vertex does not exist!")
                    else:
                        outed = graph.parse_edges_out(v)
                        outed_str = ''
                        for ver in outed:
                            outed_str += str(v) + "->" + str(ver) + ", "
                        outed_str = outed_str[:-2]
                        if outed_str == '':
                            print("Vertex " + str(v) + " has no outbound edges.")
                        else:
                            print("The outbound edges of vertex " + str(v) + " are: " + outed_str)
            if command == 7:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    v = int(input("enter vertex: "))
                    if graph.is_vertex(v) == 0:
                        print("Vertex does not exist!")
                    else:
                        ined = graph.parse_edges_in(v)
                        ined_str = ''
                        for ver in ined:
                            ined_str += str(ver) + '->' + str(v) + ", "
                        ined_str = ined_str[:-2]
                        if ined_str == '':
                            print("Vertex " + str(v) + " has no inbound edges.")
                        else:
                            print("The inbound edges of vertex " + str(v) + " are: " + ined_str)
            if command == 8:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    v = int(input("enter vertex: "))
                    if graph.is_vertex(v) == 1:
                        print("Vertex already exists!")
                    else:
                        graph.add_vertex(v)
                        print("Vertex added")
            if command == 9:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    v = int(input("enter vertex: "))
                    if graph.is_vertex(v) == 0:
                        print("Vertex does not exist!")
                    else:
                        graph.remove_vertex(v)
                        print("Vertex removed")
            if command == 10:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    vin = int(input("enter starting vertex: "))
                    if graph.is_vertex(vin) == 0:
                        print("Starting vertex does not exist!")
                    else:
                        vout = int(input("enter target vertex: "))
                        if graph.is_vertex(vout) == 0:
                            print("Target vertex does not exist!")
                        elif graph.is_edge(vin, vout) == 1:
                            print("There is already an edge between the input vertices!")
                        else:
                            cost = int(input("enter cost: "))
                            graph.add_edge(vin, vout, cost)
                            print("edge added")
            if command == 11:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    vin = int(input("enter starting vertex: "))
                    if graph.is_vertex(vin) == 0:
                        print("Starting vertex does not exist!")
                    else:
                        vout = int(input("enter target vertex: "))
                        if graph.is_vertex(vout) == 0:
                            print("Target vertex does not exist!")
                        elif graph.is_edge(vin, vout) == 0:
                            print("There is no edge between the input vertices!")
                        else:
                            graph.remove_edge(vin, vout)
                            print("edge removed")
            if command == 12:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    vin = int(input("enter starting vertex: "))
                    if graph.is_vertex(vin) == 0:
                        print("Starting vertex does not exist!")
                    else:
                        vout = int(input("enter target vertex: "))
                        if graph.is_vertex(vout) == 0:
                            print("Target vertex does not exist!")
                        elif graph.is_edge(vin, vout) == 0:
                            print("There is no edge between the input vertices!")
                        else:
                            cost = graph.get_cost(vin, vout)
                            print("The cost of the edge is " + str(cost))
            if command == 13:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    vin = int(input("enter starting vertex: "))
                    if graph.is_vertex(vin) == 0:
                        print("Starting vertex does not exist!")
                    else:
                        vout = int(input("enter target vertex: "))
                        if graph.is_vertex(vout) == 0:
                            print("Target vertex does not exist!")
                        elif graph.is_edge(vin, vout) == 0:
                            print("There is no edge between the input vertices!")
                        else:
                            cost = int(input("enter new cost: "))
                            graph.modify_cost(vin, vout, cost)
                            print("cost modified")
            if command == 14:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    print("dict out")
                    for x in sorted(graph.parse_vertices()):  # this parses all vertices
                        line = str(x) + " :"
                        for y in sorted(graph.parse_edges_out(x)):
                            line = line + " " + str(y)
                        print(line)
                    """
                    print(" ")
                    print("dict in")

                    for x in sorted(graph.parse_vertices()):  # this parses all vertices
                        line = str(x) + " :"
                        for y in sorted(graph.parse_edges_in(x)):
                            line = line + " " + str(y)
                        print(line)
                        """
            if command == 15:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    file_split = file_name.split(".")
                    file_name_modif = file_split[0] + "_modif." + file_split[1]
                    ui.write(file_name_modif, graph)
                    print("Graph saved")
            if command == 16:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    graph._copy = graph.copy()
                    print("Graph copied")
            if command == 17:
                if was_read == 0:
                    print("Graph has not been read yet")
                elif graph._copy == []:
                    print("Graph has no copy!")
                else:
                    file_split = file_name.split(".")
                    file_name_copy = file_split[0] + "-copy." + file_split[1]
                    ui.write(file_name_copy, graph._copy)
                    print("Copy of graph saved")
            if command == 18:
                v = int(input("enter number of vertices: "))
                if v <= 0:
                    print("Incorrect number of vertices")
                else:
                    e = int(input("enter number of edges: "))
                    if e<= 0:
                        print("Incorrect number of edges")
                    else:
                        graph = ui.random_graph(v, e)
                        file_name = input("enter file name(with extension): ")
                        if graph == -1:
                            ui.write(file_name, "Graph cannot be generated!")
                        else:
                            ui.write(file_name, graph)
                        print("Random graph saved")
            if command == 19:
                ui.print_menu()
            if command == 20:
                '''
                pretty printing code -  it creates the graph objects for the components and it also prints them
                '''
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    components = {}
                    components = ui.connected(components)
                    graph_objs = []
                    i = 1
                    for component in components.keys():
                        edge_list = []
                        for edge in components[component]:
                            for edge_cost in graph.costs.keys():
                                if edge == edge_cost:
                                    edge_list.append(tuple([edge_cost[0], edge_cost[1], graph.costs[edge_cost]]))
                        graph_obj = Graph(len(component), len(edge_list))
                        for vertex in component:
                            graph_obj.add_vertex(vertex)
                        for edge in edge_list:
                            graph_obj.add_edge(edge[0], edge[1], edge[2])
                        graph_objs.append(graph_obj)
                        file_split = file_name.split(".")
                        file_name_modif = file_split[0] + "_comp" + str(i) + "." + file_split[1]
                        ui.write(file_name_modif, graph_obj)
                        i+=1
                        if len(edge_list) != 0:
                            print("Component has the vertices " + str(sorted(graph_obj._dict_out.keys())) + " and edges "
                              + str(components[component]))
                        else:
                            print("Component has the vertex " + str(sorted(graph_obj._dict_out.keys())) + " and no "
                                                                                                          "other edges")
            if command == 21:
                if was_read == 0:
                    print("Graph has not been read yet")
                else:
                    visited = []
                    path = []
                    save_path, save_cost = graph.heuristic(visited, path)
                    if save_cost == 10000:
                        print("The graph does not have a Hamiltonian cycle")
                    else:
                        print("The minimum cost is " + str(save_cost))
                        print(save_path)
            if command not in range(0, 22):
                print("bad command")





