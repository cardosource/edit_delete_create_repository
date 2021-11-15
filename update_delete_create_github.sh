#! /bin/bash 
USUARIO="git-cardoso"
TOKEN=0000000000000000000000000000000000

GREEN='\033[0;32m'
RED='\e[31m'
YELLOW="\e[33m"
BOLD=`tput bold`
NBOLD=`tput sgr0`
ITALIC="\e[3m"
NITALIC="\e[0m"
NC='\033[0m'

STRIKETHROUGH="\e[9m"
NSTRIKETHROUGH="\e[0m"

function connection(){    
    curl $1
    echo -e "${GREEN}${BOLD}CONNECTION ${NBOLD}${NC}"
}

function create(){
    read -p "Create a new repository " REPOSITORY
    read -p "Description (optional)" DESCRIPTION

    connection  https://api.github.com/user/repos \
   --header "Content-type: application/json"  \
   --request POST -H 'Authorization: token '$TOKEN  \
   -d '{"name":"'$REPOSITORY'","description":"'$DESCRIPTION'"}'   
   echo -e "${GREEN}${ITALIC}CREATED${NITALIC}${NC}"
 
}
function edit_repositoryName(){
    read -p "Name old one repository : " OLD_ONE_REPOSITORY
    read -p "New name repository : " NEW_REPOSITORY
    read -p "Description (optional) : " DESCRIPTION

  
   connection  https://api.github.com/repos/$USUARIO/$NEW_REPOSITORY \
    --header "Content-type: application/json" \
    -X PATCH  \
    -H 'Authorization: token '$TOKEN \
    -d '{"name":"'$OLD_ONE_REPOSITORY'","description":"'$DESCRIPTION'"}'
   echo -e "${YELLOW}${ITALIC}UPDATED${NITALIC}${NC}"

}

function edit_description(){
    read -p "Name  repository : " REPOSITORY
    read -p "New Description  : " NEW_DESCRIPTION

    connection https://api.github.com/repos/$USUARIO/$REPOSITORY \
    --header "Content-type: application/json" \
    -X PATCH  \
    -H 'Authorization: token '$TOKEN \
    -d '{"name":"'$REPOSITORY'","description":"'$NEW_DESCRIPTION'"}'
    echo -e "${YELLOW}${ITALIC}UPDATED${NITALIC}${NC}"

}

function delete(){
    read -p "Delete repository : " REPOSITORY

    connection  https://api.github.com/repos/$USUARIO/$REPOSITORY \
      --header "Content-type: application/json" \
      -X DELETE \
      -H 'Authorization: token '$TOKEN 
     echo -e "${RED}${STRIKETHROUGH}DELETED${NSTRIKETHROUGH}${NC}"

}
echo "+------------------------------------------------------------------------+"

echo -e " Saudacoes ${USER} \n" | tr [[:lower:]] [[:upper:]]
echo -e "O que deseja:"
echo -e "${GREEN}${ITALIC} c ${NITALIC}${NC}  - ${GREEN}${ITALIC}Criar${NITALIC}${NC} um Repositorio no GitHub"
echo -e "${RED}${ITALIC} x ${NITALIC}${NC}  - ${RED}${ITALIC}Excluir${NITALIC}${NC} um Repositorio no GitHub"
echo -e "${GREEN}${ITALIC} r ${NITALIC}${NC}  - Editar nome do ${GREEN}${ITALIC}repositorio${NITALIC}${NC}  no GitHub"
echo -e "${YELLOW}${ITALIC} d ${NITALIC}${NC}  - Editar apenas a ${YELLOW}${ITALIC}descrição${NITALIC}${NC} de um Repositorio no GitHub"
echo -e " e   - Sair"


echo "+------------------------------------------------------------------------+"
while :
do
  read AUTGITHUB
  case $AUTGITHUB in
	c)
	create ;;
	x)
	delete ;;
    r)
	edit_repositoryName ;;
    d)
	edit_description ;;
    e)
    break  ;;
	
    
  esac
done
echo "Até a proxima :)"
