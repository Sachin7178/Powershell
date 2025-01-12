# PowerShell script to download and extract files
# .\DownloadAndExtract.ps1 -url "https://example.com/somefile.zip"


param (
    [string]$url,
    [string]$destinationFolder = "C:\Downloads"
)

# Ensure the destination folder exists
if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory
    Write-Host "Created destination folder: $destinationFolder"
}

# Define the file name from the URL
$fileName = [System.IO.Path]::GetFileName($url)
$filePath = Join-Path -Path $destinationFolder -ChildPath $fileName

# Download the file
Write-Host "Downloading file from $url to $filePath..."
Invoke-WebRequest -Uri $url -OutFile $filePath

# Check if the file is a zip archive
if ($filePath.EndsWith(".zip")) {
    Write-Host "Extracting ZIP archive..."
    $extractFolder = Join-Path -Path $destinationFolder -ChildPath [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    
    # Create extraction folder if it doesn't exist
    if (-not (Test-Path -Path $extractFolder)) {
        New-Item -Path $extractFolder -ItemType Directory
    }

    # Extract the ZIP file
    Expand-Archive -Path $filePath -DestinationPath $extractFolder
    Write-Host "Extracted contents to $extractFolder"
} else {
    Write-Host "Downloaded file is not a ZIP archive."
}

Write-Host "Process completed successfully."
