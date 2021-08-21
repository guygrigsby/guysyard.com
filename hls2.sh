#!/bin/bash
ffmpeg  \
	-i "rtsp://admin:immvgHm2v!g7v!si@192.168.1.115:554" \
	-preset ultrafast -sc_threshold 0 -g 48 -keyint_min 48 \
	-f hls -hls_time 4 -hls_list_size 4 -hls_playlist_type event \
	-map 0:v -s:v:0 640x360  -c:v:0 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 800k -hls_segment_filename stream_%v/%03d.ts \
 	-map 0:v -s:v:1 842x480  -c:v:1 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:1 1400k  -hls_segment_filename stream_%v/%03d.ts  \
	-map 0:v -s:v:2 1280x720 -c:v:2 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:2 2800k  -hls_segment_filename stream_%v/%03d.ts  \
	-map 0:v -c:v:3 copy -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:3 4096k  -hls_segment_filename stream_%v/%03d.ts  \
	-var_stream_map "v:0 v:1 v:2 v:3" -master_pl_name main.m3u8  stream_%v.m3u8
	
