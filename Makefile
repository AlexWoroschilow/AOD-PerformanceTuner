SHELL := /usr/bin/bash
APPDIR := ./AppDir
GLIBC_VERSION := $(shell getconf GNU_LIBC_VERSION | sed 's/ /-/g' )
ICONS := $(shell ls src/icons | grep svg)
PWD := $(shell pwd)
.PHONY: all

all: appimage clean

init:
	rm -rf $(PWD)/venv
	python3 -m venv --copies $(PWD)/venv
	source $(PWD)/venv/bin/activate && python3 -m pip install --upgrade pip && python3 -m pip install -r $(PWD)/requirements.txt


appimage: clean

	rm -rf $(PWD)/build
	mkdir -p $(PWD)/build
	mkdir -p $(PWD)/build/AppDir
	mkdir -p $(PWD)/build/AppDir/application
	mkdir -p $(PWD)/build/AppDir/python
	mkdir -p $(PWD)/build/AppDir/vendor


	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/python38-3.8.0-6.module_el8.2.0+317+61fa6e7d.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/python38-devel-3.8.0-6.module_el8.2.0+317+61fa6e7d.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/aarch64/os/Packages/python38-pip-19.2.3-5.module_el8.2.0+317+61fa6e7d.noarch.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/python38-setuptools-41.6.0-4.module_el8.2.0+317+61fa6e7d.noarch.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/python38-libs-3.8.0-6.module_el8.2.0+317+61fa6e7d.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget  --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/7/os/x86_64/Packages/libffi-3.0.13-19.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget  --output-document=$(PWD)/build/build.rpm  https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/l/libicu-65.1-2.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget  --output-document=$(PWD)/build/build.rpm  https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/q/qt5-qtbase-5.14.2-5.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/q/qt5-qtbase-gui-5.14.2-5.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/q/qt5-qtx11extras-5.14.2-1.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/p/python3-qt5-5.14.2-3.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/p/python3-qt5-base-5.14.2-3.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/p/python3-pyqt5-sip-4.19.21-1.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/q/qt5-qtsvg-5.14.2-1.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/aarch64/Packages/q/qt5-qtwayland-5.14.2-4.fc32.aarch64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/z/zlib-1.2.11-21.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/p/pcre2-utf16-10.34-9.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/l/libxcb-1.13.1-4.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/l/leptonica-1.79.0-2.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..


	cp -r --force $(PWD)/AppDir/* $(PWD)/build/AppDir/
	cp -r --force $(PWD)/build/usr/* $(PWD)/build/AppDir/python/
	cp -r --force $(PWD)/build/usr/lib64/qt5/plugins/platforms $(PWD)/build/AppDir/python/bin/
	cp -r --force $(PWD)/src/icons $(PWD)/build/AppDir/application/
	cp -r --force $(PWD)/src/modules $(PWD)/build/AppDir/application/
	cp -r --force $(PWD)/src/plugins $(PWD)/build/AppDir/application/
	cp -r --force $(PWD)/src/themes $(PWD)/build/AppDir/application/
	cp -r --force $(PWD)/src/main.py $(PWD)/build/AppDir/application/

	mkdir -p $(PWD)/build/AppDir/vendor
	$(PWD)/build/AppDir/AppRun --python -m pip install  -r $(PWD)/requirements.txt --target=$(PWD)/build/AppDir/vendor --upgrade
	$(PWD)/build/AppDir/AppRun --python -m pip uninstall typing -y

	export ARCH=x86_64 && $(PWD)/bin/appimagetool-x86_64.AppImage  $(PWD)/build/AppDir $(PWD)/PerformanceTuner.AppImage
	make clean


icons: $(ICONS)
clean: $(shell rm -rf $(PWD)/build)


$(ICONS):
	rm -f src/icons/`echo $@ | sed -e 's/svg/png/'`
	inkscape src/icons/$@ --export-dpi=96 --export-filename=src/icons/`echo $@ | sed -e 's/svg/png/'`


