# Reference: http://pgm.stanford.edu/Algs/page-75.pdf
# Find nodes reachable from X given Z via active trails

class BayesNet(object):
    def __init__(self, G):
        # G: adjacency list
        self.Ch = G
        self.Pa = self.__inverted_graph(G)
        
    def reachable(self, X, Z):
        # ToDo: check both X and Z are belonged to G
        Ch = self.Ch
        Pa = self.Pa
    
        # Phase 1: Insert all ancestors of Z into A
        L = Z[:] # nodes to be visited
        A = set() # ancestors of Z
    
        while not L:
            Y = L.pop()
            if Y not in A:
                L.extend(Pa[Y]) 
            A.add(Y)
    
        # Phase 2: Traverse active trails starting from X
        L = [(X, 1)] # to be visited, [(node, direction)], 1 -> start, 0 -> end
        V, R = [], [] # visited, reachable
    
        while not L:
            Y, d = L.pop()
            if (Y, d) not in V:
                V.append((Y, d))
                
                if Y not in Z:
                    R.append(Y)
                    
                if d = 1 and Y not in Z:
                    for z in Pa[Y]:
                        L.append((z, 1))
                    for z in Ch[Y]:
                        L.append((z, 0))
                elif d = 0:
                    if Y not in Z:
                        for z in Ch[Y]:
                            L.append((z, 0))
                    if Y in A:
                        for z in Pa[Y]:
                            L.append((z, 1))
        return R
                
    def __inverted_graph(self, G):
        # same as inverted index for Web Search Engine
        IG = {}
        for v in G:
            for child in G[v]:
                if child in IG:
                    IG[child].append(v)
                else:
                    IG[child] = [v]
        return IG
