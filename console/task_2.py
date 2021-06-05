# Task algorithm
def dpMagicSqr(n, count):
    # create an empty matrix
    matrix = [[0 for x in range(n)] for y in range(n)]
    # initialize position of 1
    i = 1
    j = 2
    # Fill the magic square by placing values
    num = 1
    while num <= 9:
        if i == -1 and j == 3:  # 3rd condition
            j = 1
            i = 0
        else:
            # next number goes out of right side of square
            if j == 3:
                j = 0
            # next number goes out of upper side
            if i < 0:
                i = 2
        if matrix[int(i)][int(j)]:  # 2nd condition
            j = j - 2
            i = i + 1
            continue
        else:
            matrix[int(i)][int(j)] = num
            num = num + 1
        j = j + 1
        i = i - 1  # 1st condition

    magicNum = 1  # to memoize number of Magic squares
    for iterator in range(3, n):  # building the n x n table using the generated 3*3 sub-problem
        for row in range(0, iterator):
            matrix[row][iterator] = matrix[row][iterator - 3]
        for col in range(0, iterator + 1):
            matrix[iterator][col] = matrix[iterator - 3][col]
        for it in range(1, iterator):
            if matrix[it][iterator - 1] == 5:
                magicNum = magicNum + 1
            if matrix[iterator - 1][it] == 5 and it != iterator - 1:
                magicNum = magicNum + 1
    for row in range(0, n):
        for col in range(0, n):
            print(str(matrix[row][col]) + "   ", end=" ")
        print("\n")
    if count == 1:
        print("\nThe number of possible Magic Squares in an " + str(n) + "*" + str(n) + " table is " + str(
            magicNum) + "\n")


# Take user input and call algorithm
def task_2():
    n = int(input("Enter the dimension n of your n*n table: "))
    count = int(input("If you want the number of Magic squares, enter 1: "))
    if n < 3:
        print("\ntable dimensions must be higher than 2 ...")
    else:
        print("\nYour table is generated: \n")
        dpMagicSqr(n, count)


if __name__ == "__main__":
    task_2()
