#  clog> GPtasks [ before | init | command ]
# short> HUGO: run at Gitpod's before | init | command status
# extra> default status to run is command
#   _                                                    _                 _
#  | |_    _  _   __ _   ___   ___   __ _   _ __   ___  | |_   __ _   ___ | |__  ___
#  | ' \  | || | / _` | / _ \ |___| / _` | | '_ \ |___| |  _| / _` | (_-< | / / (_-<
#  |_||_|  \_,_| \__, | \___/       \__, | | .__/        \__| \__,_| /__/ |_\_\ /__/
#                |___/              |___/  |_|
CLOGRC=clogrc
source $CLOGRC/core/inc.sh
source $CLOGRC/core/installers.sh
printf "${cI}Installable apps: $cC$cINSTALL_LIST$cX\n"

case $1 in
  "before" | "init" | "command")  ACTION="$1" ;;
   *)          echo -e "$cW Warning$cT option$cC before$cT |$cC init$cT |$cC command$cT nussubg. Using default $cC command$cX"
              ACTION="command" ;;
esac

# ------------------------------------------------------------------------------
#   _             __
#  | |__   ___   / _|  ___   _ _   ___
#  | '_ \ / -_) |  _| / _ \ | '_| / -_)
#  |_.__/ \___| |_|   \___/ |_|   \___|
# ------------------------------------------------------------------------------
if [[ "$ACTION" == "before" ]] ; then

  fInfo    "${cK}gitpod$cC BEFORE$cT tasks"

fi

# ------------------------------------------------------------------------------
#   _          _   _
#  (_)  _ _   (_) | |_
#  | | | ' \  | | |  _|
#  |_| |_||_| |_|  \__|
# ------------------------------------------------------------------------------

if [[ "$ACTION" == "init" ]] ; then

  fInfo    "${cK}gitpod$cC INIT$cT tasks"
  fDivider

fi

# ------------------------------------------------------------------------------
#                                               _
#   __   ___   _ __    _ __    __ _   _ _    __| |
#  / _| / _ \ | '  \  | '  \  / _` | | ' \  / _` |
#  \__| \___/ |_|_|_| |_|_|_| \__,_| |_||_| \__,_|
# ------------------------------------------------------------------------------

if [[ "$ACTION" == "command" ]] ; then

  fInfo    "${cK}gitpod$cC COMMAND$cT tasks"
  fDivider

  fInstall aws
  fInstall clog
  # fInstall cuttlebelle
  # fInstall ffmpeg
  fInstall hugo
  # fInstall nvm
  # fInstall opentpg
  # fInstall terraform
  fInstall yarn
  # fInstall zmp

  # update the themes
  git submodule init
  git submodule update

  # update theme node components
  themeList=( $(ls -dF themes/*) ) #make an array from the space separated list
  HOMEFOLDER=$(pwd)
  for f in "${folderList[@]}" ; do
    cd $f
    yarn
    cd $HOMEFOLDER
  done

  fDivider
  fInfo "Your public IP address in $cW $(curl --no-progress-meter https://api.ipify.org?format=text)$cX"
  fDivider

fi
