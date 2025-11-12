# backup.ps1
param(
    [string]$RepoPath = "C:\Users\USER\Documents\event-data-system",
    [string]$Remote = "origin",
    [string]$Branch = "main"
)

# Timestamp for commit messages/logging
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "[$timestamp] Starting automated backup..."

# Move into repo
Set-Location $RepoPath

# Abort if repo isn't clean-able
$gitStatus = git status --porcelain
if ([string]::IsNullOrWhiteSpace($gitStatus)) {
    Write-Host "No changes to commit. Exiting."
    exit 0
}

# Stage changes
git add -A

# Commit with timestamped message
git commit -m "Automated backup $timestamp"

# Pull latest to avoid conflicts (optional but safer)
git pull $Remote $Branch --ff-only

# Push
git push $Remote $Branch

Write-Host "[$timestamp] Backup completed successfully."