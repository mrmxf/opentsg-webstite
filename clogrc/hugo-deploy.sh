#  clog> stage
# short> execute stage.sh to build & upload {{REPO}} to staging
# extra>  execute stage.sh to build & upload {{REPO}} to staging. No other option needed. Edit script to configure upload.
#        _                                             _
#   __  | |  ___   __ _     ___  __ _   _ __    _ __  | |  ___
#  / _| | | / _ \ / _` |   (_-< / _` | | '  \  | '_ \ | | / -_)
#  \__| |_| \___/ \__, |   /__/ \__,_| |_|_|_| | .__/ |_| \___|
#                 |___/                        |_|

source clogrc/core/inc.sh
thisFolder=$(pwd)
REPO=$(basename $thisFolder)
PROJECT="Project(${cS}$REPO${cT})"
fInfo "$PROJECT script$cF $(basename $0)"
# ------------------------------------------------------------------------------

 CACHE=$MM_CACHE
   BOT=$MM_BOT
BRANCH="staging"

if [ -z $CACHE ] ; then fError "env$cE MM_CACHE$cT is not set" ; exit 1 ; fi
if [ -z $BOT ]   ; then fError "env$cE MM_BOT$cT is not set" ; exit 1 ; fi
if [ -z $REPO ]  ; then fError "env$cE GITPOD_REPO_ROOT$cT is not set" ; exit 1 ; fi

SRC="opentpg + libs"

OPT="--include \"*\" "
ACTION=Upload

# do preflight checks & abort if user does not want to continue
source clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync(upload) - one per line
# SYNCS=(
#   "$OPT site/folder1   $CACHE/$BOT/$BRANCH/$REPO/folder1"
#   "$OPT site/folder2   $CACHE/$BOT/$BRANCH/$REPO/folder2"
# )

# do sync
# fSync

EXE="lamd-otpg"
ZIP="$EXE-so.zip"

# do anything remedial like single file copies here....
fInfo "$PROJECT create$cF $ZIP$cX"
zip -j tmp/$ZIP lib/*

fInfo "$PROJECT sync$cF tmp/$ZIP"
aws s3 cp         ./tmp/$ZIP           $CACHE/$BOT/$BRANCH/get/$ZIP

fInfo "$PROJECT removing .zip"
rm $ZIP

# ------------------------------------------------------------------------------
fInfo "$PROJECT sync$cF tpg builds"

source clogrc/build-variants.sh

for (( i=0; i<${#gOS[@]}; i++ ));
do
  fInfo "sync ${cVER[$i]}${FILE[$i]}${cT} (${gOS[$i]} for ${gARCH[$i]})"
  aws s3 cp       ./${FILE[$i]}               $CACHE/$BOT/$BRANCH/get/${FILE[$i]}
done

aws s3 cp         ./clogrc/opentsg-installer.sh     $CACHE/$BOT/$BRANCH/get/opentsg-install.cmd
