#include "FortyTwo.hpp"

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo()
{
	_FORTYTWO_AUTO(32, "Default Constructor");
}

FortyTwo::FortyTwo(const FortyTwo& c) : name(c.get_name()), num(c.get_num())
{
	_FORTYTWO_AUTO(32, "Copy Constructor");
}

FortyTwo::FortyTwo(std::string in_name, int in_num) : name(in_name), num(in_num)
{
	_FORTYTWO_AUTO(32, "Fields Constructor");
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo()
{
	_FORTYTWO_AUTO(31, "Destructor called");
}
// ------------------------------- Operators ------------------------------- //

FortyTwo & FortyTwo::operator=(const FortyTwo& c)
{
	_FORTYTWO_AUTO(32, "Copy Assignement Operator");
	name = c.get_name();
	num = c.get_num();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
std::string FortyTwo::get_name() const{ return name; }
void FortyTwo::set_name(std::string input){ name = input; }

int FortyTwo::get_num() const{ return num; }
void FortyTwo::set_num(int input){ num = input; }



// --------------------------------- Methods ------------------------------- //

