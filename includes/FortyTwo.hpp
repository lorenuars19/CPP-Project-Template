#ifndef FORTYTWO_HPP
# define FORTYTWO_HPP

# include <iostream>

class FortyTwo
{
public:
	

// ----------------------------- Constructors ------------------------------ //
	FortyTwo();	// Default Constructor
	FortyTwo(int in_var, float in_prec);	// Fields Constructor
	FortyTwo(const FortyTwo& c);	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
	~FortyTwo();	// Destructor

// ------------------------------- Operators ------------------------------- //
	FortyTwo & operator=(const FortyTwo& a);
	// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
	int get_var() const;
	int set_var(int input);
	
	float get_prec() const;
	float set_prec(float input);
	

// --------------------------------- Methods ------------------------------- //

private:
	int var;
	float prec;

};

# ifndef NO_DEBUG

#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */

#  define _FORTYTWO_ARGS _ARG(var) << _ARG(prec)
#  define _FORTYTWO_AUTO(COLOR_CODE, TEXT) \
	std::cout << "{ \e[" << COLOR_CODE << ";1m"                 \
			  << TEXT << " " << __PRETTY_FUNCTION__ << "\e[0m " \
			  << "[\033[34;47m" << this                         \
			  << "\033[0m]\033[0m: " << _FORTYTWO_ARGS  \
			  << "}" << std::endl;
# else

#  define _FORTYTWO_AUTO(x, y) ;
#  define _FORTYTWO_ARGS ""
#  define _ARG ""

# endif /* NO_DEBUG */

#endif /* FORTYTWO_HPP */
