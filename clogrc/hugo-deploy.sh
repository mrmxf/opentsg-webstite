#  clog> deploy
# short> upload docker image to docker hub
# extra>  no support for TGZ as yet
#   _                                   _                _
#  | |_    _  _   __ _   ___   ___   __| |  ___   _ __  | |  ___   _  _
#  | ' \  | || | / _` | / _ \ |___| / _` | / -_) | '_ \ | | / _ \ | || |
#  |_||_|  \_,_| \__, | \___/       \__,_| \___| | .__/ |_| \___/  \_, |
#                |___/                           |_|               |__/

[ -f clogrc/check.sh ] && source clogrc/check.sh  ignore-errors     # preflight
printf "${cC}Build$cT Project$cS $PROJECT$cT built on $bCPU $bOSV$cX\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check the build

repo="mrmxf/"    ; [ -n "$otsgREPO" ]    && repo="$otsgREPO"
base=$pNAME      ; [ -n "$otsgBASE" ]    && base="$otsgBASE"
armx="arm"       ; [ -n "$otsgARMx" ]    && armx="$otsgARMx"
amdx="amd"       ; [ -n "$otsgAMDx" ]    && amdx="$otsgAMDx"
tver=$vREF       ; [ -n "$otsgLABv" ]    && tver="$otsgLABv"

bHEADING=(     "${cH}    arm64${cT}"      "${cI}Intel-AMD${cT}"   )
bTARGET=(      "linux/arm64"              "linux/amd64"           )
bHUBimage=(    "$repo$base-$armx:$tver"   "$repo$base-$amdx:$tver")
bTGZfilename=( "$base-$armx-$trel.tgz"    "$base-$amdx-$trel.tgz" )
bHashCache=(   "tmp/id-docker-arm.txt"    "tmp/id-docker-amd.txt" )

fDivider
for i in ${!bHUBimage[@]}; do
  printf "${cI}INFO ${bHEADING[$i]} push to hub $cT(ctrl-C to abort)$cX\n"

  #printf "${cH}DEBUG$cT platform=$cC%s$cT node=$cC%s$cT " "${bTARGET[$i]}" "${bARGnode[$i]}"
  #printf "lib=$cC%s$cT tag1=$cC%s$cT tag2=$cC%s$cX\n"      "$SeventhSO"     "${bHUBimage[$i]}"  "${bTAGimage[$i]}"

  docker image push --quiet "${bHUBimage[$i]}"
  [ $? -gt 0 ] && printf "${cE}FAIL ${bHEADING[$i]} push to hub$cX\n" && exit 1

  printf "${cS}SUCCES ${bHEADING[$i]} pushed to hub.$cX\n"
done