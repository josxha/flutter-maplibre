#!/usr/bin/env bash
# Runs a command and stops it once its output stalls. A stall is reported as
# error annotations, which anyone can read without the job log: the last test
# that started, the stacks of the app process and the tail of the app's log.
#
# Usage: watchdog.sh <stall seconds> <app process> <app log> -- <command...>
set -uo pipefail

stall=$1 process=$2 app_log=$3
shift 4

out=$(mktemp)
"$@" > "$out" 2>&1 &
pid=$!
tail -n +1 -f "$out" &
tail_pid=$!

# Writes stdin as one annotation, escaped as the workflow commands expect.
annotate() {
  local title=$1 body
  body=$(head -c 12000 | sed 's/%/%25/g; s/\r/%0D/g' | awk '{printf "%s%%0A", $0}')
  echo "::error title=$title::$body"
}

while kill -0 "$pid" 2>/dev/null; do
  sleep 10
  idle=$(( $(date +%s) - $(stat -f %m "$out") ))
  (( idle < stall )) && continue

  { grep -E '^[0-9]+:[0-9]+ ' "$out" | tail -n 5; echo; tail -n 15 "$out"; } \
    | annotate "No output for ${idle}s, last tests and output"
  app_pid=$(pgrep -x "$process" | head -n 1)
  if [[ -n $app_pid ]]; then
    sample "$app_pid" 3 -file "$RUNNER_TEMP/sample.txt" > /dev/null 2>&1
    cat "$RUNNER_TEMP/sample.txt"
    # The main thread, where Dart's UI thread runs on iOS, then the frames of
    # MapLibre, Flutter and Metal on any thread.
    awk '/com.apple.main-thread/{on=1} on&&/^    [0-9]+ Thread_/&&!/main-thread/{exit} on' \
      "$RUNNER_TEMP/sample.txt" | cut -c 1-160 | head -n 80 \
      | annotate "Main thread of $process ($app_pid)"
    grep -E 'Thread_|mln_|maplibre|MaplibreNative|MLN|dart::|flutter::|MTL|IOSurface' \
      "$RUNNER_TEMP/sample.txt" | cut -c 1-160 | head -n 120 \
      | annotate "Threads of $process ($app_pid)"
    sed -n '/Sort by top of stack/,/Binary Images/p' "$RUNNER_TEMP/sample.txt" | head -n 40 \
      | annotate "Top of stack of $process"
  else
    echo "No $process process" | annotate "No $process process"
  fi
  grep -iE 'error|fault|crash|metal|maplibre|flutter|assert|terminat' "$app_log" \
    | grep -v SecTrustReportNetworkingAnalytics | tail -n 60 | cut -c 1-200 \
    | annotate "Tail of the app log"

  pkill -P "$pid"
  kill "$pid"
  kill "$tail_pid"
  exit 1
done

wait "$pid"
status=$?
sleep 1
kill "$tail_pid"
exit "$status"
