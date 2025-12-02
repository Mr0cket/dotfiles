function mp42gif() {
  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Command uses 3 inputs: mp42gif input.mp4 output.gif caption_text"
  else
    ffmpeg -i "$1" -vf "fps=10,scale=480:-1:flags=lanczos,drawtext=text='$3':fontcolor=white:borderw=2:bordercolor=black:fontsize=24:x=(w-text_w)/2:y=(h-text_h)-10" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "$2"
  fi
}

function docker-tags() {
  host=$(python3 -c "from urllib.parse import urlparse as up; print(up('https://$1').netloc)")
  repo=$(python3 -c "from urllib.parse import urlparse as up; print(up('https://$1').path)")
  creds=$(echo $host | docker-credential-osxkeychain get)
  if [[ $? -eq 0 ]]; then
    user=$(echo $creds | jq -r .Username)
    pass=$(echo $creds | jq -r .Secret)
    auth="$user:$pass"
  fi
  echo curl "https://$auth@$host/v2$repo/tags/list"
  curl "https://${auth}@${host}/v2$repo/tags/list" | jq
}
