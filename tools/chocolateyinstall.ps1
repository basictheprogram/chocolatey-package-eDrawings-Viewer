$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64       = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2019sp03/27.3.0.0056-GLWVXMBN/pfw//eDrawingsFullAllX64.exe'
$checksum64  = '69920b774f308fb42132719cac011924c898a0676c9076857abc31f10f92b769'
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
  File           = Join-Path $WorkSpace "eDrawingsFullAllX64.exe"
  fileType       = 'exe'
  silentArgs     = '/S /v/qn'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'eDrawings*'
}

Install-ChocolateyInstallPackage @InstallArgs
