#!/bin/bash
# bash script to generate C++ canonical class files

SRC_DIR=./src
INC_DIR=./includes

CLASS_EXT=".cpp"
HEADER_EXT=".hpp"

function check_overwrite {
	if [[ -f $1 ]]; then
		printf "\033[31;1mFile $1 already exists\nOverwrite ? [y/N]\033[0m\n"
		read ans
		if [ "$ans" == "n" ] || [ "$ans" == "N" ] || [ -z "$ans" ]; then
			return 1
		fi
	fi
	return 0
}

function gen_class_header {
	CLASS_NAME=$1
	HEADER_FILENAME="${INC_DIR}/${CLASS_NAME}${HEADER_EXT}"

	check_overwrite $HEADER_FILENAME
	if [[ $? -eq 1 ]]; then
		return 1
	fi

	printf "\e[32;1m+++ Generating ${CLASS_NAME} Header -- $HEADER_FILENAME\e[0m\n"
	mkdir -p $INC_DIR
	UP_CLASS_NAME=$(echo "${CLASS_NAME}" | tr '[:lower:]' '[:upper:]')

	cat >$HEADER_FILENAME <<EOF
#ifndef ${UP_CLASS_NAME}_HPP
# define ${UP_CLASS_NAME}_HPP

# include <iostream>

class ${CLASS_NAME}
{
	public:
		typedef	${CLASS_NAME} t;
// ----------------------------- Constructors ------------------------------ //
		${CLASS_NAME}( );	// Default Constructor
		${CLASS_NAME}( int var );	// Fields Constructor
		${CLASS_NAME}( const t& c );	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
		~${CLASS_NAME}( );	// Destructor

// ------------------------------- Operators ------------------------------- //
		${CLASS_NAME} & operator=( const t& a );
		// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
		int		get_var( ) const;
		void	set_var( int input );

// --------------------------------- Methods ------------------------------- //
		int		is_equal( const ${CLASS_NAME} comp );

private:
	int	var;

};

# ifndef NO_DEBUG

#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */

#  define _${UP_CLASS_NAME}_ARGS _ARG(var)
#  define _${UP_CLASS_NAME}_AUTO(COLOR_CODE, TEXT) \\
	std::cout << "{ \e[" << COLOR_CODE << ";1m"                 \\
			  << TEXT << " " << __PRETTY_FUNCTION__ << "\e[0m " \\
			  << "[\033[34;47m" << this                         \\
			  << "\033[0m]\033[0m: " << _${UP_CLASS_NAME}_ARGS  \\
			  << "}" << std::endl;
# else

#  define _${UP_CLASS_NAME}_AUTO(x, y) ;
#  define _${UP_CLASS_NAME}_ARGS ""
#  define _ARG ""

# endif /* NO_DEBUG */

#endif /* ${UP_CLASS_NAME}_HPP */
EOF
}

function gen_class_file {
	CLASS_NAME=$1
	class_filename=${SRC_DIR}/${CLASS_NAME}${CLASS_EXT}

	check_overwrite $class_filename
	if [[ $? -eq 1 ]]; then
		return 1
	fi

	printf "\e[32;1m+++ Generating $CLASS_NAME Class -- $class_filename\e[0m\n"
	mkdir -p $SRC_DIR
	UP_CLASS_NAME=$(echo "${CLASS_NAME}" | tr '[:lower:]' '[:upper:]')

	cat >$class_filename <<EOF
#include "${CLASS_NAME}.hpp"

// ----------------------------- Constructors ------------------------------ //
${CLASS_NAME}::${CLASS_NAME}( )
{
	var = 0;
	_${UP_CLASS_NAME}_AUTO(32, "Default Constructor");
}

${CLASS_NAME}::${CLASS_NAME}( const t& c )
{
	var = c.get_var();
	_${UP_CLASS_NAME}_AUTO(32, "Copy Constructor");
}

${CLASS_NAME}::${CLASS_NAME}( int input ) : var(input)
{
	_${UP_CLASS_NAME}_AUTO(32, "Fields Constructor");
}

// ------------------------------ Destructor ------------------------------- //
${CLASS_NAME}::~${CLASS_NAME}( )
{
	_${UP_CLASS_NAME}_AUTO(31, "Destructor called");
}
// ------------------------------- Operators ------------------------------- //

${CLASS_NAME} & ${CLASS_NAME}::operator=( const t& a )
{
	var = a.get_var();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int	${CLASS_NAME}::get_var( ) const
{
	_${UP_CLASS_NAME}_AUTO(33, "Getter");
	return var;
}

void	${CLASS_NAME}::set_var( int input )
{
	_${UP_CLASS_NAME}_AUTO(34, "Setter");
#ifndef NO_DEBUG
	std::cout << "\033[1D";
#endif
	std::cout <<" old(" << var << ") new(" << input << ") "<< std::endl;
	var = input;
}

// --------------------------------- Methods ------------------------------- //

EOF
}

printf "\e[33;1m--- Class files Boiler Plate Generator ---\e[0m\n\n"
ARG=$1

while [[ -z "$ARG" ]]; do
	read -p "Enter class name : " ARG
done
ARG=$(tr '[:lower:]' '[:upper:]' <<<${ARG:0:1})${ARG:1}
gen_class_header $ARG
gen_class_file $ARG
