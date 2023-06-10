
APP_ARCH=$$QMAKE_HOST.arch
INSTALLER_FILE="$${PROJECT_BUILD_PATH}/EdytorncSetup_$${APP_ARCH}.exe"
CXX_RUNTIME=$$system(where $$QMAKE_CXX)
CXX_RUNTIME=$$dirname(CXX_RUNTIME)

QMAKE_EXTRA_TARGETS += windeployqt
windeployqt.commands = windeployqt --compiler-runtime "$$BIN_PATH"

QMAKE_EXTRA_TARGETS += nsis

mingw {
    NSIS_EXTRA_FILES="$${PWD}/nsis/mingw.nsi"
}

nsis.commands = makensis\
    -DAPP_ARCH=$$APP_ARCH\
    -DINSTALLER_FILE="$$INSTALLER_FILE"\
    -DPROJECT_ROOT="$$PROJECT_ROOT_PATH"\
    -DSRC_BIN="$$BIN_PATH"\
    -DCXX_RUNTIME="$$CXX_RUNTIME"\
    -DQT_HOST_BINS="$$[QT_HOST_BINS]"\
    -DQT_HOST_DATA="$$[QT_HOST_DATA]"\
    "$${PWD}/nsis/app.nsi"\
    "$${NSIS_EXTRA_FILES}"
