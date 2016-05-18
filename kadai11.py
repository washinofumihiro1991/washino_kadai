S_number = [int(i) for i in range(1,14)]
H_number = [int(i) for i in range(1,14)]
C_number = [int(i) for i in range(1,14)]
D_number = [int(i) for i in range(1,14)]


n = int(input())

for i in range(1,n+1):
    cord = input().split()
    if cord[0] == "S":
        S_number.remove(int(cord[1]))
        #print(cord)
    elif cord[0] == "H":
        H_number.remove(int(cord[1]))
        #print(cord)
    elif cord[0] == "C":
        C_number.remove(int(cord[1]))
        #print(cord)
    elif cord[0] == "D":
        D_number.remove(int(cord[1]))

if len(S_number) != 0:
    for i in range(len(S_number)):
        print("S {0}".format(S_number[i]))
if len(H_number) != 0:
    for i in range(len(H_number)):
        print("H {0}".format(H_number[i]))
if len(C_number) != 0:
    for i in range(len(C_number)):
        print("C {0}".format(C_number[i]))
if len(D_number) != 0:
    for i in range(len(D_number)):
        print("D {0}".format(D_number[i]))

