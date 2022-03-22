#include "FortyTwo.hpp"

# define _ARGS "Args : var " << _var
# define _AUTO(COLOR_CODE, TEXT) "\e[" << COLOR_CODE << ";1m" \
	<< "< " << TEXT << " " << __PRETTY_FUNCTION__ << " > " \
	<< "\e[0m" << _ARGS

// ----------------------------- Constructors ------------------------------ //
FortyTwo::FortyTwo( void )
{
	_var = 0;
	std::cout << _AUTO(32, "Default Constructor")
		<< std::endl;
}

FortyTwo::FortyTwo( const FortyTwo &copy )
{
	_var = copy.getVar();
	std::cout << _AUTO(32, "Copy Constructor")
		<< std::endl;
}

FortyTwo::FortyTwo( int var )
{
	_var = var;
	std::cout << _AUTO(32, "Fields Constructor")
		<< std::endl;
}

// ------------------------------ Destructor ------------------------------- //
FortyTwo::~FortyTwo( void )
{
	std::cout << _AUTO(31, "Destructor called")
		<< std::endl;
}
// ------------------------------- Operators ------------------------------- //

FortyTwo & FortyTwo::operator=(const FortyTwo &assign)
{
	_var = assign.getVar();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int	FortyTwo::getVar( void ) const
{
	std::cout << _AUTO(33, "Getter")
		<< std::endl;
	return _var;
}

void	FortyTwo::setVar( int input )
{
	std::cout << _AUTO(34, "Setter")
		<< " Old " << _var << " New " << input
		<< std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //
int	FortyTwo::isEqual( FortyTwo t)
{
	if (this->getVar() == t.getVar())
	{
		return this->getVar();
	}
	return 0;
}
