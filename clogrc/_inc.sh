#                                                              _
#  __ __ __ __ __ __ __ __ __  ___   ___   _ __   ___   _ _   | |_   ___  __ _
#  \ V  V / \ V  V / \ V  V / |___| / _ \ | '_ \ / -_) | ' \  |  _| (_-< / _` |
#   \_/\_/   \_/\_/   \_/\_/        \___/ | .__/ \___| |_||_|  \__| /__/ \__, |
#                                         |_|                            |___/
# build setup - copied from core/samples/hugo_inc.sh
# Create params to control the build
export PROJECT=$(basename $(pwd))          # generic project grabber

pBASE="opentsg"
pNAME="www-$pBASE"
# extract this semantic version from the config/_default/params.yaml
vCODE=$(cat config/_default/params.yaml | grep -A 4 "history:" | grep "version" | grep -oP "(v[0-9]+\.[0-9]+\.[0-9]+)")
vCodeType="Hugo"

# check that hugo is installed for building documentation
bDEPends=("Hugo")
bDEPtest=("hugo version >/dev/null 2>&1")
bDEPfail=("hugo not installed")
bDEPxtra=("see https://gohugo.io/installation/")

# check docker can run
bDEPends+=("dockerd running")
bDEPtest+=("docker --version 2>&1 >/dev/null")
bDEPfail+=("docker not installed")
bDEPxtra+=("start Docker Desktop or see https://docs.docker.com/engine/install/debian")

# check that CSS tools are in place
bDEPends+=("node installed")
bDEPtest+=("node --version 2>&1 >/dev/null" )
bDEPfail+=("node not installed")
bDEPxtra+=("install nvm and then nvm use latest")

bDEPends+=("SASS installed")
bDEPtest+=("sass --version 2>&1 >/dev/null")
bDEPfail+=("sass not installed")
bDEPxtra+=("npm install")
