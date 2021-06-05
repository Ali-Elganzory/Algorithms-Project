# Task algorithm
def find_fake_coin(coin_weight, coins, start, end, counter):
    if end - start == 0:
        return counter, start

    mid = start + int((end - start) / 2)
    actual_weight = sum(coins[start:mid + 1])
    expected_weight = (mid + 1 - start) * coin_weight

    if actual_weight != expected_weight:
        return find_fake_coin(coin_weight, coins, start, mid, counter + 1)
    else:
        return find_fake_coin(coin_weight, coins, mid + 1, end, counter + 1)


# Take user input and call algorithm
def task_5():
    print("**Note: instead of entering a long list of weight by hand,\nenter the number of coins, genuine weight, "
          "fake weight, and place of fake coin,\nand the list will be generated for you.\n")

    coins_count = int(input("Number of coins (including fake coin): "))
    fake_index = int(input("Place where the fake coin is to be placed at (between 1 and coins number): ")) - 1

    actual_weight = int(input("Weight of the genuine coin: "))
    fake_weight = int(input("Weight of the fake coin: "))

    generated_coin_list = [actual_weight for i in range(coins_count)]
    generated_coin_list[fake_index] = fake_weight
    print(f"The generated list of coins: {generated_coin_list}")

    (minimum_weightings, index) = find_fake_coin(actual_weight, generated_coin_list, 0, coins_count - 1, 0)
    print(f"The minimum number of weightings: {minimum_weightings} where the fake coin is at place {index+1}")


if __name__ == "__main__":
    task_5()
