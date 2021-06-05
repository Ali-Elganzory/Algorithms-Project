import numpy as np


class Grid
    def __init__(self)
        self.n = None
        self.m = None
        self.tromino_list = [
            [(0, 0), (1, 0), (1, -1)],
            [(0, 0), (0, 1), (1, 1)],
            [(0, 0), (1, 0), (0, 1)],
            [(0, 0), (1, 0), (1, 1)]
        ]

    def get(self, n, m, end_grid)
        self.n = n
        self.m = m

        start_grid = tuple(tuple(False for j in range(self.m)) for i in range(self.n))
        end_grid = self._list_to_tuple(end_grid)
        solution = [{start_grid 0}]

        while True
            top = list(solution[-1].keys())[0]
            number = solution[-1][top]
            empty_cell = self._get_first_empty_cell(top, end_grid)
            if empty_cell == None
                return solution[-1]
            x = solution.pop(-1)
            for tromino in self.tromino_list
                next_grid = self._place_tromino(top, tromino, empty_cell, end_grid, number)
                if not next_grid
                    continue
                solution.append({next_grid number + 1})

    def _get_first_empty_cell(self, grid, end_grid)
        for i in range(self.n)
            for j in range(self.m)
                if not grid[i][j] and end_grid[i][j]
                    return (i, j)
        return None

    def _place_tromino(self, grid, tromino, empty_cell, end_grid, number)
        empty_cell_x, empty_cell_y = empty_cell
        for tromino_x, tromino_y in tromino
            x = empty_cell_x + tromino_x
            y = empty_cell_y + tromino_y
            if x  0 or x = self.n or y  0 or y = self.m
                return None
            if grid[x][y] != False
                return None
            if not end_grid[x][y]
                return None
        result = [[False for j in range(self.m)] for i in range(self.n)]
        for i in range(self.n)
            for j in range(self.m)
                result[i][j] = grid[i][j]
        for tromino_x, tromino_y in tromino
            x = empty_cell_x + tromino_x
            y = empty_cell_y + tromino_y
            result[x][y] = number
        return self._list_to_tuple(result)

    def _list_to_tuple(self, grid)
        return tuple(tuple(row) for row in grid)

    def _tuple_to_list(self, grid)
        return [list(row) for row in grid]


n = 16
end_grid = [[True for j in range(n)] for i in range(n)]
end_grid[1][int(n  2) - 1] = False
end_grid[1][int(n  2)] = False
end_grid[2][int(n  2) - 1] = False
end_grid[2][int(n  2)] = False
x = Grid().get(n, n, end_grid)
number_of_tiles = list(x.values())[0]
grid = list(x.keys())[0]

# Python3 program to place tiles
size_of_grid = 64
b = 0
a = 0
cnt = 0
arr = [[0 for i in range(size_of_grid)] for j in range(size_of_grid)]
arr = np.array(arr)


def place(x1, y1, x2, y2, x3, y3)
    global cnt
    cnt += 1
    arr[x1][y1] = cnt
    arr[x2][y2] = cnt
    arr[x3][y3] = cnt


def tile_rec(n, x, y)
    global cnt
    r = 0
    c = 0
    if (n == 2)
        cnt += 1
        for i in range(n)
            for j in range(n)
                if (arr[x + i][y + j] == 0)
                    arr[x + i][y + j] = cnt
        return 0

    for i in range(x, x + n)
        for j in range(y, y + n)
            if (arr[i][j] != 0)
                r = i
                c = j

    if (r  x + n  2 and c  y + n  2)
        place(x + int(n  2), y + int(n  2) - 1, x + int(n  2), y + int(n  2), x + int(n  2) - 1, y + int(n  2))

    elif (r = x + int(n  2) and c  y + int(n  2))
        place(x + int(n  2) - 1, y + int(n  2), x + int(n  2), y + int(n  2), x + int(n  2) - 1,
              y + int(n  2) - 1)

    elif (r  x + int(n  2) and c = y + int(n  2))
        place(x + int(n  2), y + int(n  2) - 1, x + int(n  2), y + int(n  2), x + int(n  2) - 1,
              y + int(n  2) - 1)

    elif (r = x + int(n  2) and c = y + int(n  2))
        place(x + int(n  2) - 1, y + int(n  2), x + int(n  2), y + int(n  2) - 1, x + int(n  2) - 1,
              y + int(n  2) - 1)

    tile_rec(int(n  2), x, y + int(n  2))
    tile_rec(int(n  2), x, y)
    tile_rec(int(n  2), x + int(n  2), y)
    tile_rec(int(n  2), x + int(n  2), y + int(n  2))


def solvable(r, c, n)
    if (r == n - 1) or (c == n - 1)
        return False
    if (r == 1 and c == 0) or (r == 0 and c == 1) or (r == 2 and c == 1) or (r == 1 and c == 2)
        return False
    if (r == n - 2 and c == 1) or (r == n - 3 and c == 0) or (r == n - 3 and c == 2) or (r == n - 4 and c == 1)
        return False
    if (r == n - 2 and c == n - 3) or (r == n - 3 and c == n - 2) or (r == n - 3 and c == n - 4) or (
            r == n - 4 and c == n - 2)
        return False
    if (r == 1 and c == n - 4) or (r == 0 and c == n - 3) or (r == 2 and c == n - 3) or (r == 1 and c == n - 2)
        return False
    return True


