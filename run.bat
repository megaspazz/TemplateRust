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

ECHO.
IF DEFINED filepath (
    ECHO === Compiling:  %filepath%
    %COMPILE% 2> %ERROR%
    IF ERRORLEVEL 1 (
        ECHO.
        TYPE "%ERROR%"
        ECHO === Compilation failed.  See "%ERROR%" for details.
    ) ELSE (
        FOR %%A IN (%ERROR%) DO IF NOT %%~zA == 0 SET hasCompilationErrorOutput=1
        ECHO.
        IF NOT [!hasCompilationErrorOutput!] == [] (
            TYPE "%ERROR%"
            ECHO === Compilation succeeded with warnings.
        ) ELSE (
            ECHO === Compilation successful.
        )
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
        )
    )
) ELSE (
    ECHO === ERROR: File not found!
)
ECHO.

ENDLOCAL