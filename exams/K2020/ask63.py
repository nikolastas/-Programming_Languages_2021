def adj_list_mat(G):
    """ O(n*n), where n == len(G)"""
    n = len(G)
    M = [[0]*n for _ in range(n)]
    for v in range(n):
        for neighbor in G[v]:
            M[v][neighbor] = 1
    return M

def out_degree(M, u):
    """ O(n) where n == len(M[u]) == len(M[0]) """
    return sum(M[u])

def in_degree(M, u):
    """ O(n) where n == len(M)"""
    return sum(M[i][u] for i in range(len(M)))

def test():
    G = [
        [1, 2],
        [0],
        [0, 1, 3],
        [0]
    ]
    M = adj_list_mat(G)
    for row in M:
        print(row)
    print(out_degree(M, 2)) #expected: 3
    print(in_degree(M, 2)) #expected: 1
test()