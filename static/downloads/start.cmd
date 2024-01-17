: # start msgtsg docker image - parameters are optional
: #
: # mac:     zsh  tsg.start.cmd "/path/to/usr"  "nameOfImage"  "Version"
: # linux:   bash tsg.start.cmd "/path/to/usr"  "nameOfImage"  "Version"
: # windows:      tsg.start.cmd "/path/to/usr"  "nameOfImage"  "Version"
: # wsl:     bash tsg.start.cmd "/path/to/usr"  "nameOfImage"  "Version"
: #
: # default usr Folder is `~/otsg`
: # make a .env or edit this file to change defaults
:<<"::endHEREDOC"
@ECHO OFF & REM This runs as windows CMD
GOTO :WINDOWS_RESTART_WITH_WSL
::endHEREDOC
# -----------------------------------------------------------------------------
# set defaults - From here we run as a bash script
msgtsgUsr=~/otsg
msgtsgImage=msgtsg-lab-amd
msgtsgVer=latest
# -----------------------------------------------------------------------------
# colors;red ; grn; blu; cyn; mgn; ylw; blk; wht; off;
c="\e[3";R=1m;G=2m;B=4m;C=6m;M=5m;Y=3m;K=0m;W=7m;cX="\e[0m"
#  cmd   ;  url    ;  text   ;  info   ;  error  ; warning ; success ;  file   ; header
cC="$c$B";cU="$c$C";cT="$c$K";cI="$c$Y";cE="$c$R";cW="$c$M";cS="$c$G";cF="$c$W";cH="$c$G"
# -----------------------------------------------------------------------------
# detect linux platform
case "$(uname -s)" in
  Linux*) platform=Linux;; Darwin*) platform=Mac;; *) platform="untested:$(uname -s)";;
esac
# special platforms...
[[ $platform=="Linux" ]] && [[ -n "${WSL_DISTRO_NAME+x}" ]] && platform="wsl $WSL_DISTRO_NAME"
[[ $platform=="Linux" ]] &&  [ -n "${GITPOD_GIT_USER_NAME+x}" ]   && platform=GitPod
# m2 or other arm silicon
case $(uname -m) in arm*) msgtsgImage="msgtsg-lab-arm";; esac
# -----------------------------------------------------------------------------
# ---- overrides from the .env file -------------------------------------------
[ -f ".env" ] && source .env          # import parameters if .env exists
# ---- overrides from the command line ----------------------------------------
[ -n "$1" ] && msgtsgUsr=$1
[ -n "$2" ] && msgtsgImage=$2
[ -n "$3" ] && msgtsgVer=$3
# -----------------------------------------------------------------------------
mkdir -p $msgtsgUsr                   # ensure the usr folder exists

printf "$cW$platform$cT platform$cC tsg.start.cmd$cT\n"
printf "$cF$msgtsgUsr$cT on host stores $cF/usr$cT content for msgtsg-lab$cX\n"
printf "$cF$msgtsgImage:$cS$msgtsgVer$cT is the docker image that will run\n"
printf "${cE}Reload$cT the web page because a new token will be generated$cX\n\n"

# start the server & show the web page
printf "${cC}docker$cS run -it$cW -p 8888:8888$cI -v $msgtsgUsr:/home/jovyan/usr$cF $msgtsgImage:$cS$msgtsgVer$cX\n"
            docker    run -it  --rm  -p 8888:8888    -v "$msgtsgUsr:/home/jovyan/usr"  "$msgtsgImage:$msgtsgVer"
exit $?
# -----------------------------------------------------------------------------
# --------End of Mac / Linux boot code. Only Windows below this comment--------
# -----------------------------------------------------------------------------
#   Windows ': #' is ignored (illegal label syntax)
#   Linux   ': #' is heredoc comment syntax & ignored
#   Linux   ':<<"::endHEREDOC"' starts an inline doc terminated by "endHEREDOC"
#   Windows GOTO statement is hidden in the Linux HereDoc
# -----------------------------------------------------------------------------

:WINDOWS_RESTART_WITH_WSL
set usr="/mnt/c/Users/%USERNAME%/otsg"
echo MSGTSG Shell script for platform: Windows CMD / Powershell
echo The docker container needs to be run from a wsl command line.
echo.
echo Attempting to run ...
echo        wsl bash tsg.start.cmd %usr%
echo.
echo.
wsl bash tsg.start.cmd %usr%