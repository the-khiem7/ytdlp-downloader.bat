@echo off
title YouTube Private Downloader
color 0F

:: Kiểm tra Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed! Please install Python from https://www.python.org/
    pause
    exit /b
)

:: Kiểm tra yt-dlp
yt-dlp --version >nul 2>&1
if %errorlevel% neq 0 (
    echo yt-dlp is not installed! Please install it using: pip install yt-dlp
    pause
    exit /b
)

:: Kiểm tra FFmpeg
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo FFmpeg is not installed! Please follow these steps:
    echo.
    echo 1. Download FFmpeg from https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip
    echo 2. Extract the zip file and locate the 'bin' folder containing ffmpeg.exe
    echo 3. Add the bin folder path to System Environment Variables:
    echo    - Press Windows + R, type "sysdm.cpl"
    echo    - Go to "Advanced" tab ^> "Environment Variables"
    echo    - Under "System Variables", find and select "Path"
    echo    - Click "Edit" ^> "New"
    echo    - Paste the full path to the bin folder
    echo    - Click "OK" on all windows
    echo.
    echo After adding to Path, restart this script.
    pause
    exit /b
)

:: Nhập link và cookie
set /p video_url=Enter YouTube video URL: 
echo Note: To get cookies.txt file:
echo 1. Install "Get cookies.txt LOCALLY" extension from:
echo    https://chromewebstore.google.com/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc
echo 2. Log in to YouTube
echo 3. Click extension icon and Export cookies.txt
echo.
set /p cookies_file=Enter full path to cookies.txt file: 

:: Kiểm tra cookies tồn tại
if not exist "%cookies_file%" (
    echo Cookie file not found!
    echo Please install the "Get cookies.txt LOCALLY" Chrome extension and export your cookies first.
    pause
    exit /b
)

:: Kiểm tra cookies còn sống (bằng thử fetch title video)
for /f "delims=" %%i in ('yt-dlp --cookies "%cookies_file%" --get-title "%video_url%" 2^>nul') do (
    set video_title=%%i
)

if not defined video_title (
    echo Cookie may have expired or invalid link.
    pause
    exit /b
)

:: Hiển thị tiêu đề video
echo.
echo Video Title: %video_title%
echo.

:: Thực hiện tải
echo Downloading video...
yt-dlp -f "bestvideo+bestaudio[ext=m4a]" --merge-output-format mp4 --cookies "%cookies_file%" "%video_url%"

:: Lấy file output mới nhất
for /f "delims=" %%f in ('dir /b /a:-d /o:-d *.mp4') do (
    set last_file=%%f
    goto break
)
:break

:: Mở thư mục chứa file
echo.
echo Done! File saved as: %last_file%
explorer.exe .

pause
