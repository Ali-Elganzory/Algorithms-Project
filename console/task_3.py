#Task algorithm

def minSwitches(m):
    lamp = []

    feasible_solution = m

    for i in range(m):
        lamp.append(0)

    for j in range(m):
        if (not (lamp[j - 1] or lamp[j] or lamp[j + 1])):
            lamp[j - 1] = 1
            lamp[j] = 1
            lamp[j + 1] = 1
            feasible_solution = feasible_solution - 2

    sum = 0
    for k in range(m):
        sum=sum+lamp[k]

    if sum == m:
        return feasible_solution
    else:
        return m


#Task user input and call algorithm

def Task_3():
    n = int(input("Enter number of lamps: "))

    print (f"Minimum number of switches = {minSwitches(n)}")