/*
 *  Copyright (C) 2006-2018 by Artur Kozioł, artkoz78@gmail.com
 *  Copyright (C) 2024 Nick Egorrov, nicegorov@yandex.ru
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

#ifndef GCODERWIDGETPROPERTIES_H
#define GCODERWIDGETPROPERTIES_H

#include <QString>
#include <QStringList>

class QSettings;


enum WindowModeFlags {
    TABBED_MODE = 0x01,
    SHOW_FILENAME = 0x02,
    SHOW_FILEPATH = 0x04,
    SHOW_PROGTITLE = 0x08
};


struct GCoderWidgetProperties {
    QString lastDir;
    bool intCapsLock;
    bool syntaxH;
    bool underlineChanges;
    int windowMode;
    bool clearUndoHistory;
    bool clearUnderlineHistory;
    bool editorToolTips;
    QStringList extensions;
    QString saveExtension;
    QString saveDirectory;
    int defaultHighlightMode;
    bool guessFileNameByProgNum;
    bool changeDateInComment;

    GCoderWidgetProperties();
    ~GCoderWidgetProperties();
    void load(QSettings *cfg);
    void save(QSettings *cfg) const;
};

#endif // GCODERWIDGETPROPERTIES_H
