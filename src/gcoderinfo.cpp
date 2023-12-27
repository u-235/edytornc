/*
 *  Copyright (C) 2023 Nick Egorrov, nicegorov@yandex.ru
 *
 *  This file is part of EdytorNC.
 *
 *  EdytorNC is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QSettings>    // for QSettings
#include <QVariant>     // for QVariant

#include "gcoderinfo.h"


#define INFO_TYPE_GCODER   "GCodeEditor"


#define CFG_KEY_INFO_TYPE           "Type"
#define CFG_KEY_INFO_CURSOR_POS     "CursorPosition"
#define CFG_KEY_INFO_FILE_PATH      "FilePath"
#define CFG_KEY_INFO_GEOMETRY       "Geometry"
#define CFG_KEY_INFO_HIGHLIGHT_MODE "HighlightMode"
#define CFG_KEY_INFO_MAXIMIZED      "Maximized"
#define CFG_KEY_INFO_READ_ONLY      "ReadOnly"


void GCoderInfo::load(QSettings *cfg, const GCoderInfo &defaultOptions)
{
    if (cfg->value(CFG_KEY_INFO_TYPE).toString() == INFO_TYPE_GCODER) {
        cursorPos  = cfg->value(CFG_KEY_INFO_CURSOR_POS, defaultOptions.cursorPos).toInt();
        filePath  = cfg->value(CFG_KEY_INFO_FILE_PATH, defaultOptions.filePath).toString();
        geometry  = cfg->value(CFG_KEY_INFO_GEOMETRY, defaultOptions.geometry).toByteArray();
        highlightMode  = cfg->value(CFG_KEY_INFO_HIGHLIGHT_MODE, defaultOptions.highlightMode).toInt();
        maximized  = cfg->value(CFG_KEY_INFO_MAXIMIZED, defaultOptions.maximized).toBool();
        readOnly  = cfg->value(CFG_KEY_INFO_READ_ONLY, defaultOptions.readOnly).toBool();
    }
}

void GCoderInfo::save(QSettings *cfg) const
{
    cfg->setValue(CFG_KEY_INFO_TYPE, INFO_TYPE_GCODER);
    cfg->setValue(CFG_KEY_INFO_CURSOR_POS, cursorPos);
    cfg->setValue(CFG_KEY_INFO_FILE_PATH, filePath);
    cfg->setValue(CFG_KEY_INFO_GEOMETRY, geometry);
    cfg->setValue(CFG_KEY_INFO_HIGHLIGHT_MODE, highlightMode);
    cfg->setValue(CFG_KEY_INFO_MAXIMIZED, maximized);
    cfg->setValue(CFG_KEY_INFO_READ_ONLY, readOnly);
}
