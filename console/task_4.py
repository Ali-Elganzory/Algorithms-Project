from collections import deque
from point import Point


# Task algorithm
def count_triangles(iterations):
    visited_triangles = set()
    outer_triangles = deque()

    triangle_point = Point(0, 0)
    visited_triangles.add(triangle_point)
    outer_triangles.append(triangle_point)

    drawn_triangles_count = 1
    for iteration in range(1, iterations):
        for i in range(len(outer_triangles)):
            triangle_point = outer_triangles.popleft()

            # Check the 3 sides of this triangle
            for p in [Point(-1, 0), Point(1, 0), Point(0, -1 if triangle_point.is_downward else 1)]:
                p = triangle_point + p

                # If not visited put a new triangle
                if p not in visited_triangles:
                    drawn_triangles_count += 1
                    visited_triangles.add(p)
                    outer_triangles.append(p)

    return drawn_triangles_count


# Take user input and call algorithm
def task_4():
    number_iterations = int(input("Enter the number of iterations: "))
    triangles_count = count_triangles(number_iterations)
    print(f"The number of triangles is {triangles_count}")


if __name__ == "__main__":
    task_4()
