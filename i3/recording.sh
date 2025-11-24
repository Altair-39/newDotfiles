#!/usr/bin/env bash

record() {
  # Toggle on mic (optional if you need to toggle mic too)
  amixer set Capture toggle

  # Get PulseAudio monitor source for system output
  PULSE_SOURCE=$(pactl list short sources | grep 'monitor' | awk '{print $2}')

  # Record screen with system audio from PulseAudio monitor source
  ffmpeg -s "$(xdpyinfo | awk '/dimensions/{print $2}')" -f x11grab -r 30 -i :0.0 \
         -f pulse -i "$PULSE_SOURCE" -c:v h264 -qp 0 -c:a aac -strict -2 "$HOME/Videos/$(date '+%a__%b%d__%H_%M_%S').mp4" &
  
  echo $! > /tmp/recpid

  echo "Rec •" > /tmp/recordingicon && pkill -RTMIN+3 dwmblocks

  notify-send -t 500 -h string:bgcolor:#a3be8c "Recording started & system audio captured"
}

end() {
  kill -15 "$(cat /tmp/recpid)" "$(cat /tmp/audpid)" && rm -f /tmp/recpid /tmp/audpid

  amixer set Capture toggle

  echo "" > /tmp/recordingicon && pkill -RTMIN+3 dwmblocks

  notify-send -t 500 -h string:bgcolor:#bf616a "Recording ended & system audio toggled"
}

# If the recording pid exists, end recording. If not, start recording
([[ -f /tmp/recpid ]] && end && exit 0) || record

