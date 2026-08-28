#!/bin/bash
osascript >/dev/null 2>&1 <<'AS'
tell application "Google Chrome"
  set w to (first window whose id is 1246166768)
  set i to 0
  repeat with t in tabs of w
    set i to i + 1
    if (URL of t) contains "ariuno.com.br" then
      set active tab index of w to i
      exit repeat
    end if
  end repeat
  set index of w to 1
  activate
end tell
AS
sleep 1.4
