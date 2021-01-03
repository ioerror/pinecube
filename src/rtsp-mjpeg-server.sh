#!/bin/bash

H="720";
W="1280";
F="JPEG_1X8";

media-ctl --set-v4l2 "'ov5640 1-003c':0[fmt:${F}/${W}x${H}]"
gst-rtsp-launch "v4l2src ! image/jpeg,width=${W},height=${H} ! rtpjpegpay name=pay0"
