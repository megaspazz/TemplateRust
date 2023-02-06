@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET fullpath=%~1

SET INPUT=io\in.txt
SET OUTPUT=io\out.txt
SET ERROR=io\err.txt

CALL SET filepath=%%fullpath:%~dp0=%%

SET COMPILE=rustc "%filepath%" -o "bin\%filename%.exe"

IF NOT EXIST "bin\" (
    MKDIR "bin"
)

IF DEFINED filepath (
    ECHO === Compiling:  %filepath%
    %COMPILE% 2> %ERROR%
    IF ERRORLEVEL 1 (
        ECHO === Compilation failed.  See "%ERROR%" for details.
        ECHO.
        TYPE "%ERROR%"
        ECHO.
    ) ELSE (
        ECHO === Compilation successful.
        ECHO.
        "bin\%filename%.exe" < %INPUT% > %OUTPUT% 2> %ERROR% ^
            && SET success=true ^
            || SET success=
        TYPE "%OUTPUT%"
        ECHO.
        if DEFINED success (
            ECHO === Execution successful.
        ) ELSE (
            ECHO === The program crashed. See "%ERROR%" for details.
            ECHO.
            TYPE "%ERROR%"
            ECHO.
        )
    )
) ELSE (
    ECHO === ERROR: File not found!
)

ENDLOCAL