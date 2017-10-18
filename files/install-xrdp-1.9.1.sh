################################################################
# Script_Name : install-xrdp-1.9.1.sh
# Description : Perform an automated custom installation of xrdp
# on ubuntu 16.04.3
# Date : August 2017
# written by : Griffon
# Web Site :http://www.c-nergy.be - http://www.c-nergy.be/blog
# Version : 1.9
# Disclaimer : Script provided AS IS. Use it at your own risk....
##################################################################

#---------------------------------------------------#
# Step 0 - Try to Detect Ubuntu Version.... 
#---------------------------------------------------#
uversion=$(lsb_release -d | grep -o 16.04.3)
export workdir="/tmp"

if [ $uversion = "16.04.3" ]
then
echo
/bin/echo -e "\e[1;32mSupported version detected....proceeding\e[0m"
/bin/echo -e "\e[1;32m-----------------------------------------\e[0m"
echo
else
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
/bin/echo -e "\e[1;31mYour system is not running Ubuntu 16.04.3 Edition.\e[0m"
/bin/echo -e "\e[1;31mThe script has been tested only on Ubuntu 16.04.3...\e[0m"
/bin/echo -e "\e[1;31mThe script is exiting...\e[0m"
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
echo
exit
fi

UI=$(which unity)
if [ $UI = "/usr/bin/unity" ]
then 
/bin/echo -e "\e[1;32mUnity Desktop interface Detected....proceeding\e[0m"
/bin/echo -e "\e[1;32m-----------------------------------------------\e[0m"
echo
else
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
/bin/echo -e "\e[1;31mYour system is not running Unity Desktop Interface.\e[0m"
/bin/echo -e "\e[1;31mThe script has been written to enable Unity Desktop in remote session...\e[0m"
/bin/echo -e "\e[1;31mThe script is exiting...\e[0m"
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
exit
fi

#---------------------------------------------------#
# Step 1 - Download XRDP Binaries... 
#---------------------------------------------------#




## -- Download the xrdp latest files
/bin/echo -e "\e[1;32mPreparing download xrdp package\e[0m"
/bin/echo -e "\e[1;32m-------------------------------\e[0m"
apt-get -y -qq install git
cd ${workdir}
echo "Changed to new Workdir: ${PWD}"

echo
git clone https://github.com/neutrinolabs/xrdp.git
/bin/echo -e "\e[1;32mPreparing download xorgxrdp package\e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo
git clone https://github.com/neutrinolabs/xorgxrdp.git

echo "chmod to allow everyone rw to ${workdir}/xrdp and ${workdir}/xorgxrdp"
chmod a+rw -R "${workdir}/xrdp" "${workdir}/xorgxrdp"

#---------------------------------------------------#
# Step 2 - Install Prereqs... 
#---------------------------------------------------#

/bin/echo -e "\e[1;32mInstall PreReqs\e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo
apt-get -y install libx11-dev libxfixes-dev libssl-dev libpam0g-dev libtool libjpeg-dev flex bison gettext autoconf libxml-parser-perl libfuse-dev xsltproc libxrandr-dev python-libxml2 nasm xserver-xorg-dev fuse

#---------------------------------------------------#
# Step 3 - create the fontutil.h file... 
#---------------------------------------------------#

/bin/echo -e "\e[1;32mIntegrating fix for fontutil bug in ubuntu\e[0m"
/bin/echo -e "\e[1;32m--------------------------------------------\e[0m"
echo
cat >/usr/include/X11/fonts/fontutil.h <<EOF
#ifndef _FONTUTIL_H_
#define _FONTUTIL_H_

#include <X11/fonts/FSproto.h>

extern int FontCouldBeTerminal(FontInfoPtr);
extern int CheckFSFormat(fsBitmapFormat, fsBitmapFormatMask, int *, int *,
     int *, int *, int *);
extern void FontComputeInfoAccelerators(FontInfoPtr);
extern void GetGlyphs ( FontPtr font, unsigned long count,    
             unsigned char *chars, FontEncoding fontEncoding,    
             unsigned long *glyphcount, CharInfoPtr *glyphs );
extern void QueryGlyphExtents ( FontPtr pFont, CharInfoPtr *charinfo,    
            unsigned long count, ExtentInfoRec *info );
