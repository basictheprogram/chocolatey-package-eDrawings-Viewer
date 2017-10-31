$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64       = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2018sp0/18.0.0.5043/pfwnew//eDrawingsFullAllX64.exe'
$checksum64  = '5a22e07ae8e8fee19a8055eaebc756b335ca6f1ee11a99e35dbf2772766a0305'
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
