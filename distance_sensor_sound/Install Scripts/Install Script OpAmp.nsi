;NSIS Modern User Interface version 1.70
;OpAmp Installer
;Written by Christian Budde

SetCompressor lzma

;--------------------------------
;Include Modern UI
;  !include "Sections.nsh"
  !define SF_SELECTED   1
  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "OpAmp Installer"
  OutFile "OpAmp.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\VSTPlugIns"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "SOFTWARE\VST" "VSTPluginsPath"

  BrandingText "OpAmp VST Plugin"

  ; Turn on the xp style of drawing
  XPStyle ON

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKLM" 
  !define MUI_LANGDLL_REGISTRY_KEY "SOFTWARE\ITA\Non Linear"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"
;  !insertmacro MUI_LANGUAGE "German"

;--------------------------------

;Installer Sections

Section "OpAmp VST-Plugin" SecProgramFiles
  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File "..\Bin\OpAmp.dll"

  ;Store installation folder
  WriteRegStr HKLM "SOFTWARE\ITA\OpAmp" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallOpAmp.exe"


SectionEnd

;--------------------------------
;Installer Functions

  LangString TEXT_IO_TITLE ${LANG_ENGLISH} "InstallOptions page"
  LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "OpAmp VST Plugin"

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecProgramFiles ${LANG_ENGLISH} "OpAmp VST Plugin"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecProgramFiles} $(DESC_SecProgramFiles)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  Delete "$INSTDIR\OpAmp.dll"
  DeleteRegKey HKLM "SOFTWARE\ITA\OpAmp"

SectionEnd