def winner(a,r,c,N,M):
    (i,j) = move(a, r, c)
    return(not (j>=0 and j<M and i>=0 and i<N))

def spiral(matrix,r,c):
    total=r*c
    minr=0
    minc=0
    maxr=r-1
    maxc=c-1
    count=0
    mylist=[]
    while(count<total):
        for i in range(minc,maxc+1):
            if(count<total):
                mylist.append(matrix[minr][i],minr,i)
                count=count+1
        minr=minr+1
        for i in range(minr,maxr+1):
            if(count<total):
                mylist.append(matrix[i][maxc],i,maxc)
                count=count+1
        maxc=maxc-1
        for i in range(maxc,minc-1,-1):
            if(count<total):
                mylist.append(matrix[maxr][i],maxr,i)
                count=count+1
        maxr=maxr-1
        for i in range (maxr,minr-1,-1):
            if(count<total):
                mylist.append(matrix[i][minc],i,minc)
                count=count+1
        minc=minc+1
    return mylist
f = open("glwsses1/seira2/b.txt", "r")

N, M = f.readline().split()

N, M = int(N), int(M) # N are rows, M is colums

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
        

def spir(n, m, a) : 
    # for i in a:
    #     print(i)
    # print("-------------------------------")
    i = 0
    j = 0
    k = 2*n + 2*(m-2) 
    c = 0 
    counter=0
    if m == 0 or n == 0:
        return counter
    
    if m == 1 or n == 1:
        for i in a:
            for j in i:
                counter += 1
                #print(j, end = " ")
        return counter
    
    while c < k:
        #(row,colum)=move(B,N,M)
        if( winner(a[i][j],i,j,N,M)):
            counter+=1
            #print(counter)
            print(a[i][j],i,j)
        if i == n-1 and j > 0:
            j -= 1
        elif i<=j and j < m-1:
            j += 1
        elif j == m-1 and i < n-1:
            i += 1
        else:
            i -= 1
        c += 1
    
    spir(n-2, m-2, [a[i][1:-1] for i in range(1, n-1)]) 
    return counter

print(spir(N,M,B))
