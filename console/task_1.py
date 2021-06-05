from math import ceil


# Task algorithm
def minimum_cuts(stick_length):
    # List of all stick pieces
    pieces = [stick_length]
    cuts = 0
    # If not all cut to 1-unit pieces, continue cutting
    while len(pieces) < stick_length:
        cuts += 1
        # Cut all pieces in one go
        new_pieces = []
        for piece in pieces:
            new_pieces.extend([ceil(piece / 2), piece // 2] if piece != 1 else [piece])
        pieces = new_pieces

    return cuts


# Take user input and call algorithm
def task_1():
    stick_length = int(input("Enter the length of the stick: "))
    cuts = minimum_cuts(stick_length)

    print(f"The minimum number of cuts is {cuts}")


if __name__ == "__main__":
    task_1()
