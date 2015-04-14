#!/bin/bash

PROTO=git
MIRROR=github.com/openxt
#Grab upstream sources
REPOS="pv-linux-drivers xctools v4v"
DEB_TREES="xc-vusb-dkms-1.0 libv4v-1.0 v4v-dkms-1.0 xenmou-dkms-1.0"

cd /tmp

for repo in $REPOS;
do
	git clone $PROTO://$MIRROR/$repo.git
done

#organize sources and combine with debian trees...

#xc-vusb
cp -R pv-linux-drivers/xc-vusb/* xc-vusb-dkms-1.0/

#libv4v
cp -R v4v/libv4v/* libv4v-1.0/

#v4v
cp -R v4v/v4v/* v4v-dkms-1.0/

#xenmou
cp -R xctools/xenmou/* xenmou-dkms-1.0/


#Apply any necessary patches and build the deb packages, installing any dependencies needed
#v4v
cd v4v-dkms-1.0
cd debian
quilt push
cd ..
dpkg-buildpackage -us -uc
cd ..
dpkg -i v4v-dev*.deb

#libv4v
cd libv4v-1.0
dpkg-buildpackage -us -uc
cd ..

#xc-vusb
cd xc-vusb-dkms-1.0
dpkg-buildpackage -us -uc
cd ..

#xenmou
cd xenmou-dkms-1.0
dpkg-buildpackage -us -uc
cd ..

#




