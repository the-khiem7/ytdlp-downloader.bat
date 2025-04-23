# YouTube Private Video Downloader

A Windows batch script that allows downloading private/restricted YouTube videos using yt-dlp with cookies authentication.

## Prerequisites

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) installed and available in system PATH
- A valid cookies.txt file exported from your YouTube-logged-in browser

## Features

- Downloads private/restricted YouTube videos using cookies authentication
- Automatically selects best video and audio quality
- Merges video and audio into MP4 format
- Validates cookie file existence and authenticity
- Shows video title before downloading
- Opens explorer to downloaded file location when complete

## Usage

1. Run the `ytdlp-downloader.bat` script
2. Enter the YouTube video URL when prompted
3. Enter the full path to your cookies.txt file when prompted
4. Wait for download to complete
5. File explorer will open showing your downloaded video

## How it works

The script will:
1. Validate that the provided cookies.txt file exists
2. Test the cookies by attempting to fetch the video title
3. Display the video title if cookies are valid
4. Download the video in best quality using yt-dlp
5. Merge video and audio into MP4 format
6. Open the folder containing the downloaded file

## Error Handling

The script includes basic error handling for:
- Missing cookies file
- Invalid/expired cookies
- Invalid video URLs

## Requirements

- Windows operating system
- yt-dlp installed
- Valid YouTube cookies.txt file

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.