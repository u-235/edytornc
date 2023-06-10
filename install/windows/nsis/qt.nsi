; NSIS script file


;==============================;
; Qt section                   ;
;==============================;

Section "-Install Qt"
    SetOutPath "$INSTDIR\${DST_BIN}"

    File /oname=Qt5Core.dll "${SRC_QT}\Qt5Core.dll"
    File /oname=Qt5Gui.dll "${SRC_QT}\Qt5Gui.dll"
    File /oname=Qt5Network.dll "${SRC_QT}\Qt5Network.dll"
    File /oname=Qt5PrintSupport.dll "${SRC_QT}\Qt5PrintSupport.dll"
    File /oname=Qt5SerialPort.dll "${SRC_QT}\Qt5SerialPort.dll"
    File /oname=Qt5Widgets.dll "${SRC_QT}\Qt5Widgets.dll"

    CreateDirectory "$INSTDIR\${DST_BIN}\bearer"
    CreateDirectory "$INSTDIR\${DST_BIN}\imageformats"
    CreateDirectory "$INSTDIR\${DST_BIN}\platforms"
    CreateDirectory "$INSTDIR\${DST_BIN}\printsupport"
    CreateDirectory "$INSTDIR\${DST_BIN}\styles"

    ; Qt plugins
    File /oname=bearer\qgenericbearer.dll "${SRC_QT_PLUGINS}\bearer\qgenericbearer.dll"
    File /oname=imageformats\qgif.dll "${SRC_QT_PLUGINS}\imageformats\qgif.dll"
    File /oname=imageformats\qico.dll "${SRC_QT_PLUGINS}\imageformats\qico.dll"
    File /oname=imageformats\qjpeg.dll "${SRC_QT_PLUGINS}\imageformats\qjpeg.dll"
    File /oname=platforms\qwindows.dll "${SRC_QT_PLUGINS}\platforms\qwindows.dll"
    File /oname=printsupport\windowsprintersupport.dll "${SRC_QT_PLUGINS}\printsupport\windowsprintersupport.dll"
    File /oname=styles\qwindowsvistastyle.dll "${SRC_QT_PLUGINS}\styles\qwindowsvistastyle.dll"

    CreateDirectory "$INSTDIR\${DST_BIN}\translations"
    File /nonfatal /oname=translations/qt_ca.qm "${SRC_QT_I18N}\qt_ca.qm"
    File /nonfatal /oname=translations/qtbase_ca.qm "${SRC_QT_I18N}\qtbase_ca.qm"
    File /nonfatal /oname=translations/qtserialport_ca.qm "${SRC_QT_I18N}\qtserialport_ca.qm"
    File /nonfatal /oname=translations/qt_cs.qm "${SRC_QT_I18N}\qt_cs.qm"
    File /nonfatal /oname=translations/qtbase_cs.qm "${SRC_QT_I18N}\qtbase_cs.qm"
    File /nonfatal /oname=translations/qtserialport_cs.qm "${SRC_QT_I18N}\qtserialport_cs.qm"
    File /nonfatal /oname=translations/qt_de.qm "${SRC_QT_I18N}\qt_de.qm"
    File /nonfatal /oname=translations/qtbase_de.qm "${SRC_QT_I18N}\qtbase_de.qm"
    File /nonfatal /oname=translations/qtserialport_de.qm "${SRC_QT_I18N}\qtserialport_de.qm"
    File /nonfatal /oname=translations/qt_es.qm "${SRC_QT_I18N}\qt_es.qm"
    File /nonfatal /oname=translations/qtbase_es.qm "${SRC_QT_I18N}\qtbase_es.qm"
    File /nonfatal /oname=translations/qtserialport_es.qm "${SRC_QT_I18N}\qtserialport_es.qm"
    File /nonfatal /oname=translations/qt_fi.qm "${SRC_QT_I18N}\qt_fi.qm"
    File /nonfatal /oname=translations/qtbase_fi.qm "${SRC_QT_I18N}\qtbase_fi.qm"
    File /nonfatal /oname=translations/qtserialport_fi.qm "${SRC_QT_I18N}\qtserialport_fi.qm"
    File /nonfatal /oname=translations/qt_nl.qm "${SRC_QT_I18N}\qt_nl.qm"
    File /nonfatal /oname=translations/qtbase_nl.qm "${SRC_QT_I18N}\qtbase_nl.qm"
    File /nonfatal /oname=translations/qtserialport_nl.qm "${SRC_QT_I18N}\qtserialport_nl.qm"
    File /nonfatal /oname=translations/qt_pl.qm "${SRC_QT_I18N}\qt_pl.qm"
    File /nonfatal /oname=translations/qtbase_pl.qm "${SRC_QT_I18N}\qtbase_pl.qm"
    File /nonfatal /oname=translations/qtserialport_pl.qm "${SRC_QT_I18N}\qtserialport_pl.qm"
    File /nonfatal /oname=translations/qt_ru.qm "${SRC_QT_I18N}\qt_ru.qm"
    File /nonfatal /oname=translations/qtbase_ru.qm "${SRC_QT_I18N}\qtbase_ru.qm"
    File /nonfatal /oname=translations/qtserialport_ru.qm "${SRC_QT_I18N}\qtserialport_ru.qm"
SectionEnd

Section "un.Install Qt"
    Delete "$INSTDIR\${DST_BIN}\Qt5Core.dll"
    Delete "$INSTDIR\${DST_BIN}\Qt5Gui.dll"
    Delete "$INSTDIR\${DST_BIN}\Qt5Network.dll"
    Delete "$INSTDIR\${DST_BIN}\Qt5PrintSupport.dll"
    Delete "$INSTDIR\${DST_BIN}\Qt5SerialPort.dll"
    Delete "$INSTDIR\${DST_BIN}\Qt5Widgets.dll"

    ; Qt plugins
    Delete "$INSTDIR\${DST_BIN}\bearer\qgenericbearer.dll"
    Delete "$INSTDIR\${DST_BIN}\imageformats\qgif.dll"
    Delete "$INSTDIR\${DST_BIN}\imageformats\qico.dll"
    Delete "$INSTDIR\${DST_BIN}\imageformats\qjpeg.dll"
    Delete "$INSTDIR\${DST_BIN}\platforms\qwindows.dll"
    Delete "$INSTDIR\${DST_BIN}\printsupport\windowsprintersupport.dll"
    Delete "$INSTDIR\${DST_BIN}\styles\qwindowsvistastyle.dll"

    Delete "$INSTDIR\${DST_BIN}\qt_*.qm"
    Delete "$INSTDIR\${DST_BIN}\qtbase_*.qm"
    Delete "$INSTDIR\${DST_BIN}\qtserialport_*.qm"

    RMDir "$INSTDIR\${DST_BIN}\bearer"
    RMDir "$INSTDIR\${DST_BIN}\imageformats"
    RMDir "$INSTDIR\${DST_BIN}\platforms"
    RMDir "$INSTDIR\${DST_BIN}\printsupport"
    RMDir "$INSTDIR\${DST_BIN}\styles"
    RMDir "$INSTDIR\${DST_BIN}\translations"
    RMDir "$INSTDIR\${DST_BIN}"
    RMDir "$INSTDIR"
SectionEnd
