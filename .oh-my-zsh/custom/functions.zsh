function mp42gif() {
  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Command uses 3 inputs: mp42gif input.mp4 output.gif caption_text"
  else
    ffmpeg -i "$1" -vf "fps=10,scale=480:-1:flags=lanczos,drawtext=text='$3':fontcolor=white:borderw=2:bordercolor=black:fontsize=24:x=(w-text_w)/2:y=(h-text_h)-10" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "$2"
  fi
}