extern Bool QueryTextExtents ( FontPtr pFont, unsigned long count,          
            unsigned char *chars, ExtentInfoRec *info );
extern Bool ParseGlyphCachingMode ( char *str );
extern void InitGlyphCaching ( void );
extern void SetGlyphCachingMode ( int newmode );
extern int add_range ( fsRange *newrange, int *nranges, fsRange **range,
          Bool charset_subset );

#endif /* _FONTUTIL_H_ */
EOF

#---------------------------------------------------#
# Step 4 - compiling... 
#---------------------------------------------------#

# -- Compiling xrdp package first

echo
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
/bin/echo -e "\e[1;32mXRDP Compilation about to start ! \e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo


cd "${workdir}/xrdp/"

./bootstrap
./configure --enable-fuse --enable-jpeg 
make

#-- check if no error during compilation

if [ $? -eq 0 ]
then 
echo
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
/bin/echo -e "\e[1;32mMake Operation Successful ! \e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo
else 
echo
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
/bin/echo -e "\e[1;31mError while executing make.\e[0m"
/bin/echo -e "\e[1;31mThe script is exiting...\e[0m"
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
echo
exit
fi
make install

# -- Compiling xorgxrdp package first

echo
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
/bin/echo -e "\e[1;32mxorgxrdp Compilation about to start ! \e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo

cd "${workdir}/xorgxrdp/"
./bootstrap 
./configure 
make

# check if no error during compilation 
if [ $? -eq 0 ]
then 
echo
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
/bin/echo -e "\e[1;32mMake Operation Successful ! \e[0m"
/bin/echo -e "\e[1;32m-----------------------------------\e[0m"
echo
else 
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
/bin/echo -e "\e[1;31mError while executing make.\e[0m"
/bin/echo -e "\e[1;31mThe script is exiting...\e[0m"
/bin/echo -e "\e[1;31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\e[0m"
echo
exit
fi
make install

#---------------------------------------------------#
# Step 5 - create policies exceptions .... 
#---------------------------------------------------#

cat >/etc/polkit-1/localauthority.conf.d/02-allow-colord.conf <<EOF
polkit.addRule(function(action, subject) {
if ((action.id == “org.freedesktop.color-manager.create-device” ||
action.id == “org.freedesktop.color-manager.create-profile” ||
action.id == “org.freedesktop.color-manager.delete-device” ||
action.id == “org.freedesktop.color-manager.delete-profile” ||
action.id == “org.freedesktop.color-manager.modify-device” ||
action.id == “org.freedesktop.color-manager.modify-profile”) &&
subject.isInGroup(“{group}”)) {
return polkit.Result.YES;
}
});
EOF

#---------------------------------------------------#
# Step 6 - configure Xwrapper file .... 
#---------------------------------------------------#

sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

#---------------------------------------------------#
# Step 7 - Populate the .xsession file .... 
#---------------------------------------------------#
cat >~/.xsession << EOF
/usr/lib/gnome-session/gnome-session-binary --session=ubuntu &
/usr/lib/x86_64-linux-gnu/unity/unity-panel-service &
/usr/lib/unity-settings-daemon/unity-settings-daemon &
for indicator in /usr/lib/x86_64-linux-gnu/indicator-*; 
do
basename='basename \${indicator}' 
dirname='dirname \${indicator}' 
service=\${dirname}/\${basename}/\${basename}-service 
\${service} &
done
unity
EOF

#---------------------------------------------------#
# Step 8 - create services .... 
#---------------------------------------------------#
systemctl daemon-reload
systemctl enable xrdp.service
systemctl enable xrdp-sesman.service
systemctl start xrdp

#---------------------------------------------------#
# Step 9 - install additional pacakge .... 
#---------------------------------------------------#

apt-get -y install xserver-xorg-core

/bin/echo -e "\e[1;32m----------------------------------------------------------\e[0m"
/bin/echo -e "\e[1;32mInstallation Completed\e[0m"
/bin/echo -e "\e[1;32mPlease test your xRDP configuration....\e[0m"
/bin/echo -e "\e[1;32mCheck c-nergy.be website for latest version of the script\e[0m"
/bin/echo -e "\e[1;32mwritten by Griffon - August 2017 - Version 1.9.1\e[0m"
/bin/echo -e "\e[1;32m----------------------------------------------------------\e[0m"
echo
