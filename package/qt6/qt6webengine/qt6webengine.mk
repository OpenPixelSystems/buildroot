################################################################################
#
# qt6webengine
#
################################################################################

QT6WEBENGINE_VERSION = $(QT6_VERSION)
QT6WEBENGINE_SITE = $(QT6_SITE)
QT6WEBENGINE_SOURCE = qtwebengine-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6WEBENGINE_VERSION).tar.xz
QT6WEBENGINE_INSTALL_STAGING = YES
QT6WEBENGINE_SUPPORTS_IN_SOURCE_BUILD = NO
QT6WEBENGINE_CMAKE_BACKEND = ninja

QT6WEBENGINE_LICENSE = \
	Apache-2.0 \
	BSD-3-Clause \
	GPL-3.0 with Qt-GPL-exception-1.0 \
	LGPL-3.0 or GPL-2.0 or GPL-3.0 \
	MIT

QT6WEBENGINE_LICENSE_FILES = \
	LICENSES/Apache-2.0.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/CC0-1.0.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-2.0-or-later.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/LicenseRef-Tango-Icons-Public-Domain.txt \
	LICENSES/MIT.txt \
	LICENSES/Qt-GPL-exception-1.0.txt

QT6WEBENGINE_CONF_OPTS = \
	-DBUILD_WITH_PCH=OFF \
	-DFEATURE_qtwebengine_build=ON \
	-DFEATURE_qtpdf_build=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DQT_SHOW_EXTRA_IDE_SOURCES=OFF

# Host tools

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n37
QT6WEBENGINE_DEPENDENCIES = host-ninja

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n48
QT6WEBENGINE_DEPENDENCIES += host-nodejs

#https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n38
QT6WEBENGINE_DEPENDENCIES += host-qt6webengine # gn host tool

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n347
QT6WEBENGINE_DEPENDENCIES += host-python-html5lib

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n352
QT6WEBENGINE_DEPENDENCIES += host-gperf

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n358
QT6WEBENGINE_DEPENDENCIES += host-bison

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n364
QT6WEBENGINE_DEPENDENCIES += host-flex

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n370
QT6WEBENGINE_DEPENDENCIES += host-pkgconf

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n279
QT6WEBENGINE_DEPENDENCIES += \
	host-qt6declarative \
	qt6base \
	qt6declarative

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n414
QT6WEBENGINE_DEPENDENCIES += \
	host-libnss \
	libnss

QT6WEBENGINE_DEPENDENCIES += host-fontconfig

