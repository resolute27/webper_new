#!/bin/bash

# 使用說明
if [ -z "$1" ]; then
  echo "用法: $0 /path/to/folder [品質(1-100, 預設80)]"
  exit 1
fi

TARGET_DIR="$1"
QUALITY="${2:-80}"  # 若未指定品質，預設為 80

echo "📂 目錄: $TARGET_DIR"
echo "🎯 轉換品質: $QUALITY"

# 確保 webp 工具有安裝
if ! command -v cwebp &> /dev/null; then
  echo "❌ 找不到 cwebp，請先安裝 (例如: sudo apt install webp)"
  exit 1
fi

# 開始遞迴轉換
find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec bash -c '
  for img; do
    output="${img%.*}.webp"
    echo "🔄 轉換: $img -> $output"
    cwebp -quiet -q '"$QUALITY"' "$img" -o "$output"
  done
' bash {} +

echo "✅ 所有圖片已轉換為 WebP"
