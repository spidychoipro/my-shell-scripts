#!/bin/bash

read -p "다운로드할 영상의 URL을 입력하세요: " URL

# URL이 YouTube 링크인지 확인
if [[ ! "$URL" =~ ^https?://(www\.)?(youtube\.com|youtu\.be)/ ]]; then
  echo "❌ YouTube 링크만 가능해요!"
  exit 1
fi

read -p "파일의 이름을 입력하세요 (엔터 누르면 원래 제목 사용): " FILENAME

# Videos 디렉토리가 없으면 생성
mkdir -p ~/Videos

# yt-dlp 명령어 구성
if [[ -n "$FILENAME" ]]; then
  # 사용자가 파일명을 입력한 경우
  yt-dlp \
    -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
    --merge-output-format mp4 \
    --embed-thumbnail \
    --embed-metadata \
    --add-metadata \
    -o ~/Videos/"${FILENAME}.%(ext)s" \
    "$URL"
else
  # 원래 제목을 사용하는 경우
  yt-dlp \
    -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
    --merge-output-format mp4 \
    --embed-thumbnail \
    --embed-metadata \
    --add-metadata \
    -o ~/Videos/"%(title)s.%(ext)s" \
    "$URL"
fi

# 다운로드 완료 후 파일 확인
echo "다운로드 완료! 파일 목록:"
ls -la ~/Videos/*.mp4 2>/dev/null | tail -5
