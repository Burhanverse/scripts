@echo off
adb shell "settings put system min_refresh_rate 90"
adb shell "settings put system peak_refresh_rate 90"
pause
