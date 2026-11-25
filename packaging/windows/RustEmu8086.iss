;-----------------------------------------------------------------------------
; RustEmu8086 Windows 安装包脚本 (Inno Setup 7)
; 用法：在仓库根目录运行  iscc packaging/windows/RustEmu8086.iss
;-----------------------------------------------------------------------------

#define MyAppName "RustEmu8086"
#define MyAppVersion "0.2.1"
#define MyAppPublisher "RustEmu8086 project"
#define MyAppURL "https://github.com/OlegDurandin/RustEmu8086"
#define MyAppExeName "RustEmu8086.exe"
#define MyCliExeName "rustemu.exe"

[Setup]
AppId={{{E3F4A2B1-5C6D-4E7F-8A9B-0C1D2E3F4A5B}}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={commonpf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=LICENSE
OutputDir=packaging/windows/output
OutputBaseFilename=RustEmu8086-setup-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Languages]
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "fileassoc"; Description: "关联 .asm 文件到 {#MyAppName}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "target\release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "target\release\{#MyCliExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "examples\*"; DestDir: "{app}\examples"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\rustemu 命令行工具"; Filename: "{app}\{#MyCliExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
Root: HKCR; Subkey: ".asm"; ValueName: ""; ValueData: "RustEmu8086.asm"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "RustEmu8086.asm\DefaultIcon"; ValueName: ""; ValueData: "{app}\RustEmu8086.exe,0"; Flags: uninsdeletekey
Root: HKCR; Subkey: "RustEmu8086.asm\shell\open\command"; ValueName: ""; ValueData: """{app}\RustEmu8086.exe"" ""%1"""; Flags: uninsdeletekey

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "启动 {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}\examples"

[Code]
function InitializeSetup(): Boolean;
begin
  Result := True;
end;
