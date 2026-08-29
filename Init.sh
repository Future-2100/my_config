#/bin/bash

set -euo pipefail

for FILES in Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos; do
  rm -rf ${HOME}/${FILES}
done

export INIT_HOME=`pwd`

# Basic Setting of Bash and Vim
cat << 'EOF' >> ${HOME}/.bashrc
green="\[\e[1;32m\]"
yellow="\[\e[1;33m\]"
blue="\[\e[1;36m\]"
reset="\[\e[0m\]"
export PS1="$green[\u$reset@$yellow\h$reset]$blue\w$reset \$ "

cdls() {
  builtin cd $1;
  ls
}
alias cd='cdls'
EOF

cat << 'EOF' >> ${HOME}/.vimrc
syntax on

set background=dark

set number
set rnu
set tabstop=2
set expandtab
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%)

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.

set shiftwidth=2
set softtabstop=2
set cmdheight=1
set laststatus=2

nnoremap <C-k> <C-v>
EOF


# Change the Tencent Mirror Source
sudo cp -r /etc/yum.repos.d /etc/yum.repos.d.backup
#sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
#  -e 's|^# baseurl=https://repo.almalinux.org|baseurl=https://mirrors.tencent.com|g' \
#  -i.bak \
#  /etc/yum.repos.d/almalinux*.repo
#
#sudo dnf makecache
#sudo dnf upgrade -y
#sudo dnf clean all

sudo dnf install tmux -y
sudo dnf install csh ksh -y
sudo dnf install gvim -y

sudo dnf groupinstall "Development Tools" -y

# Cadence dependency
for DEP in openmotif mesa-libGLU libXScrnSaver ncurses-compat-libs xcb-util-wm xcb-util-image xcb-util-keysyms xcb-util-renderutil libnsl redhat-lsb ; do
  sudo dnf install ${DEP} -y
done

tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_1of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_2of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_3of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_4of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_5of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_6of7.tar
tar -xvf ${INIT_HOME}/Cadence/Base_DDI25.10.000_lnx86_7of7.tar

export TOOLS_HOME=/tools
export CADENCE_HOME=${TOOLS_HOME}/Cadence
export SYNOPSYS_HOME=${TOOLS_HOME}/Synopsys


mkdir -p ${TOOLS_HOME}
mkdir -p ${CADENCE_HOME}
mkdir -p ${SYNOPSYS_HOME}
mkdir -p ${CADENCE_HOME}/iscape


#######################################################################################################
#                                         Installing Cadence
#######################################################################################################
tar -xZf ${INIT_HOME}/DDI25.10.000_lnx86.Base/CDROM1/IScape05.01-p001lnx86.t.Z -C ${CADENCE_HOME}/iscape
export ISCAPE_HOME=${CADENCE_HOME}/iscape/iscape

${ISCAPE_HOME}/bin/iscape.sh -batch MajorAction=InstallFromArchive \
  ArchiveDirectory=${INIT_HOME}/DDI25.10.000_lnx86.Base/CDROM1 \
  InstallDirectory=${CADENCE_HOME}


tar -xzvf ${INIT_HOME}/ocad.tar.gz -C ${INIT_HOME}
cp ${INIT_HOME}/ocad/tools/licsrv/generator/cdslic.gen/cds.license.dat ${CADENCE_HOME}/Cadence.dat
sed -i "s|HOSTNAME|`hostname`|g" ${CADENCE_HOME}/Cadence.dat

HOSTID=`${INIT_HOME}/ocad/tools/licsrv/bin/lmhostid | grep -oE '[0-9a-f]{12}'`
sed -i "s|YOURHOSTID|${HOSTID}|g" ${CADENCE_HOME}/Cadence.dat

cp ${INIT_HOME}/ocad/tools/licsrv/bin/bin.cds/cdslmd ${CADENCE_HOME}/
sed -i "s|/software/ocad/tools/licsrv/bin/cdslmd|${CADENCE_HOME}/cdslmd|g" ${CADENCE_HOME}/Cadence.dat

cp ${INIT_HOME}/ocad/tools/licsrv/bin/bin.cds/lmgrd ${CADENCE_HOME}
cp ${INIT_HOME}/ocad/tools/licsrv/bin/bin.cds/lmdown ${CADENCE_HOME}
${INIT_HOME}/ocad/bin/1patch -ecc ${CADENCE_HOME}


cat << 'EOF' >> ${HOME}/.bashrc
export TOOLS_HOME=/tools

###################################### Cadence Environment Variable ###########################
export CADENCE_HOME=${TOOLS_HOME}/Cadence

export INNOVUS_HOME=${CADENCE_HOME}/INNOVUS251
export GENUS_HOME=${CADENCE_HOME}/GENUS251

