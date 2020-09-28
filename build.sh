#!/bin/bash

REPO_NAME=$1
echo "Cloning remote repository."
cd /spring/
#In order to clone a specific branch, e.g. a tagged release, you may add an additional argument --branch=<BRANCH_NAME>
git clone --recursive https://github.com/kit-data-manager/$REPO_NAME.git
cd $REPO_NAME

echo "Building project from source."
./gradlew -Prelease build

for jarFile in build/libs/*.jar
echo #!/bin/bash > /spring/$REPO_NAME/run.sh
echo cd /spring/$REPO_NAME >> /spring/$REPO_NAME/run.sh
echo java -cp ".:./config:./$REPO_NAME.jar" -Dloader.path=file://`pwd`/$jarFile,./lib/,. -jar $jarFile >> /spring/$REPO_NAME/run.sh

echo "Build done."
