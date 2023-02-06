@ECHO OFF

SETLOCAL EnableDelayedExpansion

FOR /f "delims=" %%F IN ('dir /b /s "src\%1.rs" 2^>NUL') DO SET filepath=%%F

CALL .\run.bat "%filepath%"

ENDLOCAL