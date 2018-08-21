#!/bin/sh

show_directory_content(){
    #цвет директории
    BLUE='\033[1;34m'
    #цвет по умолчанию
    NC='\033[0m'
    content=`ls $1 --group-directories-first`
    for file in $content
    do                                
        if [ -f "${1}/${file}" ]
            then
                if [ "$2" != "" ]
                    then
                        echo "${2}|--${file}"
                else
                    echo "$file"
                fi
        #рекурсивно вызываем функцию, если встречаем директорию
        elif [ -d "${1}/${file}" ]
            then 
            if [ "$2" != "" ]
                then
                    echo "${2}|--${BLUE}${file}${NC}"
                    show_directory_content "${1}/${file}" "$2|  "
            else
                echo "${BLUE}${file}${NC}"
                show_directory_content "${1}/${file}" "$2  "
            fi
                
            
        fi
    done
}


if [ $# -gt "0" ]
    then 
        CURRENT_PATH="$1"
else
    CURRENT_PATH=`pwd`
fi
#если файл имеет невалидное название, например пробелы в названии, то
#это имя разобьется по пробелам и shell будет искать директории по этим
#отдельным словам

#IFS -- Input Field Separator
#по умолчанию это любой пробельный символ (пробел, табуляция, перенос)
#заменяем его на перенос, после построения дерева возвращаем прежнее занчение
OLDIFS=$IFS
IFS='
'
show_directory_content "$CURRENT_PATH" ""
IFS=$OLDIFS
exit 0