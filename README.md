# pinecube
Useful ways to use the PineCube
https://wiki.pine64.org/index.php?title=PineCube

# Install experimental Ubuntu Groovy 
First load Ubuntu onto the PineCube micro-SD card. Armbian provides [a prebuilt
image](https://minio.k-space.ee/armbian/dl/pinecube/nightly/Armbian_21.02.0-trunk.54_Pinecube_groovy_current_5.10.4_minimal.img.xz)
based on Ubuntu Groovy.

## After install
Git clone this repository recursively as a normal user:
```
git clone --recursive https://www.github.com/ioerror/pinecube
```

Fix-up the current system:
```
cd pinecube && make fixup
```


# Exporting the camera feed
There are many ways to share the camera or the feed from the camera. The
PineCube camera [doesn't appear to support H264
encoding](https://linux-sunxi.org/Cedar_Engine), yet. It is possible to encode
to H264 using approximately ~50% of the CPU. It is also possible to stream JPEG
images from the camera directly to the network without re-encoding.

Ideally, it would be possible to run some set of services on the PineCube which
allow the PineCube to appear as an ONVIF complaint camera on the local network.
This is left as an exercise to the reader at this time.

## Install useful packages for a variety of different camera export strategies
Install many useful packages that are dependencies for various projects.
```
sudo make install-deps
```
