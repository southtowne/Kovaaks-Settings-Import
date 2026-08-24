@echo off
cls
chcp 65001 >nul 2>&1

fltmc >nul 2>&1
if not %errorlevel% == 0 (
    powershell -Command "Write-Host 'This script must be run as Administrator.' -ForegroundColor White -BackgroundColor Red"
    timeout /t 3 >nul
    PowerShell Start -Verb RunAs '%0'
    exit /b 0
)

:menu
cls
echo.
echo                                 ╔══════════════════════════════════════════════╗
echo                                 ║         KovaaK's Engine.ini Import           ║
echo                                 ╠══════════════════════════════════════════════╣
echo                                 ║   [1] Better Visual Clarity                  ║
echo                                 ║   [2] Better Performance                     ║
echo                                 ║   [3] Input Latency Only                     ║
echo                                 ║   [4] Import Assets                          ║
echo                                 ║                                              ║
echo                                 ║   [0] Exit                                   ║
echo                                 ╚══════════════════════════════════════════════╝
echo.
set /p choice=SELECT OPTION: 
if "%choice%"=="1" goto Visual
if "%choice%"=="2" goto Performance
if "%choice%"=="3" goto Input
if "%choice%"=="4" goto Assets
if "%choice%"=="0" exit
goto menu

:Visual
cls
echo.
echo  Downloading Visual Clarity Engine.ini...
echo.
curl.exe -L "https://www.dropbox.com/scl/fi/lun6216na7doytptfll1x/UPDEngineQUALITY.ini?rlkey=xqo0a5dvkuvuad9txrhbjx10n&st=dr4udzos&dl=0" -o "%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Engine.ini"
if %ERRORLEVEL% neq 0 (
    echo  X  Failed to download Visual Clarity Engine.ini.
    echo.
    timeout /t 2 >nul
    goto menu
) else (
    echo  OK  Visual Clarity Engine.ini imported successfully.
    echo.    
    timeout /t 2 >nul
    exit
)

:Performance
cls
echo.
echo  Downloading Performance Engine.ini...
echo.
curl.exe -L "https://www.dropbox.com/scl/fi/yzjefu6ozwvj4icrbghvy/UPDEngine.ini?rlkey=9uxs6obvy91796htywo86few6&st=osjhw1qj&dl=0" -o "%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Engine.ini"
if %ERRORLEVEL% neq 0 (
    echo  X  Failed to download Performance Engine.ini.
    echo.
    timeout /t 2 >nul
    goto menu
) else (
    echo  OK  Performance Engine.ini imported successfully.
    echo.
    timeout /t 2 >nul
    exit
)

:Input
cls
echo.
echo  Downloading Input Latency Engine.ini...
echo.
curl.exe -L "https://www.dropbox.com/scl/fi/iq5dxeitki8hr7hsoyj0e/Engine.ini?rlkey=78e386hlzlaydzlzsrqq8u87k&st=s95vf1zo&dl=0" -o "%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Engine.ini"
if %ERRORLEVEL% neq 0 (
    echo  X  Failed to download Input Latency Engine.ini.
    echo.
    timeout /t 2 >nul
    goto menu
) else (
    echo  OK  Input Latency Engine.ini imported successfully.
    echo.    
    timeout /t 2 >nul
    exit
)

:Assets
cls
echo.
echo  Downloading and importing KovaaK's assets...
echo.

echo  Downloading Crosshairs...

set "CROSSHAIR_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\crosshairs"
set "CROSSHAIR_ZIP=%TEMP%\Kovaaks_Crosshairs.zip"

if not exist "%CROSSHAIR_DIR%" mkdir "%CROSSHAIR_DIR%"

curl.exe -L "https://www.dropbox.com/scl/fo/1mhxjfdehpljpddusufym/AJIcsDMxXljfPzpZt_8We4c?rlkey=uaw20b7ultj7nrf62mqsi9w4k&dl=1" -o "%CROSSHAIR_ZIP%"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to download Crosshairs.
    echo.
    del /q "%CROSSHAIR_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

powershell.exe -NoProfile -Command "Expand-Archive -Path '%CROSSHAIR_ZIP%' -DestinationPath '%CROSSHAIR_DIR%' -Force"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to extract Crosshairs.
    echo.
    del /q "%CROSSHAIR_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

del /q "%CROSSHAIR_ZIP%" >nul 2>&1

echo  OK  Crosshairs imported successfully.
echo.

echo  Downloading Sounds...

set "SOUND_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\sounds"
set "SOUND_ZIP=%TEMP%\Kovaaks_Sounds.zip"

if not exist "%SOUND_DIR%" mkdir "%SOUND_DIR%"

curl.exe -L "https://www.dropbox.com/scl/fo/7j71fxtq9iui5o9m1v2a8/ADAA0G4sGURGEf1IZERwAIY?rlkey=22dmh8igp8iforbwloqeo6942&st=xlzx04ie&dl=1" -o "%SOUND_ZIP%"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to download Sounds.
    echo.
    del /q "%SOUND_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

powershell.exe -NoProfile -Command "Expand-Archive -Path '%SOUND_ZIP%' -DestinationPath '%SOUND_DIR%' -Force"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to extract Sounds.
    echo.
    del /q "%SOUND_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

del /q "%SOUND_ZIP%" >nul 2>&1

echo  OK  Sounds imported successfully.
echo.



echo  Downloading Themes...

set "THEME_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\Saved\SaveGames\Themes"
set "THEME_ZIP=%TEMP%\Kovaaks_Themes.zip"

if not exist "%THEME_DIR%" mkdir "%THEME_DIR%"

curl.exe -L "https://www.dropbox.com/scl/fo/wg30jv8yy4d6bhql4rm0m/AFiZNzQ60vQkaO8MVUAZniE?rlkey=75wp8viimma8lmyptdhqir81t&st=1tfy3qnn&dl=1" -o "%THEME_ZIP%"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to download Themes.
    echo.
    del /q "%THEME_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

powershell.exe -NoProfile -Command "Expand-Archive -Path '%THEME_ZIP%' -DestinationPath '%THEME_DIR%' -Force"

if %ERRORLEVEL% neq 0 (
    echo.
    echo  X  Failed to extract Themes.
    echo.
    del /q "%THEME_ZIP%" >nul 2>&1
    timeout /t 2 >nul
    goto menu
)

del /q "%THEME_ZIP%" >nul 2>&1

echo  OK  Themes imported successfully.
echo.

echo
echo  All KovaaK's assets imported!
echo
echo.

timeout /t 2 >nul
exit
