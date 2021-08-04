$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64 = 'https://dl-ak.solidworks.com/nonsecure/edrawings/e2021sp04/29.4.0.0037-5G4950I9/pfw/eDrawingsFullAllX64.exe'
$checksum64 = '551ff3611ef05873519640ff90aa4bf3c559cfb8a7190a48e3846354ac27debe'
$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$WebFileArgs = @{
    packageName         = $packageName
    FileFullPath        = Join-Path $WorkSpace "$packageName.exe"
    Url64bit            = $url64
    Checksum64          = $checkSum64
    ChecksumType        = 'sha256'
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
