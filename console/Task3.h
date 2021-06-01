#include<iostream>
using namespace std;


class Lamp
{
public:
	bool isOn = true;
	bool isToggeled = true;
	Lamp* before;
	Lamp* after;
	Lamp()
	{
		before = NULL;
		after = NULL;
	}

	// toggle three lamps states (before, current, after)
	void toggle()
	{
		this->after->isToggeled = ! this->after->isToggeled;
		this->before->isToggeled = ! this->before->isToggeled;
		this->after->isOn = ! this->after->isOn;
		this->before->isOn = ! this->before->isOn;
		this->isOn = ! this->isOn;
		this->isToggeled = ! this->isToggeled;
	}

	// check if we can use one switch instead of three switches 
	void check_objective_function(int& f_solution)
	{
		if ((this->isOn && this->isToggeled) &&
			(this->before->isOn && this->before->isToggeled) &&
			(this->after->isOn && this->after->isToggeled))
		{
			toggle();
			f_solution -= 2;  // we can reach our goal with 2 less swithces 
		}
	}


};


class Circle
{
public:
	Lamp* start;
	Lamp* middle;
	Lamp* end;
	int f_solution;


	Circle(int f_solution)
	{
		this->f_solution = f_solution;
		start = new Lamp();
		middle = new Lamp();
		end = new Lamp();
		start->after = middle;
		start->before = end;
		middle->after = end;
		middle->before = start;
		end->after = start;
		end->before = middle;
	}

	void add_lamp()
	{
		Lamp* nwlmp = new Lamp();
		nwlmp->before = end;
		end->after = nwlmp;
		end = nwlmp;
		nwlmp->after = start;
	}


};
