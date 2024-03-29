

PROJECT_ROOT_PATH = $${PWD}

CONFIG(debug, debug|release) {
    BUILD_FLAG = debug
    CONFIG *= warn_on
} else {
    BUILD_FLAG = release
    # Supress debug message
    DEFINES *= QT_NO_DEBUG_OUTPUT # QT_NO_INFO_OUTPUT
}

CONFIG *= c++11
CONFIG -= debug_and_release debug_and_release_target

# moc doesn't detect Q_OS_LINUX correctly, so add this to make it work
linux*:DEFINES *= __linux__

LANG_PATH = $${PROJECT_ROOT_PATH}/lang
# define locales for translation
LANG_LIST = pl ca de fi cs_CZ es nl ru

!CONFIG(staticlib) {
    DESTDIR = $${PROJECT_ROOT_PATH}/bin/$${BUILD_FLAG}
}

!defined(PREFIX, var) {
    unix:PREFIX = /usr/local/
    win32:PREFIX = $$(programfiles)
}

#------------------#
# Link modules     #
#------------------#

contains(MODULES, kdiff3) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/3rdparty
    LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/3rdparty/kdiff3)
    LIBS += -lkdiff3
    # QTextCodec in Qt6
    greaterThan(QT_MAJOR_VERSION, 5): QT *= core5compat
}

contains(MODULES, qtsingleapplication) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/3rdparty/include
    LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/3rdparty/qtsingleapplication)
    LIBS += -lqtsingleapplication
}
 
contains(MODULES, addons) {
    MODULES *= basic
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/addons/include
    LIBS += -laddons
    LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/addons)
}

contains(MODULES, edytornc-common) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/src-common \
                   $${PROJECT_ROOT_PATH}/src-common/include \
                   $$shadowed($${PROJECT_ROOT_PATH}/src-common)
    LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/src-common)
    LIBS += -ledytornc-common
}

contains(MODULES, edytornc) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/src/include
#   LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/src)
#   LIBS += -ledytornc
}

contains(MODULES, sfs) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/sfs
#   LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/sfs)
#   LIBS += -lsfs
}

contains(MODULES, basic) {
    INCLUDEPATH += $${PROJECT_ROOT_PATH}/3rdparty/basic
    LIBS += -L$$shadowed($${PROJECT_ROOT_PATH}/3rdparty/basic)
    LIBS += -lbasic
}


#
# function findFiles(dir, basename)
# Returns a list of files with this basename.
# The function searches for dir and subdir recursively.
#
defineReplace(findFiles) {
    dir = $$1
    base_name = $$2

    file_list = $$files($$dir/$$base_name)
    path_list = $$files($$dir/*)

    for(path, path_list) {
        file_list += $$findFiles($$path, $$base_name)
    }

    return ($$file_list)
}


#
# function tsFiles(modulename, locales)
# Returns a list of files with this $${LANG_PATH}/modulename_lang.ts
# example :
# TARGET = bar
# LANG_PATH = lang
# LANG_LIST = pl fr de
# $$tsFiles(foo, ru en) returns lang/foo_ru.ts lang/foo_en.ts
# $$tsFiles(foo) returns lang/foo_pl.ts lang/foo_fr.ts lang/foo_de.ts
# $$tsFiles() returns lang/bar_pl.ts lang/bar_fr.ts lang/bar_de.ts
#
defineReplace(tsFiles) {
    module_name = $$1
    locales = $$2

    !defined(1, var) {
        module_name = $$TARGET
    }

    !defined(2, var) {
        locales = $$LANG_LIST
    }

    for(lang, locales) {
        file_list += $${LANG_PATH}/$${module_name}_$${lang}.ts
    }

    return ($$file_list)
}
