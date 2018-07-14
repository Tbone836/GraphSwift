class Vertice{
    var name: String?
    var age: Int?
    init(name: String?, age: Int?){
        self.name = name
        self.age = age
        
    }
}


class Edge{
    var start: Vertice
    var end: Vertice
    var value: Int?
    init(start: Vertice, end: Vertice, value: Int?){
        self.start = start
        self.end = end
        self.value = value
    }
    func endpoints() -> (Vertice, Vertice) {
        return (start, end)
    }
    func opposite (vertex: Vertice) -> Vertice{
        if (vertex.name == start.name) && (vertex.age == start.age) {
            return(end)
        }
        else if (vertex.name == end.name) && (vertex.age == end.age){
            return(start)
        }
        else{
            print ("error")
            return(vertex)
        }
    }
}


class Graph{
    var number_of_vertices: Int = 0
    var number_of_edges: Int = 0
    
    var vertices: [Vertice] = []
    var edges: [Edge] = []
    
    func vertex_count() -> Int {
        return number_of_vertices
    }
    func insert_vertex(name: String, age: Int) {
        var newVertex = Vertice(name: name, age: age)
        vertices.append(newVertex)
        number_of_vertices += 1
    }
    
    func printNames() -> [String]{
        var returnedArray: [String] = []
        for vertex in vertices{
            if let personName = vertex.name {
                returnedArray.append(personName)
            }
        }
        return returnedArray
    }
    
    func insert_edge(beforeName: String, afterName: String, value: Int?){
        var firstVertex:Vertice?
        var secondVertex:Vertice?
        for vertex in vertices{
            if vertex.name == beforeName{
                firstVertex = vertex
            }
            if vertex.name == afterName{
                secondVertex = vertex
            }
        }
        if let start = firstVertex, let end = secondVertex {
            var newEdge = Edge(start: start, end: end, value: value)
            edges.append(newEdge)
            number_of_edges += 1
        }
    }
    
    func return_edge(beforeName: String, afterName: String) -> Edge?{
        var firstVertex: Vertice?
        var secondVertex: Vertice?
        for vertex in vertices{
            if vertex.name == beforeName{
                firstVertex = vertex
            }
            if vertex.name == afterName{
                secondVertex = vertex
            }
        }
        if let start = firstVertex, let end = secondVertex{
            for edge in edges{
                if (edge.start.name == start.name) && (edge.start.age == start.age){
                    if (edge.end.name == end.name) && (edge.end.age == end.age){
                        return edge
                    }
                }
                if (edge.end.name == start.name) && (edge.end.age == start.age){
                    if (edge.start.name == end.name) && (edge.start.age == end.age){
                        return edge
                    }
                }
            }
        }
        return nil
    }
    func degree(name: String)-> Int{
        var centralVertex: Vertice?
        for vertex in vertices{
            if name == vertex.name{
                centralVertex = vertex
            }
        }
        var count = 0
        if let newVertex = centralVertex{
            for edge in edges{
                if (edge.end.name == newVertex.name) && (edge.end.age == newVertex.age){
                    count+=1
                }
            }
            for edge in edges{
                if (edge.start.name == newVertex.name) && (edge.start.age == newVertex.age){
                    count+=1
                }
            }
        }
        return count
    }
    func incident_edges(vertex: Vertice) -> [Edge]{
        var listOfIncidentEdges: [Edge] = []
        for edge in edges{
            if (edge.end.name == vertex.name) && (edge.end.age == vertex.age){
                listOfIncidentEdges.append(edge)
            }
        }
        for edge in edges{
            if (edge.start.name == vertex.name) && (edge.start.age == vertex.age){
                listOfIncidentEdges.append(edge)
            }
        }
        return listOfIncidentEdges
    }
    func remove_vertex(name: String){
        var centralVertex: Vertice?
        for vertex in vertices{
            if name == vertex.name{
                centralVertex = vertex
            }
        }
        var index = 0
        if let vertex = centralVertex{
            for possible_vertex in vertices{
                if(vertex.name == possible_vertex.name)&&(vertex.age == possible_vertex.age){
                    vertices.remove(at: index)
                    number_of_vertices -= 1
                }
                index += 1
            }
        }
        
    }
    func remove_edge(startName: String, endName: String){
        var firstVertex: Vertice?
        var secondVertex: Vertice?
        for vertex in vertices{
            if vertex.name == startName{
                firstVertex = vertex
            }
            if vertex.name == endName{
                secondVertex = vertex
            }
        }
        var index = 0
        if let startVertex = firstVertex, let endVertex = secondVertex{
            for edge in edges{
                if (edge.start.age == startVertex.age) && (edge.start.name == startVertex.name){
                    if(edge.end.age == endVertex.age) && (edge.end.name == endVertex.name){
                        edges.remove(at: index)
                        number_of_edges -= 1
                    }
                }
                index += 1
            }
        }
    }
}

var newGraph = Graph()
newGraph.insert_vertex(name: "Thomas", age: 15)
newGraph.insert_vertex(name: "Alan", age: 17)
newGraph.insert_vertex(name: "Justin", age: 13)
newGraph.insert_vertex(name: "Cameron", age: 14)
newGraph.insert_vertex(name: "David", age: 11)
newGraph.insert_vertex(name: "Jonah", age: 27)

newGraph.insert_edge(beforeName: "Thomas", afterName: "Alan", value: 17)
newGraph.insert_edge(beforeName: "Thomas", afterName: "Justin", value: 13)
newGraph.insert_edge(beforeName: "Thomas", afterName: "Cameron", value: 8)
newGraph.insert_edge(beforeName: "Thomas", afterName: "David", value: 1)
newGraph.insert_edge(beforeName: "Thomas", afterName: "Jonah", value: 2)
print(newGraph.number_of_edges)
print(newGraph)
print(newGraph.number_of_vertices)
print(newGraph.vertices)
print(newGraph.degree(name: "Thomas"))
newGraph.remove_edge(startName: "Thomas", endName: "Jonah")
print(newGraph.number_of_edges)
newGraph.remove_vertex(name: "Cameron")
print(newGraph.number_of_vertices)
