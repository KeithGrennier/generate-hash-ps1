param (
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

# Remove any surrounding quotes from the file path
$FilePath = $FilePath.Trim('"')

# Check if the file path is valid
if (-Not (Test-Path $FilePath -PathType Leaf)) {
    Write-Host "Error: The file does not exist or the path is invalid."
    Exit
}

# Get the file's last modified date
$lastModifiedDate = (Get-Item $FilePath).LastWriteTimeUtc

# Read the file content
$fileContent = Get-Content $FilePath

# Combine the file content and last modified date into a single string
$dataToHash = $fileContent + $lastModifiedDate.ToString()

# Generate SHA256 hash of the combined data
$hash = [System.Security.Cryptography.HashAlgorithm]::Create("SHA256").ComputeHash([System.Text.Encoding]::UTF8.GetBytes($dataToHash))

# Convert the hash to a hexadecimal string representation
$hashHex = [System.BitConverter]::ToString($hash).Replace("-", "").ToLower()

# Display the hash value
Write-Host "SHA256 hash of the file content and last modified date:"
Write-Host $hashHex
