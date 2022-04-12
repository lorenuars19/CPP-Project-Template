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

function check_overwrite
{
	if [[ -f $1 ]]
	then
		printf "\033[31;1mFile $1 already exists\nOverwrite ? [y/N]\033[0m\n"
		read ans
		if [ "$ans" == "n" ] || [ "$ans" == "N" ] || [ -z "$ans" ]
		then
			return 1
		fi
	fi
	return 0
}

function gen_class_header
{
	name=$1
	header_filename="${INC_DIR}/${name}${HEADER_EXT}"

	check_overwrite $header_filename
	if [[ $? -eq 1 ]]
	then
		return 1
	fi

	printf "\e[32;1m+++ Generating ${name} Header -- $header_filename\e[0m\n"
	mkdir -p $INC_DIR
	up_name=$(echo "${name}" | tr '[:lower:]' '[:upper:]')



	cat >> $header_filename << EOF
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
#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */
#  define _${up_name}_ARGS "[ARGS] " << _ARG(_var)
#  define _${up_name}_AUTO(COLOR_CODE, TEXT) std::cout << "\e[" << COLOR_CODE << ";1m" \\
	<< "< " << TEXT << " " << __PRETTY_FUNCTION__ << " > " \\
	<< "\e[0m" << _${up_name}_ARGS
# else
#  define _${up_name}_AUTO(x, y) ""
#  define _${up_name}_ARGS ""
#  define _ARG ""
# endif /* NO_DEBUG */

#endif /* ${up_name}_HPP */
EOF
}

function gen_class_file
{
	name=$1
	class_filename=${SRC_DIR}/${name}${CLASS_EXT}

	check_overwrite $class_filename
	if [[ $? -eq 1 ]]
	then
		return 1
	fi

	printf "\e[32;1m+++ Generating $name Class -- $class_filename\e[0m\n"
	mkdir -p $SRC_DIR


	cat >> $class_filename << EOF
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
	_${up_name}_AUTO(34, "Setter") << "| old(" << _var << ") new(" << input << ") "<< std::endl;
	_var = input;
}

// --------------------------------- Methods ------------------------------- //

EOF
}

if [[ $# -eq 0 ]]
then
	read -p "Enter class name : " ARG
else
	ARG=$1
fi
if [[ -z $ARG ]]
then
	echo "Please provide a non-empty name."
	exit 1
fi
gen_class_header $ARG
gen_class_file $ARG
