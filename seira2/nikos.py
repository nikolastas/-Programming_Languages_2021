f = open("glwsses1/seira2/b.txt", "r")

N, M = f.readline().split()

N, M = int(N), int(M) # N are rows, M is colums
print(N,M)
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


def winner(a,r,c,N,M):
    (i,j) = move(a, r, c)
    return(not (j>=0 and j<M and i>=0 and i<N))
    
def is_valid(r, c, N, M):
    return(c>=0 and c<M and r>=0 and r<N)
    
def from_block(r, c, N, M, B):
    if B[r][c] != 'W':
        if winner(B[r][c],r,c,N,M) :
            B[r][c]='W'

    
    U = is_valid(r + 1, c, N, M) and move(B[r+1][c], r + 1, c) == (r, c)
    D = is_valid(r - 1, c, N, M) and move(B[r-1][c], r - 1, c) == (r, c)
    L = is_valid(r, c + 1, N, M) and move(B[r][c + 1], r, c + 1) == (r, c)
    R = is_valid(r , c-1, N, M) and move(B[r][c-1], r, c-1) == (r, c)
    return(U, D, L, R)




def win_path(r, c, N, M, B):
    #print(B[r][c], r, c)
    counter=1
    config = from_block(r, c, N, M, B)
    if not(config[0] or config[1] or config[2] or config[3]):
        B[r][c]='W'
    #print(config)
    if config[0]:
       counter+= (win_path(r + 1, c, N, M, B))
    if config[1]:
       counter += (win_path(r - 1, c, N, M, B))
    if config[2]:
       counter += (win_path(r , c+1, N, M, B))
    if config[3]:
       counter += (win_path(r , c-1, N, M, B))
    return counter

#main
final_counter=0

         
#result = N * M - (final_counter)
#print(result)