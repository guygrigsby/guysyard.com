#!/bin/bash
ffmpeg  \
	-i "rtsp://admin:immvgHm2v!g7v!si@192.168.1.115:554" \
	-preset ultrafast -crf 18 -sc_threshold 0 -g 48 -keyint_min 48 \
	-f hls -hls_time 2 -hls_list_size 2 -hls_playlist_type event \
	-flags +cgop \
	-map 0:v -s:v:0 640x360  -c:v:0 libx264 -x264-params "-tune=zerolatency" -b:v:0 800k  \
		-vf drawtext="fontfile=ttf/Hack-Regular.ttf: fontsize=45: fontcolor=white: x=20: y=h-text_h-20: text='%{localtime}'" \
 	-map 0:v -s:v:1 842x480  -c:v:1 libx264 -x264-params "-tune=zerolatency" -b:v:1 1400k  \
	-map 0:v -s:v:2 1280x720 -c:v:2 libx264 -x264-params "-tune=zerolatency" -b:v:2 2800k  \
	-map 0:v -s:v:3 1920x1080 -c:v:3 libx264 -x264-params "-tune=zerolatency" -b:v:2 6144k \
	-hls_segment_filename stream_%v/%03d.ts \
	-var_stream_map "v:0 v:1 v:2 v:3" -master_pl_name main.m3u8  stream_%v/variant.m3u8
