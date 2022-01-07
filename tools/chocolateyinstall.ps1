$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64 = 'https://dl-ak.solidworks.com/nonsecure/edrawings/e2022sp0/30.0.0.5017-3SD6QS1R/pfw//eDrawingsFullAllX64.exe'
$checksum64 = 'bc2e66caa8a3fbe6eb1443c98665217e992c98ff6ac04bb247a15366d00b3670'
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
