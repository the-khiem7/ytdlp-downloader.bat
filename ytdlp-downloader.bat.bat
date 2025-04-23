@echo off
title YouTube Private Downloader
color 0A
echo.
echo YouTube Private Downloader
echo ==============================
echo.

:: Nhập link và cookie
set /p video_url=Enter YouTube video URL: 
set /p cookies_file=Enter full path to cookies.txt file: 

:: Kiểm tra cookies tồn tại
if not exist "%cookies_file%" (
    echo Cookie file not found!
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
