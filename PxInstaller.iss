[Setup]
AppName=PxInstaller
AppVerName=0.8.3
AppCopyright=Copyright (C) 2023 Carsten Riedel
VersionInfoCopyright=Copyright (C) 20232 Carsten Riedel
VersionInfoCompany=
VersionInfoDescription=PxInstaller
VersionInfoOriginalFileName=PxInstaller
VersionInfoProductName=PxInstaller
VersionInfoVersion=0.8.3.0
DefaultDirName={pf64}\

OutputBaseFilename=PxInstaller
OutputDir=.
Compression=zip
SolidCompression=yes
DisableDirPage=yes
Uninstallable=yes
CreateAppDir=No


[Files]
Source: "binaries\0.8.3\px.ini"; DestDir: "{pf64}\Px\0.8.3"; Permissions: users-modify;
Source: "binaries\0.8.3\*"; DestDir: "{pf64}\Px\0.8.3"; Flags: recursesubdirs createallsubdirs ignoreversion sortfilesbyextension
Source: "binaries\0.8.3\px.ini"; DestDir: "{pf64}\Px\0.8.3"; Permissions: users-modify;



[Run]
//Filename: "{cmd}"; Parameters: "/C start /wait """" ""{pf64}\Px\0.8.3\px.exe"" --install" ; Description: Run installer  ; Flags: runhidden;
Filename: "{pf64}\Px\0.8.3\px.exe"; Parameters: "--install" ; Flags: runhidden;

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment";ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{pf64}\Px\0.8.3"; Check: NeedsAddPath('{pf64}\Px\0.8.3')

[UninstallRun]
//Filename: "{cmd}"; Parameters: "/C start /wait """" ""{pf64}\Px\0.8.3\px.exe"" --uninstall" ; Flags:  runhidden
Filename: "{pf64}\Px\0.8.3\px.exe"; Parameters: "--uninstall" ; Flags: runhidden;



[Code]
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;




