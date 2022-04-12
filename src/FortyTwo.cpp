#include "FortyTwo.hpp"

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo( void )
{
	_var = 0;
	_FORTYTWO_AUTO(32, "Default Constructor") << std::endl;
}

FortyTwo::FortyTwo( const FortyTwo& copy )
{
	_var = copy.get_var();
	_FORTYTWO_AUTO(32, "Copy Constructor") << std::endl;
}

FortyTwo::FortyTwo( int var ) : _var(var)
{
	_FORTYTWO_AUTO(32, "Fields Constructor") << std::endl;
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo( void )
{
	_FORTYTWO_AUTO(31, "Destructor called") << std::endl;
}
// ------------------------------- Operators ------------------------------- //

FortyTwo & FortyTwo::operator=( const FortyTwo& assign )
{
	_var = assign.get_var();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int	FortyTwo::get_var( void ) const
{
	_FORTYTWO_AUTO(33, "Getter") << std::endl;
	return _var;
}

void	FortyTwo::set_var( int input )
{
	_FORTYTWO_AUTO(34, "Setter") << "| old(" << _var << ") new(" << input << ") "<< std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //

