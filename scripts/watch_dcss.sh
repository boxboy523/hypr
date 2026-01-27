#!/bin/env bash

# expect 설치 확인
if ! command -v expect &> /dev/null; then
    echo "❌ 'expect' 패키지를 설치해주세요: sudo pacman -S expect"
    exit 1
fi

echo "🚀 Nemelex 자동 관전기를 실행합니다..."
echo "👉 종료하려면 Ctrl+C를 누르세요."

# 로직 파일 실행
expect $HOME/.config/hypr/scripts/nemelex.exp
