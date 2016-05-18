a, b = (int(i) for i in input().split())
while a != 0 or b != 0:
    count = 0
    for i in range(1, a-1):
        for j in range(i+1 , a):
            for k in range(i+2, a+1):
                if i + j + k == b and i < j < k:
                    count += 1
    print("{0}".format(count))
    a, b = (int(i) for i in input().split())
