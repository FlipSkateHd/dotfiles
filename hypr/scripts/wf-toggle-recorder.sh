#!/bin/bash

# Path where the recording will be saved
# RECORDING_PATH="$HOME/Desktop/screen_recording.mp4"
RECORDING_PATH="$HOME/Desktop/recording_$(date +%F_%H-%M-%S).mp4"

# Check if wf-recorder is running
if pgrep -x wf-recorder > /dev/null; then
    # If it's running, stop it cleanly
    pkill -INT wf-recorder
    notify-send "🎥 Screen recording stopped"
else
    # Otherwise, start a new recording
    wf-recorder -f "$RECORDING_PATH" &
    notify-send "🎥 Screen recording started"
fi
