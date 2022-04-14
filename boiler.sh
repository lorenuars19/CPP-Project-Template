#!/bin/bash
# bash script to generate C++ variable boiler plate code

CLASS_NAME=$1
VAR_NAME=$2
VAR_TYPE=$3

RED='\033[91;1m'
GRN='\033[92;1m'
YEL='\033[33m'
BLU='\033[94;1m'
MAG='\033[95;1m'
CYA='\033[96;1m'
RST='\033[0m'

printf "\e[33;1m--- Variables Boiler Plate Generator ---\e[0m\n\n"

while [[ -z "$CLASS_NAME" ]]
do
	printf "Enter class name : "
	read ans
	CLASS_NAME=$ans
done
CLASS_NAME=$(tr '[:lower:]' '[:upper:]' <<< ${CLASS_NAME:0:1})${CLASS_NAME:1}
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

printf "${GRN}+++ Boiler plate for ${CLASS_NAME}${RST}::${YEL}${VAR_NAME}${GRN} \
 of type ${BLU}${VAR_TYPE}${GRN} +++${RST}\n\n"

FUNC_NAME=$(echo ${VAR_NAME} | sed 's/^_//')

printf "$(cat << EOF
${BLU}class ${GRN}${CLASS_NAME}${RST}
{

	${BLU}${VAR_TYPE} ${GRN}${VAR_NAME}${RST};

	${BLU}${VAR_TYPE}	${YEL}get_${FUNC_NAME}${RST}( ${BLU}void${RST} ) ${BLU}const${RST};
	${BLU}void	${YEL}set_${FUNC_NAME}${RST}( ${BLU}${VAR_TYPE} ${CYA}input${RST} );

};

${BLU}${VAR_TYPE}	${GRN}${CLASS_NAME}::${YEL}get_${FUNC_NAME}${RST}( ${BLU}void${RST} ) ${BLU}const${RST}
{
	${MAG}return ${CYA}${VAR_NAME}${RST};
}

${BLU}void	${GRN}${CLASS_NAME}::${YEL}set_${FUNC_NAME}${RST}( ${BLU}${VAR_TYPE} ${CYA}input${RST} );
{
	${CYA}${VAR_NAME}${RST} = ${CYA}input${RST};
}
EOF)\n"
