# FFmpeg

## Combine video and audio

Use the video stream from `video.webm` and the audio stream from `audio.mp4` to create `output.mp4`:

```bash
ffmpeg -i video.webm -i audio.mp4 \
  -map 0:v:0 -map 1:a:0 \
  -vf "scale=1364:738,fps=30" \
  -c:v libx264 -preset fast -crf 23 \
  -c:a aac -b:a 128k \
  -shortest output.mp4
```

`-shortest` stops the output when the shorter input stream ends.

## Make it even faster

For a screen recording, use the `veryfast` preset to speed up encoding:

```bash
ffmpeg -i video.webm -i audio.mp4 \
  -map 0:v:0 -map 1:a:0 \
  -vf "scale=1364:738,fps=30" \
  -c:v libx264 -preset veryfast -crf 23 \
  -c:a aac -b:a 128k \
  -shortest output.mp4
```
