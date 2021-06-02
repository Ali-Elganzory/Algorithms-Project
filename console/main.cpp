#include <iostream>
#include "Task3.h"

using namespace std;

// Utilities prototype
int getUserAction();
void printDivider();

// Tasks prototypes
// Task 1
void task1();
int minimumCuts(int n);
// Task 2
void task2();
// Task 3
void task3();
int minimumToggles(Circle* c);
// Task 4
void task4();
// Task 5
void task5();
int findFakeCoin(int coinWeight, int coins[], int s, int e);
int counter = 0;
// Task 6
void task6();

typedef void (*TaskCallback)();

int main()
{
    bool running = true;
    TaskCallback tasks[6] = {task1, task2, task3, task4, task5, task6};
    while (running)
    {
        int action = getUserAction();
        if (action < 0 || action > 6)
            cout << "Pleae enter a valid action...\n\n";
        else if (action == 0)
            running = false;
        else
            tasks[action - 1]();
    }
}

// Task 1
int minimumCuts(int n)
{
    int minCuts = 0;
    while (n >= 2)
    {
        n /= 2;
        minCuts++;
    }
    minCuts += (n > 0 ? 1 : 0);
    return minCuts;
}

void task1()
{
    printDivider();

    cout << "Enter the length of the stick: ";
    int length;
    cin >> length;

    if (length < 2)
        cout << "\nThe stick length must be higher than 2 ...";
    else
        printf("The minimum number of cuts is %d", minimumCuts(length));

    printDivider();
}

// Task 2
void task2() {}
// Task 3


int minimumSwitches(Circle* c)
{
    int temp = c->f_solution;
    Lamp* itr = c->start;
    for (int i = 0; i < temp; i++)
    {
        itr->check_objective_function(c->f_solution);
        itr = itr->after;
    }

    // if number of lamps is not divided by 3, then the optimal solution is the intitial feasible solution = number of Lamps 
    Lamp* itr2 = c->start;
    for (int i = 0; i < temp; i++)
    {

        if (itr2->isOn == true)
        {
            c->f_solution = temp;
            break;
        }
        itr2 = itr2->after;

    }
    return c->f_solution;
}


void task3() {

    cout << "_________________________________________________ iterative improvement ________________________________________________" << endl << endl;

    cout << "                                                        #Task 3" << endl << endl;

    cout << endl << "                 <<Objective Function: minimize number of switches needed to turn all lamps ON>>" << endl;
    cout << endl << "               $Constraints: Each switch toggle the state of three lamps (After, current, Before)$" << endl;

    cout << endl << ">>Enter number of Lamps needed: ";
    int noLmps;
    cin >> noLmps;
    cout << endl << "*intitial feasible solution: " << noLmps << endl;

    Circle* c = new Circle(noLmps);

    for (int i = 0; i < noLmps - 3; i++)
    {
        c->add_lamp();

    }
    cout << endl << "~Minimum number of switches: " << minimumSwitches(c) << endl;
}

// Task 4
int trianglesCount(int n)
{
    int t = 1;
    for (int i = 1; i < n; i++)
    {
        t = t + (i * 3);
    }
    return t;
}

void task4()
{
    printDivider();

    cout << "Enter the number of iterations: ";
    int iterations;
    cin >> iterations;

    if (iterations < 1)
        cout << "\nThe number of iterations must be higher than 0 ...";
    else
        printf("The number of triangles is %d", trianglesCount(iterations));

    printDivider();
}

// Task 5
int findFakeCoin(int coinWeight, int coins[], int s, int e) {
    if (e - s == 0)
        return counter;
    else if (e - s == 1) {
        return counter += 1;
    }
    else
    {
        int mid = s + int((e - s) / 2);
        int sum = 0;
        counter += 1;
        for (int i = s; i < mid + 1; i++) {
            sum += coins[i];
        }
        int expected_weight = coinWeight * (mid + 1 - s);
        if (sum != expected_weight)
            return findFakeCoin(coinWeight, coins, s, mid);
        else
            return findFakeCoin(coinWeight, coins, mid + 1, e);
    }
}

void task5()
{
    int n, coinWeight, fakeIndex, fakeWeight;
    // prompt the user to enter the number of coins
    cout << "Enter the number of coins: " << "\n";
    cin >> n;

    // prompt the user to enter the weight of the coin
    cout << "Enter the weight of the coin" << endl;
    cin >> coinWeight;

    // creating an array and initalzing it with a default value (the weight of the coin)
    int* coins = new int[n];
    std::fill_n(coins, n, coinWeight);

    // taking the index of fake coin and its weight
    cout << "Enter the index of the fake coin and its weight:" << endl;
    cin >> fakeIndex >> fakeWeight;
    coins[fakeIndex] = fakeWeight;

    cout << "The coins listed sequentially: ";
    for (int i = 0; i < n; i++) {
        cout << coins[i] << " | ";
    }

    cout << endl << "The minimum number of weighings: is " << findFakeCoin(1, coins, 0, n - 1);
    delete[] coins;


}

// Task 6
void task6() {}

// Utilities
int getUserAction()
{
    cout << "\nChoose a task to demo:\n";
    printf(
        "%-20s%-20s%-20s\n%-20s%-20s%-20s\n%-20s",
        "1: Task 1",
        "2: Task 2",
        "3: Task 3",
        "4: Task 4",
        "5: Task 5",
        "6: Task 6",
        "0: exit");
    cout << "\n\nEnter task number and hit enter: ";
    int n;
    cin >> n;
    return n;
}

void printDivider()
{
    cout << "\n--------------------\n";
}