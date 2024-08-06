#!/bin/zsh

# SideJITServer (libplist3, usbmuxd, python3.11)
[[ $(dpkg -l | grep usbmuxd)                       == ""                   ]] &&
{ sudo apt update                                                            ;
  sudo apt install -y libplist3 usbmuxd                                      ; }
[[ $(python3 --version | sed -E -e 's/[^0-9]//g') -lt 3110                 ]] &&
{ cd /tmp/ && wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz;
  tar -xzvf Python-3.11.9.tgz                                                ;
  cd Python-3.11.9/                                                          ;
  ./configure --enable-loadable-sqlite-extensions --enable-optimizations     ;
  sudo make altinstall; sudo apt reinstall python3-pip                       ;
  echo "installation complete, please run the script again!"         ; exit 0; }
####
[[ $(python3 --version | sed -E -e 's/[^0-9]//g') -lt 3110                 ]] &&
sudo python3.11 -m pip install --no-cache-dir --upgrade SideJITServer         ||
[[ $(which SideJITServer)                          ==   ""                 ]] &&
{ sudo apt update                                                            ;
  sudo apt install pipx                                                      ;
  pipx reinstall SideJITServer                                               ; }
####
sudo usbmuxd --exit                                            &> /dev/null
sudo usbmuxd                                                   &> /dev/null
sudo "$(which SideJITServer)" "$@"

####
####
