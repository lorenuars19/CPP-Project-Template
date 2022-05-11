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
	HEADER_FILENAME="${INC_DIR}/${CLASS_NAME}${HEADER_EXT}"

	check_overwrite $HEADER_FILENAME
	if [[ $? -eq 1 ]]; then
		return 1
	fi

	printf "\e[32;1m+++ Generating ${CLASS_NAME} Header -- $HEADER_FILENAME\e[0m\n"
	mkdir -p $INC_DIR

	cat >$HEADER_FILENAME <<EOF
#ifndef ${UP_CLASS_NAME}_HPP
# define ${UP_CLASS_NAME}_HPP

# include <iostream>

class ${CLASS_NAME}
{
public:
	${ATTS_PUBLIC}

// ----------------------------- Constructors ------------------------------ //
	${CLASS_NAME}();	// Default Constructor
	${CLASS_NAME}(${ATTS_CONSTR_ARGS});	// Fields Constructor
	${CLASS_NAME}(const ${CLASS_NAME}& c);	// Copy Constructor

// ------------------------------ Destructor ------------------------------- //
	~${CLASS_NAME}();	// Destructor

// ------------------------------- Operators ------------------------------- //
	${CLASS_NAME} & operator=(const ${CLASS_NAME}& a);
	// Copy Assignement Operator

// --------------------------- Getters && Setters -------------------------- //
	${ATTS_GETTER_SETTER_DECL}

// --------------------------------- Methods ------------------------------- //

private:
	${ATTS_PRIV}

};

# ifndef NO_DEBUG

#  ifndef _ARG
#   define _ARG(arg) #arg << "(" << arg << ") "
#  endif /* _ARG */

#  define _${UP_CLASS_NAME}_ARGS ${ATTS_MACRO}
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
	class_filename=${SRC_DIR}/${CLASS_NAME}${CLASS_EXT}

	check_overwrite $class_filename
	if [[ $? -eq 1 ]]; then
		return 1
	fi

	printf "\e[32;1m+++ Generating $CLASS_NAME Class -- $class_filename\e[0m\n"
	mkdir -p $SRC_DIR

	cat >$class_filename <<EOF
#include "${CLASS_NAME}.hpp"

// ----------------------------- Constructors ------------------------------ //
${CLASS_NAME}::${CLASS_NAME}()
{
	_${UP_CLASS_NAME}_AUTO(32, "Default Constructor");
}

${CLASS_NAME}::${CLASS_NAME}(const ${CLASS_NAME}& c) ${ATTS_CONSTR_COPY}
{
	_${UP_CLASS_NAME}_AUTO(32, "Copy Constructor");
}

${CLASS_NAME}::${CLASS_NAME}(${ATTS_CONSTR_ARGS}) ${ATTS_CONSTR_ARGS_INIT}
{
	_${UP_CLASS_NAME}_AUTO(32, "Fields Constructor");
}

// ------------------------------ Destructor ------------------------------- //
${CLASS_NAME}::~${CLASS_NAME}()
{
	_${UP_CLASS_NAME}_AUTO(31, "Destructor called");
}
// ------------------------------- Operators ------------------------------- //

${CLASS_NAME} & ${CLASS_NAME}::operator=(const ${CLASS_NAME}& c)
{
	_${UP_CLASS_NAME}_AUTO(32, "Copy Assignement Operator");
	${ATTS_COPY}
	return *this;
}

// --------------------------- Getters && Setters -------------------------- //
${ATTS_GETTER_SETTER_DEFS}

// --------------------------------- Methods ------------------------------- //

EOF
}

