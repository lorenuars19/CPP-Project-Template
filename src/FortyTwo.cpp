#include "FortyTwo.hpp"

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo()
{
	_FORTYTWO_AUTO(32, "Default Constructor");
}

FortyTwo::FortyTwo(const FortyTwo &c)
{
	_FORTYTWO_AUTO(32, "Copy Constructor");
	var = c.get_var();
	prec = c.get_prec();
}

FortyTwo::FortyTwo(int in_var, float in_prec) : var(in_var), prec(in_prec)
{
	_FORTYTWO_AUTO(32, "Fields Constructor");
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo()
{
	_FORTYTWO_AUTO(31, "Destructor called");
}
// ------------------------------- Operators ------------------------------- //

FortyTwo &FortyTwo::operator=(const FortyTwo &c)
{
	var = c.get_var();
	prec = c.get_prec();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int FortyTwo::get_var() const { return var; }
int FortyTwo::set_var(int input) { var = input; }

float FortyTwo::get_prec() const { return prec; }
float FortyTwo::set_prec(float input) { prec = input; }

// --------------------------------- Methods ------------------------------- //
