

@REM dir *.rs /A-D /B /OD


@ECHO OFF

SETLOCAL EnableDelayedExpansion

FOR /f "usebackq delims=" %%a IN (`
  POWERSHELL -NoP -C "(Get-ChildItem -Path '%srcDir%' -Filter '*.rs' -File -Recurse | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName"
`) DO SET "filepath=%%a"

@REM If defined lastmod (
@REM    echo lastmod = %lastmod%
@REM ) else (
@REM    Echo couldn't obtain lastmod file
@REM )

@REM CALL DIR "*.rs" /S /B /A:-D /O:D /T:W

@REM CALL SORT c a b

@REM cd /d "C:\Users\Eric Pan\Desktop\Competitive Programming\Rust\VSCode"
@REM for /F "delims=" %%G IN ('powershell "gci -rec *.ext | where { ! $_.PSIsContainer } | sort LastWriteTime | select -last 1 | Select-Object fullname"') do set NewestFile=%%G

@REM echo newest file: %NewestFile%

@REM set "root=C:\Users\Eric Pan\Desktop\Competitive Programming\Rust\VSCode"
@REM set "mask=*.rs"

@REM for %%r in ("%root%\.") do for /f "tokens=2,*" %%a in ('
@REM     robocopy "%%~fr" "%%~fr" "%mask%" /njh /njs /nc /ns /ts /s /ndl /nocopy /is /r:0 /w:0 /l
@REM     ^| sort /r 
@REM     ^| cmd /v /e /c"(set /p .=&echo(!.!)"
@REM ') do set "lastFile=%%b"

@REM echo Last file : "%lastFile%"

@REM FOR /F "delims=" %%F IN ('DIR "*.rs" /S /B /A:-D /O:D /T:W') DO SET filepath=%%F

CALL .\run.bat "%filepath%"

ENDLOCAL