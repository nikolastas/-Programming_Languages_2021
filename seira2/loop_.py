import sys
f = open("b.txt", "r")
sys.setrecursionlimit(9999)
N, M = f.readline().split()

N, M = int(N), int(M)

B= [[x for x in i] for  i in f.read().splitlines()]

counter = 0

def move(a, r, c):
    if a == 'U' :
         r -= 1
    if a == 'D' :
         r += 1
    if a == 'R' :
         c += 1
    if a == 'L' :
         c -= 1
    if a == 'W' :
        pass
    return (r,c)
        
#print(move(B[1][0], 1, 0))

def is_valid(r, c, N, M):
    return(c>=0 and c<M and r>=0 and r<N)
    
def from_block(r, c, N, M, B):
    #print(B[r][c],"from")
    
    U = is_valid(r + 1, c, N, M) and move(B[r+1][c], r + 1, c) == (r, c)
    D = is_valid(r - 1, c, N, M) and move(B[r-1][c], r - 1, c) == (r, c)
    L = is_valid(r, c + 1, N, M) and move(B[r][c + 1], r, c + 1) == (r, c)
    R = is_valid(r , c-1, N, M) and move(B[r][c-1], r, c-1) == (r, c)
    return(U, D, L, R)

def win_path(r, c, N, M, B):
    #print(B[r][c], r, c)
    counter = 1
    config = from_block(r, c, N, M, B)
    #print(config)
    if config[0]:
       counter += win_path(r + 1, c, N, M, B)
    if config[1]:
       counter += win_path(r - 1, c, N, M, B)
    if config[2]:
       counter += win_path(r , c+1, N, M, B)
    if config[3]:
       counter += win_path(r , c-1, N, M, B)
    return counter

#main
final_counter=0
for j in range(M):
    if B[0][j] == 'U':
        final_counter += win_path(0, j, N, M, B)
    if B[N - 1][j] == 'D':
        final_counter += win_path(N - 1, j, N, M, B)
for i in range(N):
    if B[i][0] =='L':
        final_counter += win_path(i,0,N,M,B)
    if B[i][M - 1] == 'R':
        final_counter += win_path(i,M-1,N,M,B)      
result = N * M - final_counter
print(result)
