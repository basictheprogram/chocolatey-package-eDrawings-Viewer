$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64 = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2019sp04/27.4.0.0020-VF1T2ZZJ/pfw//eDrawingsFullAllX64.exe'
$checksum64 = 'd9eb9834af1c34bef1fdf92c0551f1710c52cd6f02f0da46c0fecc6a73e67e9e'
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
