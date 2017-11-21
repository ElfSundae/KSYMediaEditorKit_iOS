set -e

######################
## build tools
#######################
if [[ -d buildTools ]]; then
    echo "rm build"
    rm -rf buildTools
fi
git clone git@newgit.op.ksyun.com:sdk/buildTools.git
source buildTools/iOS/build_tools.sh
TAG2MR=`pwd`/buildTools/tag2mr.py

#######################
## git repos 
#######################
DEMO_URL=newgit.op.ksyun.com:sdk/KSYLive_iOS.git
DEP_URL=newgit.op.ksyun.com:sdk/libksylivedep.git
# branch or commit id
DEMO_ID=origin/master
DEP_ID=origin/master

echo "====================== check dep repos  ========"
checkEnvVar KSYLIVEDEMO_DIR KSYLIVEDEP_DIR 
if [[ -n "$CI_BUILD_REF_NAME" ]]; then
    checkBuildEnv ${DEMO_URL} ${KSYLIVEDEMO_DIR} ${DEMO_ID} 
    checkBuildEnv ${DEP_URL} ${KSYLIVEDEP_DIR} ${DEP_ID}
fi

echo "====================== build static lib  ========"
pod repo update
pod install
xcodebuild -workspace *.xcwork* -scheme demo -quiet