export LM_LICENSE_FILE=${CADENCE_HOME}/Cadence.dat

alias cds_lmg="${CADENCE_HOME}/lmgrd -c ${CADENCE_HOME}/Cadence.dat -l /tmp/cds.license.log"
export PATH=${PATH}:${INNOVUS_HOME}/bin:${GENUS_HOME}/bin

innovus() {
  ksh -c ${INNOVUS_HOME}/bin/innovus $1;
}
EOF



#######################################################################################################
#                                         Installing Synopsys
#######################################################################################################
export INSTALLER_HOME=${SYNOPSYS_HOME}/installer
${INIT_HOME}/Synopsys/SynopsysInstaller_v5_8/SynopsysInstaller_v5.8.run -dir ${INSTALLER_HOME}

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/scl_v24.06 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64 \
  -product scl

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/verdi_vW-2024.09-SP1 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64 \
  -product verdi

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/vcs_all_vW-2024.09-SP1 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/syn_vW-2024.09-SP1 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/pt_vW-2024.09-SP3 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64

${INSTALLER_HOME}/installer \
  -source ${INIT_HOME}/Synopsys/vc_static_vW-2024.09-SP1 \
  -target ${SYNOPSYS_HOME} \
  -platform common -platform linux64 \
  -product vc_static

cp ${INIT_HOME}/pubkey1.6/Synopsys.dat ${SYNOPSYS_HOME}
sed -i "s|YOURHOSTID|${HOSTID}|g" ${SYNOPSYS_HOME}/Synopsys.dat
sed -i "s|DAEMON snpslmd|DAEMON snpslmd ${SYNOPSYS_HOME}/scl/2024.06/linux64/bin/snpslmd|g" ${SYNOPSYS_HOME}/Synopsys.dat
${INIT_HOME}/pubkey1.6/SynopsysMonoSlayer -d ${SYNOPSYS_HOME} -a
${INIT_HOME}/ocad/bin/1patch -ecc ${SYNOPSYS_HOME}


cat << 'EOF' >> ${HOME}/.bashrc

###################################### Synopsys Environment Variable ###########################
export SYNOPSYS_HOME=${TOOLS_HOME}/Synopsys

export SNPSLMD_LICENSE_FILE=27000@localhost.localdomain

export VCS_HOME=${SYNOPSYS_HOME}/vcs/W-2024.09-SP1
export VERDI_HOME=${SYNOPSYS_HOME}/verdi/W-2024.09-SP1
export DC_HOME=${SYNOPSYS_HOME}/syn/W-2024.09-SP1
export VC_STATIC_HOME=${SYNOPSYS_HOME}/vc_static/W-2024.09-SP1
export PT_HOME=${SYNOPSYS_HOME}/prime/W-2024.09-SP3
export SCL_HOME=${SYNOPSYS_HOME}/scl/2024.06

export LD_LIBRARY_PATH=${VERDI_HOME}/share/PLI/VCS/linux64

export LM_LICENSE_FILE=${LM_LICENSE_FILE}:${SYNOPSYS_HOME}/Synopsys.dat

alias syn_lmg="${SCL_HOME}/linux64/bin/lmgrd -c ${SYNOPSYS_HOME}/Synopsys.dat -l /tmp/syn.license.log"
alias lmdown="${CADENCE_HOME}/lmdown -all; ${SCL_HOME}/linux64/bin/lmdown -all"
export PATH=${PATH}:${VCS_HOME}/bin:${VERDI_HOME}/bin:${PT_HOME}/bin:${DC_HOME}/bin:${VC_STATIC_HOME}/bin:${SCL_HOME}/linux64/bin

vcs64() {
  vcs -full64 $1;
}

EOF


############################ install clash #############################
export CLASH_HOME=${TOOLS_HOME}/Clash

curl https://glados.one/tools/clash-linux.zip -o ${TOOLS_HOME}/clash.zip
unzip ${TOOLS_HOME}/clash.zip -d ${TOOLS_HOME}
mv ${TOOLS_HOME}/clash ${CLASH_HOME}

curl https://update.glados-config.com/clash/221274/194e6fa/133276/glados-terminal.yaml > ${CLASH_HOME}/glados.yaml
mv ${CLASH_HOME}/clash-linux-amd64-v1.10.0 ${CLASH_HOME}/clash
chmod +x ${CLASH_HOME}/clash

cat << 'EOF' >> ${HOME}/.bashrc

export CLASH_HOME=${TOOLS_HOME}/Clash
alias clash="${CLASH_HOME}/clash -f ${CLASH_HOME}/glados.yaml -d ${CLASH_HOME}"

EOF


