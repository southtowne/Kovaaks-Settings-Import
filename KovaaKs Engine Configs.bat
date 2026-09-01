@echo off
cls
chcp 65001 >nul 2>&1

fltmc >nul 2>&1
if not %errorlevel% == 0 (
    chcp 437 >nul
    powershell -Command "Write-Host 'This script must be run as Administrator.' -ForegroundColor White -BackgroundColor Red"
    chcp 65001 >nul
    timeout /t 3 >nul
    PowerShell Start -Verb RunAs '%0'
    exit /b 0
)

set "STAGE=%TEMP%\KovaaksImportStage"
set "STAGE_ROOT=%STAGE%\Kovaaks-Settings-Import-c8e2926d104b220f7fdd1d0e06a7584bd709b293"

if exist "%STAGE%" rd /s /q "%STAGE%" >nul 2>&1
mkdir "%STAGE%" >nul 2>&1

echo.
echo  Downloading configs...
curl.exe -L "https://github.com/southtowne/Kovaaks-Settings-Import/archive/c8e2926d104b220f7fdd1d0e06a7584bd709b293.zip" -o "%STAGE%\repo.zip"
chcp 437 >nul
powershell.exe -NoProfile -Command "Expand-Archive -Path '%STAGE%\repo.zip' -DestinationPath '%STAGE%' -Force"
chcp 65001 >nul
del /q "%STAGE%\repo.zip" >nul 2>&1
echo  OK  Ready.
timeout /t 1 >nul

set "ENGINE_DEST=%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Engine.ini"
set "CROSSHAIR_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\crosshairs"
set "SOUND_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\sounds"
set "THEME_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\Saved\SaveGames\Themes"

:menu
cls
echo.
echo                                 ╔══════════════════════════════════════════════╗
echo                                 ║         KovaaK's Engine.ini Import           ║
echo                                 ╠══════════════════════════════════════════════╣
echo                                 ║   [1] Performance Focused Engine.ini         ║
echo                                 ║   [2] Visual Quality Focused Engine.ini      ║
echo                                 ║   [3] Input-Related Changes Only             ║
echo                                 ║   [4] Assets                                 ║
echo                                 ║                                              ║
echo                                 ║   [0] Exit ^& Cleanup                         ║
echo                                 ╚══════════════════════════════════════════════╝
echo.
set /p choice=SELECT OPTION: 
if "%choice%"=="1" goto Performance
if "%choice%"=="2" goto Visual
if "%choice%"=="3" goto Input
if "%choice%"=="4" goto Assets
if "%choice%"=="0" goto Cleanup
goto menu

:Performance
copy /y "%STAGE_ROOT%\Engine\Performance\Engine.ini" "%ENGINE_DEST%" >nul
echo  OK  Performance Engine.ini imported.
goto ReturnPrompt

:Visual
copy /y "%STAGE_ROOT%\Engine\Quality\Engine.ini" "%ENGINE_DEST%" >nul
echo  OK  Visual Engine.ini imported.
goto ReturnPrompt

:Input
copy /y "%STAGE_ROOT%\Engine\Input-Related\Engine.ini" "%ENGINE_DEST%" >nul
echo  OK  Input Engine.ini imported.
goto ReturnPrompt

:Assets
if not exist "%CROSSHAIR_DIR%" mkdir "%CROSSHAIR_DIR%"
if not exist "%SOUND_DIR%" mkdir "%SOUND_DIR%"
if not exist "%THEME_DIR%" mkdir "%THEME_DIR%"
xcopy "%STAGE_ROOT%\Assets\crosshairs\*" "%CROSSHAIR_DIR%\" /e /i /y >nul
xcopy "%STAGE_ROOT%\Assets\sounds\*" "%SOUND_DIR%\" /e /i /y >nul
xcopy "%STAGE_ROOT%\Assets\Themes\*" "%THEME_DIR%\" /e /i /y >nul
echo  OK  Assets imported.
goto ReturnPrompt

:ReturnPrompt
echo.
pause
goto menu

:Cleanup
if exist "%STAGE%" rd /s /q "%STAGE%" >nul 2>&1
echo  OK  Cleanup complete.
timeout /t 2 >nul
exit
