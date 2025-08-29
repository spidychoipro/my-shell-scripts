#!/bin/bash

read -p "다운로드할 영상의 URL을 입력하세요: " URL

# URL이 YouTube 링크인지 확인
if [[ ! "$URL" =~ ^https?://(www\.)?(youtube\.com|youtu\.be)/ ]]; then
  echo "❌ YouTube 링크만 가능해요!"
  exit 1
fi

read -p "파일의 이름을 입력하세요 (엔터 누르면 원래 제목 사용): " FILENAME

# yt-dlp 명령어 구성
yt-dlp \
  --extract-audio \
  --audio-format mp3 \
  --audio-quality 0 \
  --embed-thumbnail \
  --embed-metadata \
  --add-metadata \
  --metadata-from-title "%(title)s" \
  --parse-metadata "channel:%(artist)s" \
  $( [[ -n "$FILENAME" ]] && echo "-o \"${FILENAME}.%(ext)s\"" ) \
  "$URL"

