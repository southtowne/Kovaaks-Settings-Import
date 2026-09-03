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
set "STAGE_ROOT=%STAGE%\Kovaaks-Settings-Import-942d3a77a112db9766f364fa0b234a62a9e1d07b"

if exist "%STAGE%" rd /s /q "%STAGE%" >nul 2>&1
mkdir "%STAGE%" >nul 2>&1

echo.
echo  Downloading configs...
curl.exe -L "https://github.com/southtowne/Kovaaks-Settings-Import/archive/942d3a77a112db9766f364fa0b234a62a9e1d07b.zip" -o "%STAGE%\repo.zip"
chcp 437 >nul
powershell.exe -NoProfile -Command "Expand-Archive -Path '%STAGE%\repo.zip' -DestinationPath '%STAGE%' -Force"
chcp 65001 >nul
del /q "%STAGE%\repo.zip" >nul 2>&1
echo  OK  Ready.
timeout /t 1 >nul

set "ENGINE_DEST=%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Engine.ini"
set "PALETTE_DEST=%LOCALAPPDATA%\FPSAimTrainer\Saved\Config\WindowsNoEditor\Palette.ini"
set "CROSSHAIR_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\crosshairs"
set "SOUND_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\sounds"
set "THEME_DIR=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer\Saved\SaveGames\Themes"

:menu
cls
echo.
echo                                 ╔══════════════════════════════════════════════╗
echo                                 ║         KovaaK's Settings Import             ║
echo                                 ╠══════════════════════════════════════════════╣
echo                                 ║   [1] Performance Focused Engine.ini         ║
echo                                 ║   [2] Visual Quality Focused Engine.ini      ║
echo                                 ║   [3] Input-Related Changes Only             ║
echo                                 ║   [4] Palette Import                         ║
echo                                 ║   [5] Assets                                 ║
echo                                 ║                                              ║
echo                                 ║   [0] Exit ^& Cleanup                         ║
echo                                 ╚══════════════════════════════════════════════╝
echo.
set /p choice=SELECT OPTION: 
if "%choice%"=="1" goto Performance
if "%choice%"=="2" goto Visual
if "%choice%"=="3" goto Input
if "%choice%"=="4" goto PaletteMenu
if "%choice%"=="5" goto Assets
if "%choice%"=="0" goto Cleanup
goto menu

:Performance
attrib -r "%ENGINE_DEST%" >nul 2>&1
copy /y "%STAGE_ROOT%\Engine\Performance\Engine.ini" "%ENGINE_DEST%" >nul
attrib +r "%ENGINE_DEST%"
echo  OK  Performance Engine.ini imported and set to read-only.
goto ReturnPrompt

:Visual
attrib -r "%ENGINE_DEST%" >nul 2>&1
copy /y "%STAGE_ROOT%\Engine\Quality\Engine.ini" "%ENGINE_DEST%" >nul
attrib +r "%ENGINE_DEST%"
echo  OK  Visual Engine.ini imported and set to read-only.
goto ReturnPrompt

:Input
attrib -r "%ENGINE_DEST%" >nul 2>&1
copy /y "%STAGE_ROOT%\Engine\Input-Related\Engine.ini" "%ENGINE_DEST%" >nul
attrib +r "%ENGINE_DEST%"
echo  OK  Input Engine.ini imported and set to read-only.
goto ReturnPrompt

:PaletteMenu
cls
echo.
echo                                 ╔══════════════════════════════════════════════╗
echo                                 ║              Palette.ini Import              ║
echo                                 ╠══════════════════════════════════════════════╣
echo                                 ║   [1] MattyOW's Palette                      ║
echo                                 ║   [2] Plague's Palette                       ║
echo                                 ║   [3] Sencky's Palette                       ║
echo                                 ║                                              ║
echo                                 ║   [0] Back                                   ║
echo                                 ╚══════════════════════════════════════════════╝
echo.
set /p pchoice=SELECT PALETTE: 
if "%pchoice%"=="1" set "PNAME=MattyOW" & goto ImportPalette
if "%pchoice%"=="2" set "PNAME=Plague" & goto ImportPalette
if "%pchoice%"=="3" set "PNAME=Sencky" & goto ImportPalette
if "%pchoice%"=="0" goto menu
goto PaletteMenu

:ImportPalette
copy /y "%STAGE_ROOT%\Assets\Palette\%PNAME%\Palette.ini" "%PALETTE_DEST%" >nul
echo  OK  %PNAME% Palette.ini imported.
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
