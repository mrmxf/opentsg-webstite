#  clog> build
# short> build a hugo project
# extra> sample script
#   _                                _             _   _      _
#  | |_    _  _   __ _   ___   ___  | |__   _  _  (_) | |  __| |
#  | ' \  | || | / _` | / _ \ |___| | '_ \ | || | | | | | / _` |
#  |_||_|  \_,_| \__, | \___/       |_.__/  \_,_| |_| |_| \__,_|
#                |___/

[ -f clogrc/check.sh ] && source clogrc/check.sh  ignore-errors     # preflight
printf "${cC}Build$cT Project$cS $PROJECT$cT built on $bCPU $bOSV$cX\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check the build depenedencies exist
err=0
for i in ${!bDEPtest[@]}; do
  printf "Checking dependency $cI%s$cT: $cC%s$cX\n" "${bDEPends[$i]}" "${bDEPtest[$i]}"
  eval "${bDEPtest[$i]}"
  [ $? -gt 0 ] && printf "${cE}FAIL$cW ${bDEPfail[$i]} $cT${bDEPxtra[$i]}$cX\n" && err=1
done
(( $err )) && printf "${cE}ABORT${cX}ing\n" && exit 1

# -----------------------------------------------------------------------------
# export the commit ID & date & type for the build
DATE=$(date +%F)
gBRANCH="$( git branch --show-current )"
[[ "main" == "$gBRANCH" ]] && gBRANCH=""

# -----------------------------------------------------------------------------
# pull in any keys for uploads/builds etc.
[ ! -f .env ] && printf "${cI}No$cF .env$cT using default script values\n"
[   -f .env ] && source .env
# -----------------------------------------------------------------------------
# parameters for the build - override defaults if set in .env

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

CMD="rm -fr public/*"
fInfo "purging old builds:  $ $cC$CMD$cX"
$CMD

CMD="hugo"
fInfo "building$cC hugo$cT site into docker container $cF$CONTAINER$cX"
$CMD

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# build into with release and version tags
fDivider
for i in ${!bHUBimage[@]}; do
  printf "${cI}INFO ${bHEADING[$i]} build $cT(ctrl-C to abort)$cX\n"

  #printf "${cH}DEBUG$cT platform=$cC%s$cT node=$cC%s$cT " "${bTARGET[$i]}" "${bARGnode[$i]}"
  #printf "lib=$cC%s$cT tag1=$cC%s$cT tag2=$cC%s$cX\n"      "$SeventhSO"     "${bHUBimage[$i]}"  "${bTAGimage[$i]}"

  docker buildx build . \
       --platform  "${bTARGET[$i]}" \
       --tag       "${bHUBimage[$i]}"
  [ $? -gt 0 ] && printf "${cS}FAIL ${bHEADING[$i]} build failed$cX\n" && exit 1

  imgHash=$(docker images | grep "${bHUBimage[$i]}" | awk '{print $3}')
  oldHash=$( head -n 1 "${bHashCache[$i]}" 2>/dev/null)
  uploaded=$(head -n 2 "${bHashCache[$i]}" 2>/dev/null)

  buildChanged=""
  [[ "$imgHash" != "$oldHash" ]] && buildChanged="hash=$imgHash, was $oldHash"
  needsUpload="Yes"
   [ -z "buildChanged" ] && [ -n "uploaded" ] && needsUpload=""

  printf "${cS}SUCCES ${bHEADING[$i]} build $imgHash $buildChanged OK$cX\n"
done