#  clog> hugo
# short> start the hugo server
#                                                              _
#  __ __ __ __ __ __ __ __ __  ___   ___   _ __   ___   _ _   | |_   ___  __ _
#  \ V  V / \ V  V / \ V  V / |___| / _ \ | '_ \ / -_) | ' \  |  _| (_-< / _` |
#   \_/\_/   \_/\_/   \_/\_/        \___/ | .__/ \___| |_||_|  \__| /__/ \__, |
#                                         |_|                            |___/
source clogrc/core/inc.sh

CMD="hugo server --buildDrafts --environment staging"
fInfo "running$cC$CMD$cX"
$CMD