def tile(n, x, y)
    global cnt
    r = 0
    c = 0

    for i in range(x, x + n)
        for j in range(y, y + n)
            if (arr[i][j] != 0)
                r = i
                c = j
                break
        else
            continue
        break

    if not solvable(r, c, n)
        return Cannot be solved

    if n == 8
        end_grid = [[True for j in range(8)] for i in range(8)]
        end_grid[r - x][c - y] = False
        end_grid[r - x][c - y + 1] = False
        end_grid[r - x + 1][c - y] = False
        end_grid[r - x + 1][c - y + 1] = False
        arr[xx + n, yy + n] = np.array(list(Grid().get(8, 8, end_grid).keys())[0])
        cnt += 20
        return

    if (r  x + int(n  2) - 1 and c == y + int(n  2) - 1)
        tile(int(n  2), x, y + int(n  4))
        xr = x
        yr = y
        for i in range(2)
            for j in range(int(n  8))
                for k in range(int(n  4))
                    place(xr, yr, xr, yr + 1, xr + 1, yr)
                    place(xr + 2, yr, xr + 1, yr + 1, xr + 2, yr + 1)
                    xr += 3
                yr += 2
                xr = x
            xr = x
            yr = y + int(n  4  3)

        place(x + int(n  2) + int(n  4) - 1, y + int(n  4), x + int(n  2) + int(n  4), y + int(n  4),
              x + int(n  2) + int(n  4), y + int(n  4) - 1)
        tile_rec(int(n  4), x + int(n  4) + int(n  2), y + int(n  4))
        tile_rec(int(n  4), x + int(n  2) + int(n  4), y)
        tile_rec(int(n  4), x + int(n  2), y + int(n  4))

        place(x + int(n  2) + int(n  4) - 1, y + int(n  2) + int(n  4) - 1, x + int(n  2) + int(n  4),
              y + int(n  2) + int(n  4) - 1, x + int(n  2) + int(n  4), y + int(n  2) + int(n  4))
        tile_rec(int(n  4), x + int(n  2), y + int(n  2))
        tile_rec(int(n  4), x + int(n  2) + int(n  4), y + int(n  2))
        tile_rec(int(n  4), x + int(n  2) + int(n  4), y + int(n  2) + int(n  4))

    elif (r  x + int(n  2) - 1 and c == y + int(n  2) - 1)
        arr[xx + n, yy + n] = np.flipud(arr[xx + n, yy + n])
        tile(n, x, y)
        arr[xx + n, yy + n] = np.flipud(arr[xx + n, yy + n])

    elif (r == x + int(n  2) - 1 and c  y + int(n  2) - 1)
        arr[xx + n, yy + n] = np.rot90(arr[xx + n, yy + n])
        tile(n, x, y)
        arr[xx + n, yy + n] = np.rot90(arr[xx + n, yy + n], 3)

    elif (r == x + int(n  2) - 1 and c  y + int(n  2) - 1)
        arr[xx + n, yy + n] = np.rot90(arr[xx + n, yy + n], 3)
        tile(n, x, y)
        arr[xx + n, yy + n] = np.rot90(arr[xx + n, yy + n])

    elif (r  x + n  2 - 1 and c  y + n  2 - 1)
        tile(int(n  2), x, y)
        place(x + int(n  2), y + int(n  2) - 1, x + int(n  2), y + int(n  2), x + int(n  2) - 1, y + int(n  2))
        tile_rec(int(n  2), x, y + int(n  2))
        tile_rec(int(n  2), x + int(n  2), y)
        tile_rec(int(n  2), x + int(n  2), y + int(n  2))

    elif (r  x + int(n  2) - 1 and c  y + int(n  2) - 1)
        tile(int(n  2), x + int(n  2), y)
        place(x + int(n  2) - 1, y + int(n  2), x + int(n  2), y + int(n  2), x + int(n  2) - 1,
              y + int(n  2) - 1)
        tile_rec(int(n  2), x, y)
        tile_rec(int(n  2), x + int(n  2), y)
        tile_rec(int(n  2), x + int(n  2), y + int(n  2))

    elif (r  x + int(n  2) - 1 and c  y + int(n  2) - 1)
        tile(int(n  2), x, y + int(n  2))
        place(x + int(n  2), y + int(n  2) - 1, x + int(n  2), y + int(n  2), x + int(n  2) - 1,
              y + int(n  2) - 1)
        tile_rec(int(n  2), x, y + int(n  2))
        tile_rec(int(n  2), x, y)
        tile_rec(int(n  2), x + int(n  2), y + int(n  2))

    elif (r  x + int(n  2) - 1 and c  y + int(n  2) - 1)
        tile(int(n  2), x + int(n  2), y + int(n  2))
        place(x + int(n  2) - 1, y + int(n  2), x + int(n  2), y + int(n  2) - 1, x + int(n  2) - 1,
              y + int(n  2) - 1)
        tile_rec(int(n  2), x, y + int(n  2))
        tile_rec(int(n  2), x, y)
        tile_rec(int(n  2), x + int(n  2), y)

    elif (r == x + int(n  2) - 1 and c == y + int(n  2) - 1)
        tile_rec(int(n  2), x, y + int(n  2))
        tile_rec(int(n  2), x, y)
        tile_rec(int(n  2), x + int(n  2), y)
        tile_rec(int(n  2), x + int(n  2), y + int(n  2))


size_of_grid = 64
a = 0
b = 0
arr[15][2] = -1
arr[15][1] = -1
arr[16][2] = -1
arr[16][1] = -1
tile(size_of_grid, 0, 0)
np.set_printoptions(threshold=np.inf)
print(np.array([list(i) for i in grid]))
