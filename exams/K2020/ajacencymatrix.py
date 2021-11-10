def has_edge_mat(M, u, v):
  return M[u][v]

def adj_mat_list(M):
  G = []
  for i in range(len(M)):
    G.append([]) #initialize each row
    for j in range(len(M[i])):
      if(M[i][j]):
        G[i].append(j)
  return G

def has_edge_list(G, u, v):
  found = 0
  for j in range(len(G[u])):
    if(G[u][j] == v):
      found = 1
      break
  return found




A = [[1, 0], [0, 1]]
print(has_edge_mat(A, 1, 1))
print(has_edge_mat(A, 1, 0))
B = [[1, 1, 0],[0, 1, 1],[1, 0, 0]]
print(adj_mat_list(A))
print(adj_mat_list(B))
print(has_edge_list(A, 1, 0))
print(has_edge_list(B, 2, 2))