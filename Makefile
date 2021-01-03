default:
	echo "Read the Makefile for a list of possible targets";

.PHONY: fixup
fixup:
	./src/pinecube-fixup.sh;

.PHONY: install-deps
install-deps:
	sudo apt update;
	- sudo apt install -y armbian-config;
	sudo apt install -y wireguard-tools vim \
		gstreamer1.0-plugins-bad gstreamer1.0-tools gstreamer1.0-plugins-good \
		v4l-utils gstreamer1.0-alsa alsa-utils libpango1.0-0 libpango1.0-dev \
		gstreamer1.0-plugins-base gstreamer1.0-x x264 \
		gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly liblivemedia-dev \
		liblog4cpp5-dev liblivemedia-dev liblog4cpp5-dev \
		libasound2-dev vlc libssl-dev iotop libasound2-dev  liblog4cpp5-dev \
		liblivemedia-dev autoconf automake libtool v4l2loopback-dkms \
		liblog4cpp5-dev libvpx-dev libx264-dev libjpeg-dev libx265-dev \
		gsoap libgsoap-dev  ninja-build debhelper libgstrtspserver-1.0-0 \
		libglib2.0-0 libgstreamer1.0-0;

.PHONY: build-debs
build-debs: install-deps
	cd submodules/gst-rtsp-launch && dpkg-buildpackage;

.PHONY: install
install: build-debs
	dpkg -i ../gst-rtsp-launch_*_armhf.deb;
	install 755 src/pinecube-fixup.sh $(DESTDIR)/bin/;
	install 755 src/wireguard-setup.sh $(DESTDIR)/bin/;
	install 755 src/rtsp-mjpeg-server.sh $(DESTDIR)/bin/;
