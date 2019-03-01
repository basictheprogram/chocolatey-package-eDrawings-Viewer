$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64       = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2019sp01/27.1.0.0092-YSZWNLN6/pfw//eDrawingsFullAllX64.exe'
$checksum64  = '44a9ea99ef9426444e3412b2a73752d781d8362f8de36b8af0bcd3b8f5a96097'
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
  silentArgs     = "/S /v/qn"
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'eDrawings*'
}

Install-ChocolateyInstallPackage @InstallArgs
