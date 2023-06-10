; NSIS script file


;==============================;
; Configuration                ;
;==============================;

!ifndef APP_ARCH
    !define APP_ARCH x86_64
!endif

!ifndef INSTALLER_FILE
    !define INSTALLER_FILE InstallEdytorNC_${APP_ARCH}.exe
!endif

; Base directories

!ifndef PROJECT_ROOT
    !define PROJECT_ROOT ${__FILEDIR__}\..\..\..
!endif

!ifndef BUILD_ROOT
    !if /FileExists "${BUILD_ROOT}\build\"
        !define BUILD_ROOT ${PROJECT_ROOT}\build
    !else
        !define BUILD_ROOT ${PROJECT_ROOT}
    !endif
!endif

; Sources directories

!ifndef SRC_BIN
    !define SRC_BIN ${PROJECT_ROOT}\bin\release
!endif

!ifndef SRC_DOC
    !define SRC_DOC ${PROJECT_ROOT}\doc
!endif

!ifndef SRC_EXAMPLES
    !define SRC_EXAMPLES ${PROJECT_ROOT}\examples
!endif

!ifndef SRC_I18N
    !define SRC_I18N ${PROJECT_ROOT}\lang
!endif

!ifndef SRC_CXX
    !ifdef CXX_RUNTIME
        !define SRC_CXX ${CXX_RUNTIME}
    !else
        !define SRC_CXX ${SRC_BIN}
    !endif
!endif

!ifndef SRC_QT
    !ifdef QT_HOST_BINS
        !define SRC_QT ${QT_HOST_BINS}
    !else
        !define SRC_QT ${SRC_BIN}
    !endif
!endif

!ifndef SRC_QT_DEP
    !ifdef QT_HOST_BINS
        !define SRC_QT_DEP ${QT_HOST_BINS}
    !else
        !define SRC_QT_DEP ${SRC_QT}
    !endif
!endif

!ifndef SRC_QT_PLUGINS
    !ifdef QT_HOST_DATA
        !define SRC_QT_PLUGINS ${QT_HOST_DATA}\plugins
    !else
        !define SRC_QT_PLUGINS ${SRC_QT}
    !endif
!endif

!ifndef SRC_QT_I18N
    !ifdef QT_HOST_DATA
        !define SRC_QT_I18N ${QT_HOST_DATA}\translations
    !else
        !define SRC_QT_I18N ${SRC_QT}\translations
    !endif
!endif

; Destination subdirectories

!ifndef DST_BIN
    !define DST_BIN bin
!endif

!ifndef DST_DOC
    !define DST_DOC doc
!endif

!ifndef DST_EXAMPLES
    !define DST_EXAMPLES examples
!endif

!ifndef DST_I18N
    !define DST_I18N lang
!endif


;==============================;
; General                      ;
;==============================;

; The icon for the installer and uninstaller.
;   MUI_ICON icon_file
;   MUI_UNICON icon_file

    Unicode true
    Name "EdytorNC"
    OutFile "${INSTALLER_FILE}"

!if ${APP_ARCH} == "x86_64"
    InstallDir "$PROGRAMFILES64\EdytorNC"
!else
    InstallDir "$PROGRAMFILES32\EdytorNC"
!endif
    
    InstallDirRegKey HKEY_LOCAL_MACHINE "SOFTWARE\EdytorNC" ""
;   SetCompressor lzma


; Modern UI

    !include "MUI.nsh"
    !define MUI_ABORTWARNING


;==============================;
; Pages                        ;
;==============================;
 
    Var STARTMENU_FOLDER

    !insertmacro MUI_PAGE_WELCOME
    !insertmacro MUI_PAGE_LICENSE "${PROJECT_ROOT}\LICENSE"
    !insertmacro MUI_PAGE_DIRECTORY

    ;Start Menu Folder Page Configuration
    !define MUI_STARTMENUPAGE_REGISTRY_ROOT HKEY_LOCAL_MACHINE
    !define MUI_STARTMENUPAGE_REGISTRY_KEY "SOFTWARE\EdytorNC"
    !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
    !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

    !insertmacro MUI_PAGE_INSTFILES
    !insertmacro MUI_PAGE_FINISH

    ; Uninstaller pages
    !insertmacro MUI_UNPAGE_WELCOME
    !insertmacro MUI_UNPAGE_CONFIRM
    !insertmacro MUI_UNPAGE_INSTFILES
    !insertmacro MUI_UNPAGE_FINISH


;==============================;
; Languages                    ;
;==============================;

    !insertmacro MUI_LANGUAGE "English"
    !insertmacro MUI_LANGUAGE "Russian"


;==============================;
; Main section                 ;
;==============================;

Section "-Install"
    SetOutPath "$INSTDIR"
    File /oname=LICENSE.txt "${PROJECT_ROOT}\LICENSE"

    SetOutPath "$INSTDIR\${DST_BIN}"
    File /oname=EdytorNC.exe "${SRC_BIN}\edytornc.exe"
    File /oname=SFS.exe "${SRC_BIN}\sfs.exe"
    File /oname=qt.conf "${__FILEDIR__}\..\qt.conf"

    ;Store installation folder
    WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\EdytorNC" "" "$INSTDIR"

    ;Create uninstaller
    WriteUninstaller "$INSTDIR\uninst.exe"

    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\EdytorNC.lnk" "$INSTDIR\${DST_BIN}\EdytorNC.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\uninst.exe"
    !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Uninstall"
    Push $R0
    !insertmacro MUI_STARTMENU_GETFOLDER Application $R0
    Delete "$SMPROGRAMS\$R0\Uninstall.lnk"
    Delete "$SMPROGRAMS\$R0\EdytorNC.lnk"
    RMDir  "$SMPROGRAMS\$R0"
    Pop $R0

    DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\EdytorNC"
    DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\EdytorNC"

    Delete "$INSTDIR\${DST_BIN}\EdytorNC.exe"
    Delete "$INSTDIR\${DST_BIN}\SFS.exe"
    Delete "$INSTDIR\${DST_BIN}\qt.conf"
    Delete "$INSTDIR\LICENSE.txt"
    Delete "$INSTDIR\uninst.exe"

    RMDir "$INSTDIR\${DST_BIN}"
    RMDir "$INSTDIR"
