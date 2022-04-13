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

# bash script to generate C++ var setter and getters

CLASS_NAME=$1
VAR_NAME=$2
VAR_TYPE=$3

while [[ -z "$CLASS_NAME" ]]
do
	printf "Enter class name : "
	read ans
	CLASS_NAME=$ans
done

while [[ -z "$VAR_NAME" ]]
do
	printf "Enter variable name : "
	read ans
	VAR_NAME=$ans
done

while [[ -z "$VAR_TYPE" ]]
do
	printf "Enter variable type : "
	read ans
	VAR_TYPE=$ans
done

printf "\033[92m+++ Boiler plate for ${CLASS_NAME}::${VAR_NAME}\033[0m\n"


FUNC_NAME=$(echo ${VAR_NAME} | sed 's/^,//')

cat << EOF


${VAR_TYPE}	get_${FUNC_NAME}( void ) const;

void	set_${FUNC_NAME}( ${VAR_TYPE} input );


${VAR_TYPE}	${CLASS_NAME}::get_${FUNC_NAME}( void ) const
{
	return ${VAR_NAME};
}

void	set_${FUNC_NAME}( ${VAR_TYPE} input );
{
	${VAR_NAME} = input;
}
EOF
