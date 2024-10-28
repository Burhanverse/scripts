@echo off
set /p location="Enter City: "

if "%city%"=="" (
    curl wttr.in
) else (
    curl wttr.in/%city%
)
pause
