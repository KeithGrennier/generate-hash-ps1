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

# Generate SHA256 hash
$hash = Get-FileHash -Algorithm SHA256 $FilePath

# Display the hash value
Write-Host "SHA256 hash of the file:"
Write-Host $hash.Hash
