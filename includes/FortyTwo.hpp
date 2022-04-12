#ifndef FORTYTWO_HPP
# define FORTYTWO_HPP

# include <iostream>

class FortyTwo
{
	public:
// ----------------------------- Constructors ------------------------------ //
		FortyTwo( void );	// Default Constructor
		FortyTwo( int var );	// Fields Constructor
		FortyTwo( const FortyTwo& copy );	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
		~FortyTwo( void );	// Destructor

// ------------------------------- Operators ------------------------------- //
		FortyTwo & operator=( const FortyTwo& assign );
		// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
		int		get_var( void ) const;
		void	set_var( int input );

// --------------------------------- Methods ------------------------------- //
		int		is_equal( const FortyTwo comp );

private:
	int	_var;

};

# ifndef NO_DEBUG
#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */
#  define _FORTYTWO_ARGS "[ARGS] " << _ARG(_var)
#  define _FORTYTWO_AUTO(COLOR_CODE, TEXT) std::cout << "\e[" << COLOR_CODE << ";1m" \
	<< "< " << TEXT << " " << __PRETTY_FUNCTION__ << " > " \
	<< "\e[0m" << _FORTYTWO_ARGS
# else
#  define _FORTYTWO_AUTO(x, y) ""
#  define _FORTYTWO_ARGS ""
#  define _ARG ""
# endif /* NO_DEBUG */

#endif /* FORTYTWO_HPP */
