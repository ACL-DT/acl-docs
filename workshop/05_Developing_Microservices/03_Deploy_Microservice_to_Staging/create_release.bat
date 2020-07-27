set /p version=<version

git checkout -b release/%version%
git push -u origin release/%version%

git checkout master

minor_version=
new_minor_version=

set /p new_version=<version
echo %new_version%

git add version
git commit -m "bump version to %new_version%"
git push origin master