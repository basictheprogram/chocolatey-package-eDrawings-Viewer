$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64       = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2018sp03/18.3.0.0034/pfw//eDrawingsFullAllX64.exe'
$checksum64  = '08aed4b3b6fc4a29086d8438be807d6f8228331f74c3acc73244ab29c9f5d5a2'
$WorkSpace   = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$WebFileArgs = @{
  packageName  = $packageName
  FileFullPath = Join-Path $WorkSpace "$packageName.exe"
  Url64bit     = $url64
  Checksum64   = $checkSum64
  ChecksumType = 'sha256'
  GetOriginalFileName = $true
}

$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$UnzipArgs = @{
  PackageName  = $packageName
  FileFullPath = $PackedInstaller
  Destination  = $WorkSpace
}

Get-ChocolateyUnzip @UnzipArgs

$InstallArgs = @{
  PackageName    = $packageName
  File           = Join-Path $WorkSpace "eDrawings.msi"
  fileType       = 'msi'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs
