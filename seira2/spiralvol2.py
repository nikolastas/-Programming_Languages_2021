def spiralOrder(matrix,R,C):
    temp = []
    ans=[]
    if (len(matrix) == 0):
        return temp
    seen = [[0 for i in range(C)] for j in range(R)]
    dr = [ 0, 1, 0, -1 ]
    dc = [ 1, 0, -1, 0 ]
    r = 0
    c = 0
    di = 0
    for i in range(R * C):
        temp.append(matrix[r][c])
        temp.append(r)
        temp.append(c)
        
        seen[r][c] = True
        cr = r + dr[di]
        cc = c + dc[di]
        if (0 <= cr and cr < R and 0 <= cc and cc < C and not(seen[cr][cc])):
            r = cr
            c = cc
            #ans.append(temp)
        else:
            di = (di + 1) % 4
            r += dr[di]
            c += dc[di]
            #ans.append(temp)
    return temp

a = [[ 1, 2, 3, 4 ],
    [ 5, 6, 7, 8 ],
    [ 9, 10, 11, 12 ],
    [ 13, 14, 15, 16 ]]


f = open("b.txt", "r")

N, M = f.readline().split()

N, M = int(N), int(M) # N are rows, M is colums

print(N, M)

B= [[x for x in i] for  i in f.read().splitlines()]
counter = 0
s=spiralOrder(B,N,M)
print(s)
def move(a, r, c):
    if a == 'U' :
         r -= 1
    elif a == 'D' :
         r += 1
    elif a == 'R' :
         c += 1
    elif a == 'L' :
         c -= 1
    elif a == 'W':
        r,c=-1,-1
    return (r,c)

def is_valid(r, c, N, M):
    return(c>=0 and c<M and r>=0 and r<N)
def winner(a,r,c,N,M,B):
    (i,j) = move(a, r, c)
    if(i==-1 and j==-1):
        return True
    else:
        
        x=((not (j>=0 and j<M and i>=0 and i<N)) or B[i][j]=='W' )
        #print("checking:",a,r,c,"is moving to",i,j, x)
        return((not (j>=0 and j<M and i>=0 and i<N)) or B[i][j] == 'W' )
counter=0
lamda=True
while lamda:
    lamda=False
    for x in range(0,len(s),3):
        a=s[x]
        r=int(s[x+1])
        c=int(s[x+2])
        if(winner(a,r,c,N,M,B)):
            lamda=True
            #print(a," ",r," ",c)
            counter +=1
            B[r][c]='W'
print(B)
print(M*N-counter)

