$folder = $PSScriptRoot
$destinationRoot = '..\rikard-engstrom.github.io'

# Verify that destination is clean
cd $destinationRoot
$gitStatus = $(git status)
cd $folder

$isClean = ([string]$gitStatus).IndexOf('nothing to commit, working tree clean') -ge 0
if (-not $isClean) {
	$Host.UI.WriteErrorLine('Destination repository is not clean!')
	Exit
}

# --- Watch part -----------------------------
# Clean destination
#$destination = "$destinationRoot\golf-round\watch"
remove-item "$destinationRoot\golf-round\watch" -recurse -errorAction ignore

# Copy dist folder
$source = "$folder\watch"
copy-item -path $source -destination "$destinationRoot\golf-round\watch" -recurse
# -----------------------------------------

# Git commit and push
cd $destinationRoot
git add .
git commit -am "Golf round"
git push
cd $folder


