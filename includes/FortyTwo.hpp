#ifndef FORTYTWO_HPP
# define FORTYTWO_HPP

# include <iostream>

class FortyTwo
{
public:
	

// ----------------------------- Constructors ------------------------------ //
	FortyTwo();	// Default Constructor
	FortyTwo(std::string in_name, int in_num);	// Fields Constructor
	FortyTwo(const FortyTwo& c);	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
	~FortyTwo();	// Destructor

// ------------------------------- Operators ------------------------------- //
	FortyTwo & operator=(const FortyTwo& a);
	// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
	std::string get_name() const;
	void set_name(std::string input);
	
	int get_num() const;
	void set_num(int input);
	

// --------------------------------- Methods ------------------------------- //

private:
	std::string name;
	int num;

};

# ifndef NO_DEBUG

#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */

#  define _FORTYTWO_ARGS _ARG(name) << _ARG(num)
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
