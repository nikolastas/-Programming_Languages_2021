from collections import deque


from os import read

import sys


class state:
    def __init__(self, q, s):
        self.q = tuple(self[0])
        self.s = tuple(self[1])


def finalstate(s):
    if s[1]:
        return False
    else:
        return all(s[0][i] <= s[0][i+1] for i in range(len(s[0])-1))

f = open(sys.argv[1], "r")
N=f.readline()
B=f.readline().split()

B=[int(x) for x in B]

ban_string = 'QS' * int(N)
#print(ban_string)

test=deque(B),list()
if (finalstate(test)):
    print("empty")
    exit()

init = ((B[1:]), [B[0]])  #Q: popleft(), append, S: pop(), append


def next(s, answer):
    #print("s[0]:", s[0])
    #print("s[1]:",s[1]) 
    newlist=s[0][:],s[1][:]
    #print("newlist is :",newlist)
    if s[0]:
        popleft=s[0][1:]
        s[1].append(s[0][0])
        yield((popleft, s[1]), answer+"Q")
        #s[0].appendleft(s[1].pop()) #recover
    #print("s[0]2", s[0])
    #print("s[1]2", s[1]) #ok
    if newlist[1]:
        newlist[0].append(newlist[1].pop())
        yield((newlist[0],newlist[1]), answer + "S")
    #print("s[0]3", newlist[0])
    #print("s[1]3", newlist[1])

prev={hash((tuple(init[0]),tuple(init[1]))): None}
#print(prev)
#solved=False
moves = deque([(init, "Q")])
prevlen = 1
#len_of_next=0
#len_of_prev=0
#len_of_moves=0
while moves:
    #len_of_moves+=1
    #print("moves : ",moves)
    x = moves.popleft()
    
    #print(x)
    #if ban_string in x[1]:
    #    continue

    #lenx=len(x[1])
    #if lenx > prevlen:
        #prevlen = lenx
        #print(x[1])
    #print(x)
    if len(x[1]) % 2 == 0 and finalstate(x[0]):
        break

    #newprev=prev[:]
    for t in next(x[0], x[1]):
        #len_of_next+=1
        #print("t is : ",t)
        
        #print("here")
        if hash((tuple(t[0][0]), tuple(t[0][1]))) not in prev:
            #print("[before append] prev is:", newprev)
            prev[hash((tuple(t[0][0]), tuple(t[0][1])))]=None
            #len_of_prev+=1
            #prev=newprev[:]
            #print("[after append] prev is:", newprev)
            moves.append(t)


print( x[1])