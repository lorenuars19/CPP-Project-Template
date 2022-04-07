#include "FortyTwo.hpp"

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo( void )
{
	_var = 0;
	_AUTO(32, "Default Constructor") << std::endl;
}

FortyTwo::FortyTwo( const FortyTwo& copy )
{
	_var = copy.get_var();
	_AUTO(32, "Copy Constructor") << std::endl;
}

FortyTwo::FortyTwo( int var ) : _var(var)
{
	_AUTO(32, "Fields Constructor") << std::endl;
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo( void )
{
	_AUTO(31, "Destructor called") << std::endl;
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
	_AUTO(33, "Getter") << std::endl;
	return _var;
}

void	FortyTwo::set_var( int input )
{
	_AUTO(34, "Setter") << " Old " << _var << " New " << input << std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //
int	FortyTwo::is_equal( const FortyTwo comp )
{
	if (this->get_var() == comp.get_var())
	{
		return this->get_var();
	}
	return 0;
}
