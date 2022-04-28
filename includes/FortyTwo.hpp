#ifndef FORTYTWO_HPP
#define FORTYTWO_HPP

#include <iostream>

class FortyTwo
{
public:
	typedef FortyTwo t;
	// ----------------------------- Constructors ------------------------------ //
	FortyTwo();			  // Default Constructor
	FortyTwo(int var);	  // Fields Constructor
	FortyTwo(const t &c); // Copy Constructor

	// ------------------------------ Destructor ------------------------------- //
	~FortyTwo(); // Destructor

	// ------------------------------- Operators ------------------------------- //
	FortyTwo &operator=(const t &a);
	// Copy Assignement Operator

	// --------------------------- Getters && Setters -------------------------- //
	int get_var() const;
	void set_var(int input);

	// --------------------------------- Methods ------------------------------- //
	int is_equal(const FortyTwo comp);

private:
	int var;
};

#ifndef NO_DEBUG

#ifndef _ARG
#define _ARG(arg) #arg << "(" << arg << ") "
#endif /* _ARG */

#define _FORTYTWO_ARGS _ARG(var)
#define _FORTYTWO_AUTO(COLOR_Cvar TEXT)                         \
	std::cout << "{ \e[" << COLOR_CODE << ";1m"                 \
			  << TEXT << " " << __PRETTY_FUNCTION__ << "\e[0m " \
			  << "[\033[34;47m" << this                         \
			  << "\033[0m]\033[0m: " << _FORTYTWO_ARGS          \
			  << "}" << std::endl;
#else

#define _FORTYTWO_AUTO(x, y) ;
#define _FORTYTWO_ARGS ""
#define _ARG ""

#endif /* NO_DEBUG */

#endif /* FORTYTWO_HPP */
