#!/bin/bash

### READ UPDATES IN ADDITIONAL COMMENTS DOWN BELOW (not in this file, but comments.)

###############################################################################
## Scala kernel for Jupyter
## https://github.com/alexarchambault/jupyter-scala
###############################################################################

sudo apt-get install build-essential -y
sudo apt-get install python3-all python3-pip -y
sudo apt-get install libncurses5-dev libncursesw5-dev libzmq3-dev -y
sudo apt-get build-dep python3 ipython3-notebook ipython3-qtconsole -y

# OPTIONAL: you may or may not be interested on a virtual environment.
export virtualenv_name=j8s11
if [ ! -z "$virtualenv_name" ];then
  sudo apt-get install virtualenvwrapper -y
fi

# location where Java, Scala and other tools are installed
export tools=/opt/developer

# remaining of configuration is done in a sub-shell
bash <<EOD
  if [ ! -z "$virtualenv_name" ];then
    if [ ! -d ~/.virtualenvs/${virtualenv_name} ] ;then
      source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
      mkvirtualenv -p $(which python3) ${virtualenv_name}
      pushd ~/.virtualenvs/${virtualenv_name}/bin
      wget https://gist.githubusercontent.com/frgomes/6f5577bc1898445dd1f8/raw/cf884f4d697f34e12f1dc5b81e4f44b665dcd787/postactivate
      popd
    fi
    workon ${virtualenv_name}
  fi
  
  # install IPython
  pip install --upgrade "ipython[all]"

  # install the Scala backend for IPython
  mkdir -p ~/Downloads
  pushd ~/Downloads
  if [ ! -f jupyter-scala_2.11.6-0.2.0-SNAPSHOT.tar.xz ] ;then
    wget https://oss.sonatype.org/content/repositories/snapshots/com/github/alexarchambault/jupyter/jupyter-scala-cli_2.11.6/0.2.0-SNAPSHOT/jupyter-scala_2.11.6-0.2.0-SNAPSHOT.tar.xz
  fi
  popd

  # uncompress Jupyter somewhere
  sudo mkdir -p ${tools}
  pushd ${tools}
  sudo tar xpf ~/Downloads/jupyter-scala_2.11.6-0.2.0-SNAPSHOT.tar.xz
  popd

  # Run this once
  ${tools}/jupyter-scala_2.11.6-0.2.0-SNAPSHOT/bin/jupyter-scala
EOD

if [ ! -z "$virtualenv_name" ];then
  if [ -d ~/.virtualenvs/${virtualenv_name} ] ;then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    workon ${virtualenv_name}
  fi
fi

# create a folder for notebooks
mkdir -p ~/Documents/jupyter
cd ~/Documents/jupyter
  
# Now, it's ready for use:
ipython notebook
