#include "FortyTwo.hpp"

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo( void )
{
	_var = 0;
	_FORTYTWO_AUTO(32, "Default Constructor");
}

FortyTwo::FortyTwo( const t& c )
{
	_var = c.get_var();
	_FORTYTWO_AUTO(32, "Copy Constructor");
}

FortyTwo::FortyTwo( int var ) : _var(var)
{
	_FORTYTWO_AUTO(32, "Fields Constructor");
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo( void )
{
	_FORTYTWO_AUTO(31, "Destructor called");
}
// ------------------------------- Operators ------------------------------- //

FortyTwo & FortyTwo::operator=( const t& a )
{
	_var = a.get_var();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int	FortyTwo::get_var( void ) const
{
	_FORTYTWO_AUTO(33, "Getter");
	return _var;
}

void	FortyTwo::set_var( int input )
{
	_FORTYTWO_AUTO(34, "Setter");
#ifndef NO_DEBUG
	std::cout << "\033[1D";
#endif
	std::cout <<" old(" << _var << ") new(" << input << ") "<< std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //

