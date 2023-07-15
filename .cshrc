
set prompt = "%{\033[1;32m%}%n@%m:%{\033[1;34m%}%~%{\033[0m%}%# "

setenv LS_COLORS "di=01;34"
setenv LS_COLORS "fi=01"
if ( -e ~/.alias) then
  source ~/.alias
endif


