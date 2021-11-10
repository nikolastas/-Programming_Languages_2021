def countsumk_ON(A, K):
    seen = {0: 1}
    sum = result = 0
    for x in A:
        sum += x
        if sum - K in seen:
            result += seen[sum - K]
        if sum in seen:
            seen[sum] += 1
            print(sum)
        else:
            seen[sum] = 1
    return result

print(countsumk_ON([1,2,3,1,2,3,0,3], 3))