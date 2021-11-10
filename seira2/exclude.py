


N, M = map(int , input().split())
A = map(int ,input().split())
B = list(map(int ,input().split()))
# for a in A: # this solution is N times M -> O(N*M)
#    if a not in B:
#        print(a)

#pio wraia lysh

#L=[str(a) for a in A if a not in B]
#print(" ".join(L))

#
#print(" ".join(str(a) for a in A if a not in B))
print(*(str(a) for a in A if a not in B))

