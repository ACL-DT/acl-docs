#Define GitHub organization mandatory parameter

param
(
  [Parameter(Mandatory)]
  [string]
  ${GitHub-Organization}

)

$uri = "https://api.github.com/orgs/${GitHub-Organization}/repos"

#Check if Git is installed
if(Get-Command git -errorAction SilentlyContinue){}
else{
    Write-Host "Please install the 'git' command: https://git-scm.com/" -ForegroundColor Red
    exit 1
}

#Get repos in Organization:
try{
$repositories = Invoke-RestMethod -ContentType 'application/json' -Uri $uri
}
catch{
     Write-Host "No repositories found in ${GitHub-Organization}"
     exit 1
}


$current_dir = [string](Get-Location)
$new_dir = "${current_dir}\${GitHub-Organization}"
Write-Host "Repositories will be cloned to: ${new_dir}\" -ForegroundColor Yellow
Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
New-Item -Path . -Name "${GitHub-Organization}" -ItemType "directory" | Out-Null
Set-Location ${GitHub-Organization}

foreach ($repo in $repositories) {
   Write-Host "Cloning" $repo.clone_url -ForegroundColor White
   git clone -q $repo.clone_url
   Write-Host "Done cloning" $repo.name -ForegroundColor Green
}

Write-Host ""
Write-Host "The repositories have been cloned to: ${new_dir}\" -ForegroundColor Blue -BackgroundColor White
Set-Location ..
exit 0