SectionEnd


;==============================;
; Internationalisation         ;
;==============================;

Section "-Install i18n"
    SetOutPath "$INSTDIR\${DST_I18N}"

    File /oname=edytornc_ca.qm "${SRC_I18N}\edytornc_ca.qm" 
    File /oname=edytornc_cs_CZ.qm "${SRC_I18N}\edytornc_cs_CZ.qm"
    File /oname=edytornc_de.qm "${SRC_I18N}\edytornc_de.qm"
    File /oname=edytornc_es.qm "${SRC_I18N}\edytornc_es.qm"
    File /oname=edytornc_fi.qm "${SRC_I18N}\edytornc_fi.qm"
    File /oname=edytornc_nl.qm "${SRC_I18N}\edytornc_nl.qm"
    File /oname=edytornc_pl.qm "${SRC_I18N}\edytornc_pl.qm"
    File /oname=edytornc_ru.qm "${SRC_I18N}\edytornc_ru.qm"
    File /oname=kdiff3_ca.qm "${SRC_I18N}\kdiff3_ca.qm"
    File /oname=kdiff3_cs_CZ.qm "${SRC_I18N}\kdiff3_cs_CZ.qm"
    File /oname=kdiff3_de.qm "${SRC_I18N}\kdiff3_de.qm"
    File /oname=kdiff3_es.qm "${SRC_I18N}\kdiff3_es.qm"
    File /oname=kdiff3_fi.qm "${SRC_I18N}\kdiff3_fi.qm"
    File /oname=kdiff3_nl.qm "${SRC_I18N}\kdiff3_nl.qm"
    File /oname=kdiff3_pl.qm "${SRC_I18N}\kdiff3_pl.qm"
    File /oname=kdiff3_ru.qm "${SRC_I18N}\kdiff3_ru.qm"
SectionEnd

Section "un.Install i18n"
    Delete "$INSTDIR\${DST_I18N}\edytornc_ca.qm" 
    Delete "$INSTDIR\${DST_I18N}\edytornc_cs_CZ.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_de.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_es.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_fi.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_nl.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_pl.qm"
    Delete "$INSTDIR\${DST_I18N}\edytornc_ru.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_ca.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_cs_CZ.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_de.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_es.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_fi.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_nl.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_pl.qm"
    Delete "$INSTDIR\${DST_I18N}\kdiff3_ru.qm"

    RMDir "$INSTDIR\${DST_I18N}"
    RMDir "$INSTDIR"
SectionEnd


;==============================;
; Documentation                ;
;==============================;

Section "-Install doc"
    SetOutPath "$INSTDIR\${DST_DOC}"

    File /oname=EdytorNC_SerialTransmission_Help.html "${SRC_DOC}\EdytorNC_SerialTransmission_Help.html"
SectionEnd

Section "un.Install doc"
    Delete "$INSTDIR\${DST_DOC}\EdytorNC_SerialTransmission_Help.html"

    RMDir "$INSTDIR\${DST_DOC}"
    RMDir "$INSTDIR"
SectionEnd


;==============================;
; Examples                     ;
;==============================;

Section "-Install Examples"
    SetOutPath "$INSTDIR\${DST_EXAMPLES}"

    File /oname=0100.nc "${SRC_EXAMPLES}\0100.nc"
    File /oname=FANUC0M.nc "${SRC_EXAMPLES}\FANUC0M.nc"
    File /oname=FANUC0T.nc "${SRC_EXAMPLES}\FANUC0T.nc"
    File /oname=FLANGE.nc "${SRC_EXAMPLES}\FLANGE.nc"
    File /oname=HAAS.nc "${SRC_EXAMPLES}\HAAS.nc"
    File /oname=HK.nc "${SRC_EXAMPLES}\HK.nc"
    File /oname=OSP5020M.nc "${SRC_EXAMPLES}\OSP5020M.nc"
    File /oname=OSP7000L.nc "${SRC_EXAMPLES}\OSP7000L.nc"
    File /oname=PHILIPS.nc "${SRC_EXAMPLES}\PHILIPS.nc"
    File /oname=SINUMERIK840D.nc "${SRC_EXAMPLES}\SINUMERIK840D.nc"
    File /oname=SINUMERIK850.nc "${SRC_EXAMPLES}\SINUMERIK850.nc"
    File /oname=TOKARKA.nc "${SRC_EXAMPLES}\TOKARKA.NC"
    File /oname=cnc_tips.txt "${SRC_EXAMPLES}\cnc_tips.txt"
    File /oname=macro7.nc "${SRC_EXAMPLES}\macro7.nc"
SectionEnd

Section "un.Install Examples"
    Delete "$INSTDIR\${DST_EXAMPLES}\0100.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\FANUC0M.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\FANUC0T.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\FLANGE.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\HAAS.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\HK.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\OSP5020M.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\OSP7000L.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\PHILIPS.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\SINUMERIK840D.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\SINUMERIK850.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\TOKARKA.nc"
    Delete "$INSTDIR\${DST_EXAMPLES}\cnc_tips.txt"
    Delete "$INSTDIR\${DST_EXAMPLES}\macro7.nc"

    RMDir "$INSTDIR\${DST_EXAMPLES}"
    RMDir "$INSTDIR"
SectionEnd
