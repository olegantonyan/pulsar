#!/usr/bin/env bash

source ~/.profile

set -xEeuo pipefail

BUILDROOT=$1
#NAME=${installable_package_name:-pulsar}
NAME=$2

nvm install
npm install -g yarn
corepack enable
nvm use
node -v

yarn install
yarn build
yarn build:apm

yarn dist tar.gz

mkdir -p $BUILDROOT/usr/lib/$NAME
tar xf dist/*.tar.gz -C $BUILDROOT/usr/lib/$NAME --strip-components=1
rm -rf $BUILDROOT/usr/lib/$NAME/resources/app/ppm/spec # shebang in some files there messes up the dependencies

mkdir -p $BUILDROOT/usr/bin/
ln -sf /usr/lib/$NAME/resources/pulsar.sh $BUILDROOT/usr/bin/$NAME
ln -sf /usr/lib/$NAME/resources/app/ppm/bin/apm $BUILDROOT/usr/bin/ppm

mkdir -p $BUILDROOT/usr/share/applications
NAME_C="${NAME^}"
ICON="$NAME"
cat <<'EOF' | sed "s/{{name}}/$NAME_C/" | sed "s/{{icon}}/$ICON/" | sed "s/{{installpath}}/\/usr\/lib\/$NAME/" > $BUILDROOT/usr/share/applications/$NAME.desktop
[Desktop Entry]
Name={{name}}
Exec={{installpath}}/pulsar --no-sandbox %U
Terminal=false
Type=Application
Icon={{icon}}
StartupWMClass=Pulsar
Comment=A Community-led Hyper-Hackable Text Editor
Categories=Development;
EOF

mkdir -p $BUILDROOT/usr/share/icons/hicolor/16x16/apps/
cp resources/icons/16x16.png $BUILDROOT/usr/share/icons/hicolor/16x16/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/22x22/apps/
cp resources/icons/22x22.png $BUILDROOT/usr/share/icons/hicolor/22x22/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/24x24/apps/
cp resources/icons/24x24.png $BUILDROOT/usr/share/icons/hicolor/24x24/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/32x32/apps/
cp resources/icons/32x32.png $BUILDROOT/usr/share/icons/hicolor/32x32/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/48x48/apps/
cp resources/icons/48x48.png $BUILDROOT/usr/share/icons/hicolor/48x48/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/64x64/apps/
cp resources/icons/64x64.png $BUILDROOT/usr/share/icons/hicolor/64x64/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/128x128/apps/
cp resources/icons/128x128.png $BUILDROOT/usr/share/icons/hicolor/128x128/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/256x256/apps/
cp resources/icons/256x256.png $BUILDROOT/usr/share/icons/hicolor/256x256/apps/$ICON.png
mkdir -p $BUILDROOT/usr/share/icons/hicolor/384x384/apps/
cp resources/icons/384x384.png $BUILDROOT/usr/share/icons/hicolor/384x384/apps/$ICON.png
