# https://github.com/nvim-telescope/telescope-fzf-native.nvim
$LOG = "$(Get-Location)/build_telescope_fzf_native.log"
$WDIR = $args[0]
Set-Location $WDIR
Write-Output "PWD: $(Get-Location)" > $LOG
cmake "-S." "-Bbuild" "-DCMAKE_BUILD_TYPE=Release" >> $LOG && cmake "--build" build "--config" Release >> $LOG
if (Test-Path "$WDIR\build\Release\libfzf.dll" -PathType Leaf)
{
	Move-Item -Force "$WDIR\build\Release\libfzf.dll" "$WDIR\build\"
}