function gen_attributes {

	read -p "Do you want to define attributes ? [Y/n]" want
	if [[ "${want}" == "n" ]] || [[ "${want}" == "N" ]]; then
		return 0
	fi

	declare -a ATTS
	printf "\e[33;1m--- Attributes Definitions : \e[0m\n"
	ATT_CNT=0
	while [[ -z "$ANS" ]]; do
		IFS=' '
		ATTRIB=()
		ATT_TYP=
		ATT_NAM=
		printf "Enter Attribute [${ATT_CNT}] :\n"
		printf " Common types : (b)ool (c)har (i)nt (ui)nt (l)ong (ul)ong (s)tring (f)loat (d)ouble \n"
		while [[ -z "$ATT_TYP" ]]; do
			read -p " Type : " ATT_TYP
		done

		if [[ "$ATT_TYP" == "b" ]]; then
			ATT_TYP="bool"
		fi
		if [[ "$ATT_TYP" == "c" ]]; then
			ATT_TYP="char"
		fi
		if [[ "$ATT_TYP" == "i" ]]; then
			ATT_TYP="int"
		fi
		if [[ "$ATT_TYP" == "ui" ]]; then
			ATT_TYP="unsigned int"
		fi
		if [[ "$ATT_TYP" == "l" ]]; then
			ATT_TYP="long"
		fi
		if [[ "$ATT_TYP" == "ul" ]]; then
			ATT_TYP="unsigned long"
		fi
		if [[ "$ATT_TYP" == "s" ]]; then
			ATT_TYP="std::string"
		fi
		if [[ "$ATT_TYP" == "f" ]]; then
			ATT_TYP="float"
		fi
		if [[ "$ATT_TYP" == "d" ]]; then
			ATT_TYP="double"
		fi

		ATTRIB+=("${ATT_TYP}")

		while [[ -z "${ATT_NAM}" ]]; do
			read -p " Name : " ATT_NAM
		done
		ATTRIB+=("${ATT_NAM}")

		read -p " Type 'p' to make public or press enter for private attribute : " PRIVATE
		if [[ -z "${PRIVATE}" ]]; then
			ATTRIB+=("PRIVATE")
		else
			ATTRIB+=("PUBLIC")
		fi

		printf "Attribute : [ Type '${ATTRIB[0]}' ] [ Name '${ATTRIB[1]}' ] [ Public/Private : '${ATTRIB[2]}' ]\n"

		ATTS+=("${ATTRIB[@]}")
		read -p "Type 'end' or press enter to add another attribute : " ANS
		ATT_CNT=$((ATT_CNT + 1))
	done

	# echo "ATTS '${ATTS[@]}' ATT_CNT ${ATT_CNT} >> $((${ATT_CNT} * 3))"

	i=0
	ATT_CNT_RAW=$((${ATT_CNT} * 3))
	ATTS_CONSTR_ARGS_INIT+=": "
	ATTS_CONSTR_COPY+=": "
	while [[ i -lt ${ATT_CNT_RAW} ]]; do
		ATT_TYPE=${ATTS[$((i + 0))]}
		ATT_NAME=${ATTS[$((i + 1))]}
		ATT_VISIBILITY=${ATTS[$((i + 2))]}

		ATTS_CONSTR_ARGS+="${ATT_TYPE} in_${ATT_NAME}"
		ATTS_CONSTR_ARGS_INIT+="${ATT_NAME}(in_${ATT_NAME})"
		ATTS_MACRO+="_ARG(${ATT_NAME})"

		ATTS_CONSTR_COPY+="${ATT_NAME}(c.get_${ATT_NAME}())"
		ATTS_COPY+="${ATT_NAME} = c.get_${ATT_NAME}();"

		ATTS_GETTER_SETTER_DECL+="${ATT_TYPE} get_${ATT_NAME}() const;"$'\n'$'\t'
		ATTS_GETTER_SETTER_DECL+="void set_${ATT_NAME}(${ATT_TYPE} input);"$'\n'$'\t'

		ATTS_GETTER_SETTER_DEFS+="${ATT_TYPE} ${CLASS_NAME}::get_${ATT_NAME}() const{ return ${ATT_NAME}; }"$'\n'
		ATTS_GETTER_SETTER_DEFS+="void ${CLASS_NAME}::set_${ATT_NAME}(${ATT_TYPE} input){ ${ATT_NAME} = input; }"$'\n'$'\n'

		if [[ ${ATT_VISIBILITY} == "PRIVATE" ]]; then
			ATTS_PRIV+="${ATT_TYPE} ${ATT_NAME};"
		else
			ATTS_PUBLIC+="${ATT_TYPE} ${ATT_NAME};"
		fi

		if [[ i -lt $((${ATT_CNT_RAW} - 3)) ]]; then
			ATTS_CONSTR_ARGS+=", "
			ATTS_GETTER_SETTER_DECL+=$'\n'$'\t'
			ATTS_CONSTR_COPY+=", "
			ATTS_COPY+=$'\n'$'\t'
			ATTS_CONSTR_ARGS_INIT+=", "
			ATTS_MACRO+=" << "
			if [[ ${ATT_VISIBILITY} == "PRIVATE" ]]; then
				ATTS_PRIV+=$'\n'$'\t'
			else
				ATTS_PUBLIC+=$'\n'$'\t'
			fi

		fi
		i=$((i + 3))
	done

	# printf "\n\nATTS_CONSTR_ARGS\n${CLASS_NAME}(${ATTS_CONSTR_ARGS})\n"
	# printf "\n\nATTS_CONSTR_ARGS_INIT\n${ATTS_CONSTR_ARGS_INIT}'\n"
	# printf "\n\nATTS_MACRO\n${ATTS_MACRO}\n"
	# printf "\n\nATTS_CONSTR_COPY\n${ATTS_CONSTR_COPY}\n"
	# printf "\n\nATTS_GETTER_SETTER_DECL\n${ATTS_GETTER_SETTER_DECL}\n"
	# printf "\n\nATTS_GETTER_SETTER_DEFS\n${ATTS_GETTER_SETTER_DEFS}\n"
	# printf "\n\nATTS_PRIV\n${ATTS_PRIV}\n"
	# printf "\n\nATTS_PUBLIC\n${ATTS_PUBLIC}\n"
}

printf "\e[33;1m--- Class files Boiler Plate Generator ---\e[0m\n"

ARG=$1
while [[ -z "$ARG" ]]; do
	read -p "Enter class name : " ARG
done

CLASS_NAME=$(tr '[:lower:]' '[:upper:]' <<<${ARG:0:1})${ARG:1}
UP_CLASS_NAME=$(echo "${CLASS_NAME}" | tr '[:lower:]' '[:upper:]')

gen_attributes
gen_class_header
gen_class_file