## Core

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n55
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_embedded_build=ON

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n61
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_alsa=ON
QT6WEBENGINE_DEPENDENCIES += alsa-lib
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_alsa=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n72
ifeq ($(BR2_PACKAGE_QT6POSITIONING),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_geolocation=ON
QT6WEBENGINE_DEPENDENCIES += qt6positioning
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_geolocation=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n76
ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_pulseaudio=ON
QT6WEBENGINE_DEPENDENCIES += pulseaudio
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_pulseaudio=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n81
ifeq ($(BR2_PACKAGE_HAS_LIBGBM),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_gbm=ON
QT6WEBENGINE_DEPENDENCIES += libgbm
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_gbm=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n87
ifeq ($(BR2_PACKAGE_QT6BASE_PRINTSUPPORT),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_printing_and_pdf=ON
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_printing_and_pdf=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n93
ifeq ($(BR2_PACKAGE_QT6BASE_PRINTSUPPORT),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_pepper_plugins=ON
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_pepper_plugins=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n98
ifeq ($(BR2_PACKAGE_QT6WEBCHANNEL),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webchannel=ON
QT6WEBENGINE_DEPENDENCIES += qt6webchannel
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webchannel=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n104
ifeq ($(BR2_PACKAGE_QT6WEBENGINE_PROPRIETARY_CODECS),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_proprietary_codecs=ON
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_proprietary_codecs=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n117
ifeq ($(BR2_PACKAGE_QT6WEBENGINE_SPELLCHECKER),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_spellchecker=ON
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_spellchecker=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n134
ifeq ($(BR2_PACKAGE_QT6WEBENGINE_WEBRTC),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webrtc=ON
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n140
ifeq ($(BR2_PACKAGE_GLIB2),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webrtc_pipewire=ON
QT6WEBENGINE_DEPENDENCIES += libglib2 # gio
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webrtc_pipewire=OFF
endif
ifeq ($(BR2_PACKAGE_QT6WEBENGINE_HAS_X11_SUPPORT),y)
QT6WEBENGINE_DEPENDENCIES += xlib_libXdamage
endif
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_webrtc=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n161
ifeq ($(BR2_PACKAGE_QT6BASE_VULKAN),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_vulkan=ON
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_vulkan=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/core/api/configure.cmake?h=6.9.1#n168
ifeq ($(BR2_PACKAGE_LIBVPX),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_vaapi=OFF
else ifeq ($(BR2_PACKAGE_HAS_LIBGBM)$(BR2_PACKAGE_LIBVA),yy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_vaapi=ON
QT6WEBENGINE_DEPENDENCIES += libgbm libva
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_vaapi=OFF
endif

## Optional system libraries

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n598
ifeq ($(BR2_PACKAGE_RE2),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_re2=ON
QT6WEBENGINE_DEPENDENCIES += re2
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_re2=OFF
endif

# DEBUG THIS:
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n603
#ifeq ($(BR2_PACKAGE_ICU),y)
#QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_icu=ON
#QT6WEBENGINE_DEPENDENCIES += icu
#else
#QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_icu=OFF
#endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n608
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n79
ifeq ($(BR2_PACKAGE_WEBP)$(BR2_PACKAGE_WEBP_MUX)$(BR2_PACKAGE_WEBP_DEMUX),yyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libwebp=ON
QT6WEBENGINE_DEPENDENCIES += host-webp webp
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libwebp=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n612
ifeq ($(BR2_PACKAGE_OPENJPEG),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libopenjpeg2=ON
QT6WEBENGINE_DEPENDENCIES += openjpeg
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libopenjpeg2=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n616
ifeq ($(BR2_PACKAGE_OPUS),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_opus=ON
QT6WEBENGINE_DEPENDENCIES += opus
# host perl is needed for optimization of opus:
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n810
QT6WEBENGINE_DEPENDENCIES += host-perl
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_opus=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n620
ifeq ($(BR2_PACKAGE_FFMPEG)$(BR2_PACKAGE_OPUS)$(BR2_PACKAGE_WEBP)$(BR2_PACKAGE_WEBP_MUX)$(BR2_PACKAGE_WEBP_DEMUX),yyyyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_ffmpeg=ON
QT6WEBENGINE_DEPENDENCIES += ffmpeg
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_ffmpeg=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n625
ifeq ($(BR2_PACKAGE_LIBVPX),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libvpx=ON
QT6WEBENGINE_DEPENDENCIES += libvpx
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libvpx=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n630
ifeq ($(BR2_PACKAGE_SNAPPY),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_snappy=ON
QT6WEBENGINE_DEPENDENCIES += snappy
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_snappy=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n634
ifeq ($(BR2_PACKAGE_GLIB2),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_glib=ON
QT6WEBENGINE_DEPENDENCIES += libglib2
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_glib=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n638
ifeq ($(BR2_PACKAGE_HAS_ZLIB),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_zlib=ON
QT6WEBENGINE_DEPENDENCIES += zlib
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_zlib=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n648
ifeq ($(BR2_PACKAGE_MINIZIP),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_minizip=ON
QT6WEBENGINE_DEPENDENCIES += minizip
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_minizip=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n652
ifeq ($(BR2_PACKAGE_LIBEVENT),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libevent=ON
QT6WEBENGINE_DEPENDENCIES += libevent
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libevent=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n656
ifeq ($(BR2_PACKAGE_LIBXML2)$(BR2_PACKAGE_LIBXSLT),yy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libxml=ON
QT6WEBENGINE_DEPENDENCIES += libxml2 libxslt
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libxml=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n660
ifeq ($(BR2_PACKAGE_LCMS2),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_lcms2=ON
QT6WEBENGINE_DEPENDENCIES += lcms2
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_lcms2=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n664
ifeq ($(BR2_PACKAGE_LIBPNG)$(BR2_PACKAGE_QT6BASE_GUI)$(BR2_PACKAGE_QT6BASE_PNG),yyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libpng=ON
QT6WEBENGINE_DEPENDENCIES += libpng
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libpng=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n668
ifeq ($(BR2_PACKAGE_TIFF)$(BR2_PACKAGE_QT6BASE_GUI),yy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libtiff=ON
QT6WEBENGINE_DEPENDENCIES += tiff
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libtiff=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n679
ifeq ($(BR2_PACKAGE_HAS_JPEG)$(BR2_PACKAGE_QT6BASE_GUI)$(BR2_PACKAGE_QT6BASE_JPEG),yyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libjpeg=ON
QT6WEBENGINE_DEPENDENCIES += jpeg
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libjpeg=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n690
ifeq ($(BR2_PACKAGE_HARFBUZZ)$(BR2_PACKAGE_QT6BASE_GUI)$(BR2_PACKAGE_QT6BASE_HARFBUZZ),yyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_harfbuzz=ON
QT6WEBENGINE_DEPENDENCIES += harfbuzz
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_harfbuzz=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n701
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_PACKAGE_QT6BASE_GUI),yyy)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_freetype=ON
QT6WEBENGINE_DEPENDENCIES += freetype
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_freetype=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n712
ifeq ($(BR2_PACKAGE_PCIUTILS),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libpci=ON
QT6WEBENGINE_DEPENDENCIES += pciutils # libpci
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libpci=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n717
ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libudev=ON
QT6WEBENGINE_DEPENDENCIES += udev
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_system_libudev=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n722
ifeq ($(BR2_PACKAGE_QT6BASE_XCB),y)
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_ozone_x11=ON
# https://doc.qt.io/qt-6/qtwebengine-platform-notes.html#linux
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/configure.cmake?h=6.9.1#n439
QT6WEBENGINE_DEPENDENCIES += \
	libdrm \
	libxcb \
	libxkbcommon \
	xlib_libX11 \
	xlib_libXcomposite \
	xlib_libXcursor \
	xlib_libXi \
	xlib_libxkbfile \
	xlib_libXrandr \
	xlib_libxshmfence \
	xlib_libXtst \
	xorgproto
else
QT6WEBENGINE_CONF_OPTS += -DFEATURE_webengine_ozone_x11=OFF
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/CMakeLists.txt?h=6.9.1#n35
ifeq ($(BR2_PACKAGE_QT6SVG),y)
QT6WEBENGINE_DEPENDENCIES += qt6svg
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/CMakeLists.txt?h=6.9.1#n35
ifeq ($(BR2_PACKAGE_QT6TOOLS),y)
QT6WEBENGINE_DEPENDENCIES += qt6tools
endif

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/CMakeLists.txt?h=6.9.1#n35
ifeq ($(BR2_PACKAGE_QT6WEBSOCKETS),y)
QT6WEBENGINE_DEPENDENCIES += qt6websockets
endif

# Host tool 'gn' is required:
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/CMakeLists.txt?h=6.9.1#n120
# https://code.qt.io/cgit/qt/qtwebengine.git/tree/CMakeLists.txt?h=6.9.1#n22
HOST_QT6WEBENGINE_CONF_OPTS = \
	-DBUILD_ONLY_GN=ON \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_SHOW_EXTRA_IDE_SOURCES=OFF

# https://code.qt.io/cgit/qt/qtwebengine.git/tree/src/gn/CMakeLists.txt?h=6.9.1#n29
HOST_QT6WEBENGINE_DEPENDENCIES = \
	host-python3 \
	host-ninja

$(eval $(cmake-package))
$(eval $(host-cmake-package))
