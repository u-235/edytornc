; NSIS script file


!include qt.nsi


;==============================;
; MINGW section                ;
;==============================;

Section "-Install dependies"
    SetOutPath "$INSTDIR\${DST_BIN}"

    File /oname=libgcc_s_dw2-1.dll "${SRC_CXX}\libgcc_s_dw2-1.dll"
    File /oname=libstdc++-6.dll "${SRC_CXX}\libstdc++-6.dll"
    File /oname=libwinpthread-1.dll "${SRC_CXX}\libwinpthread-1.dll"

!if /FileExists "${SRC_QT_DEP}\libEGL.dll"
    ; MINGW from Qt
    File /oname=libEGL.dll "${SRC_QT_DEP}\libEGL.dll"
    File /oname=libGLESv2.dll "${SRC_QT_DEP}\libGLESv2.dll"
!else
    ; MSYS2
    File /oname=libbrotlicommon.dll "${SRC_QT_DEP}\libbrotlicommon.dll"
    File /oname=libbrotlidec.dll "${SRC_QT_DEP}\libbrotlidec.dll"
    File /oname=libbz2-1.dll "${SRC_QT_DEP}\libbz2-1.dll"
    File /oname=libdouble-conversion.dll "${SRC_QT_DEP}\libdouble-conversion.dll"
    File /oname=libfreetype-6.dll "${SRC_QT_DEP}\libfreetype-6.dll"
    File /oname=libglib-2.0-0.dll "${SRC_QT_DEP}\libglib-2.0-0.dll"
    File /oname=libgraphite2.dll "${SRC_QT_DEP}\libgraphite2.dll"
    File /oname=libharfbuzz-0.dll "${SRC_QT_DEP}\libharfbuzz-0.dll"
    File /oname=libiconv-2.dll "${SRC_QT_DEP}\libiconv-2.dll"
    File /oname=libicudt72.dll "${SRC_QT_DEP}\libicudt72.dll"
    File /oname=libicuin72.dll "${SRC_QT_DEP}\libicuin72.dll"
    File /oname=libicuio72.dll "${SRC_QT_DEP}\libicuio72.dll"
    File /oname=libicutest72.dll "${SRC_QT_DEP}\libicutest72.dll"
    File /oname=libicutu72.dll "${SRC_QT_DEP}\libicutu72.dll"
    File /oname=libicuuc72.dll "${SRC_QT_DEP}\libicuuc72.dll"
    File /oname=libintl-8.dll "${SRC_QT_DEP}\libintl-8.dll"
    File /oname=libmd4c.dll "${SRC_QT_DEP}\libmd4c.dll"
    File /oname=libpcre2-16-0.dll "${SRC_QT_DEP}\libpcre2-16-0.dll"
    File /oname=libpcre2-8-0.dll "${SRC_QT_DEP}\libpcre2-8-0.dll"
    File /oname=libpng16-16.dll "${SRC_QT_DEP}\libpng16-16.dll"
    File /oname=libzstd.dll "${SRC_QT_DEP}\libzstd.dll"
    File /oname=zlib1.dll "${SRC_QT_DEP}\zlib1.dll"
!endif
SectionEnd

Section "un.Install dependies"
    Delete "$INSTDIR\${DST_BIN}\libgcc_s_dw2-1.dll"
    Delete "$INSTDIR\${DST_BIN}\libstdc++-6.dll"
    Delete "$INSTDIR\${DST_BIN}\libwinpthread-1.dll"

!if /FileExists "${SRC_QT_DEP}\libEGL.dll"
    ; MINGW from Qt
    Delete "$INSTDIR\${DST_BIN}\libEGL.dll"
    Delete "$INSTDIR\${DST_BIN}\libGLESv2.dll"
!else
    ; MSYS2
    Delete "$INSTDIR\${DST_BIN}\libbrotlicommon.dll"
    Delete "$INSTDIR\${DST_BIN}\libbrotlidec.dll"
    Delete "$INSTDIR\${DST_BIN}\libbz2-1.dll"
    Delete "$INSTDIR\${DST_BIN}\libdouble-conversion.dll"
    Delete "$INSTDIR\${DST_BIN}\libfreetype-6.dll"
    Delete "$INSTDIR\${DST_BIN}\libglib-2.0-0.dll"
    Delete "$INSTDIR\${DST_BIN}\libgraphite2.dll"
    Delete "$INSTDIR\${DST_BIN}\libharfbuzz-0.dll"
    Delete "$INSTDIR\${DST_BIN}\libiconv-2.dll"
    Delete "$INSTDIR\${DST_BIN}\libicudt72.dll"
    Delete "$INSTDIR\${DST_BIN}\libicuin72.dll"
    Delete "$INSTDIR\${DST_BIN}\libicuio72.dll"
    Delete "$INSTDIR\${DST_BIN}\libicutest72.dll"
    Delete "$INSTDIR\${DST_BIN}\libicutu72.dll"
    Delete "$INSTDIR\${DST_BIN}\libicuuc72.dll"
    Delete "$INSTDIR\${DST_BIN}\libintl-8.dll"
    Delete "$INSTDIR\${DST_BIN}\libmd4c.dll"
    Delete "$INSTDIR\${DST_BIN}\libpcre2-16-0.dll"
    Delete "$INSTDIR\${DST_BIN}\libpcre2-8-0.dll"
    Delete "$INSTDIR\${DST_BIN}\libpng16-16.dll"
    Delete "$INSTDIR\${DST_BIN}\libzstd.dll"
    Delete "$INSTDIR\${DST_BIN}\zlib1.dll"
!endif

    RMDir "$INSTDIR\${DST_BIN}"
    RMDir "$INSTDIR"
SectionEnd
