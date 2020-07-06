$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64 = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2020sp03/28.3.0.0025-CFOJ7K4B/pfw/eDrawingsFullAllX64.exe'
$checksum64 = 'aa4ed4e1d1374e8a67f398efaeca70f0b162ec0e3107b57b0f0d1e2b898f18b1'
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
