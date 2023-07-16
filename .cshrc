
set prompt = "%{\033[1;32m%}%n@%m:%{\033[1;34m%}%~%{\033[0m%}%# "

setenv LS_COLORS "di=01;34"
setenv LS_COLORS "fi=01"
if ( -e ~/.alias) then
  source ~/.alias
endif

#vcs
setenv VCS_HOME /opt/eda/vcs/Q-2020.03-SP2-7
setenv VCS_ARCH_OVERRIDE linux
setenv VCS_TARGET_ARCH amd64
#dve
setenv DVE_HOME $VCS_HOME/gui/dve
setenv PATH "${DVE_HOME}/bin":"${VCS_HOME}/bin:"$PATH

#verdi
setenv VERDI_HOME "/opt/eda/verdi/verdi/R-2020.12-SP1"
setenv NOVAS_HOME "/opt/eda/verdi/verdi/R-2020.12-SP1"
setenv LD_LIBRARY_PATH "${NOVAS_HOME}/share/PLI/VCS/LINUX64"
setenv LD_LIBRARY_PATH "${VERDI_HOME}/share/PLI/lib/LINUX64":$LD_LIBRARY_PATH
setenv FSDB_HOME $VERDI_HOME/share/PLI/VCS/LINUX64
setenv PATH "${VERDI_HOME}/platform/LINUX64/bin":"${VERDI_HOME}/bin:"$PATH
setenv LD_LIBRARY_PATH "$VERDI_HOME/share/NPI/lib/LINUX64_GNU_620":$LD_LIBRARY_PATH

#scl
setenv SCL_HOME /opt/eda/scl/2021.12
setenv PATH "${SCL_HOME}/linux64/bin:"$PATH
#LICENSE
setenv SNPSLMD_LICENSE_FILE 27000@ROG
setenv LM_LICENSE_FILE 27000@ROG

alias lmg "lmgrd -c /opt/eda/Synopsys.dat"

