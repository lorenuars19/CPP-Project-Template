#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ccp_gen.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lorenuar <lorenuar@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/27 22:29:12 by lorenuar          #+#    #+#              #
#    Updated: 2022/03/27 22:29:13 by lorenuar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# bash script to generate C++ canonical class files

SRC_DIR=./src
INC_DIR=./includes

CLASS_EXT=".cpp"
HEADER_EXT=".hpp"

function gen_class_header
{
	name=$1
	header_filename="${INC_DIR}/${name}${HEADER_EXT}"
	printf "\e[32;1m+++ Generating ${name} Header -- $header_filename\e[0m\n"
	mkdir -p $INC_DIR
	up_name=$(echo "${name}" | tr '[:lower:]' '[:upper:]')
	cat > $header_filename << EOF
#ifndef ${up_name}_HPP
# define ${up_name}_HPP

# include <iostream>

class ${name}
{
	public:
// ----------------------------- Constructors ------------------------------ //
		${name}( void );	// Default Constructor
		${name}( int var );	// Fields Constructor
		${name}( const ${name}& copy );	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
		~${name}( void );	// Destructor

// ------------------------------- Operators ------------------------------- //
		${name} & operator=( const ${name}& assign );
		// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
		int		get_var( void ) const;
		void	set_var( int input );

// --------------------------------- Methods ------------------------------- //
		int		is_equal( const ${name} comp );

private:
	int	_var;

};

# ifndef NO_DEBUG
#  define _${up_name}_ARGS "Args : var " << _var
#  define _${up_name}_AUTO(COLOR_CODE, TEXT) std::cout << "\e[" << COLOR_CODE << ";1m" \\
	<< "< " << TEXT << " " << __PRETTY_FUNCTION__ << " > " \\
	<< "\e[0m" << _${up_name}_ARGS
# else
#  define _${up_name}_AUTO(x, y) ;
# endif

#endif
EOF
}

function gen_class_file
{
	name=$1
	class_filename=${SRC_DIR}/${name}${CLASS_EXT}
	printf "\e[32;1m+++ Generating $name Class -- $class_filename\e[0m\n"
	mkdir -p $SRC_DIR

	cat > $class_filename << EOF
#include "${name}.hpp"

// ----------------------------- Constructors ------------------------------ //
${name}::${name}( void )
{
	_var = 0;
	_${up_name}_AUTO(32, "Default Constructor") << std::endl;
}

${name}::${name}( const ${name}& copy )
{
	_var = copy.get_var();
	_${up_name}_AUTO(32, "Copy Constructor") << std::endl;
}

${name}::${name}( int var ) : _var(var)
{
	_${up_name}_AUTO(32, "Fields Constructor") << std::endl;
}

// ------------------------------ Destructor ------------------------------- //
${name}::~${name}( void )
{
	_${up_name}_AUTO(31, "Destructor called") << std::endl;
}
// ------------------------------- Operators ------------------------------- //

${name} & ${name}::operator=( const ${name}& assign )
{
	_var = assign.get_var();
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
int	${name}::get_var( void ) const
{
	_${up_name}_AUTO(33, "Getter") << std::endl;
	return _var;
}

void	${name}::set_var( int input )
{
	_${up_name}_AUTO(34, "Setter") << " Old " << _var << " New " << input << std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //
int	${name}::is_equal( const ${name} comp )
{
	if (this->get_var() == comp.get_var())
	{
		return this->get_var();
	}
	return 0;
}

EOF
}

if [[ $# -eq 0 ]]
then
	read -p "Enter class name : " ARG
else
	ARG=$1
fi

gen_class_header $ARG
gen_class_file $ARG
