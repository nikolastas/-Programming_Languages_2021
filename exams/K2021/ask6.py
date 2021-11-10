
aList=[4,1, 4, 2, 3, 2, 1, 3, 4, 2]
k=aList.pop(0)
x=0
index1=0;
index2=index1+k
resultList=[]
for substring in range(0, len(aList)-k+1):
    resultList.append(sum(aList[index1:index2]))
    index1=index1+1
    index2=index2+1;
""" https://www.geeksforgeeks.org/python-find-most-frequent-element-in-a-list/
"""
print(resultList)
counter = 0
num = resultList[0]
for x in (resultList) :
    result = resultList.count(x)
    if(result> counter):
        counter = result
        num = x
  
print(num)