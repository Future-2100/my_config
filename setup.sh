#!/bin/csh

cd
echo "----------- begin to install softwares ---------------" > setup.log
sudo yum update
sudo yum upgrade
foreach software ( gcc-c++ man git tree net-tools ctags vim make gdb csh tmux llvm perl python3 autoconf flex bison numactl automake curl gawk texinfo gperf libtool patchutils bc help2man openssh-server libXScrnSaver glibc.i686 )
  sudo yum install $software -y
  if ($? == 0) then 
    echo "$software --- success" >> setup.log
  else 
    echo "$software --- fail" >> setup.log
  endif
end
echo "----------- install softwares finished ---------------" >> setup.log
cat setup.log

#  ssh
#  lsb-core
#  build-essential
#  gcc-doc
#  libreadline-dev
#  libsdl2-dev
#  llvm-dev
#  llvm-11
#  llvm-11-dev
#  g++-riscv64-linux-gnu
#  binutils-riscv64-linux-gnu
#  libgoogle-perftools-dev
#  perl-doc
#  libfl2
#  libfl-dev
#  zlib1g
#  zlib1g-dev
#  libsdl2-image-dev
#  device-tree-compiler
#  gdb-multiarch
#  qemu-system-misc
#  gcc-riscv64-linux-gnu
#  autotools-dev
#  libmpc-dev
#  libmpfr-dev
#  libgmp-dev
#  libexpat-dev
#  ninja-build
