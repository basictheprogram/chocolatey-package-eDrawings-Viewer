$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64 = 'http://dl-ak.solidworks.com/nonsecure/edrawings/e2020sp01/28.1.0.0091-PCK0T79I/pfw//eDrawingsFullAllX64.exe'
$checksum64 = '6f3ea4c7809e4fb7c937c18b695697f3db3b37689f7d96c3dc6e71ec7872540e'
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
