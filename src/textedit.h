/*
 *  Copyright (C) 2023 Nick Egorrov, nicegorov@yandex.ru                                                   *
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

#ifndef TEXTEDIT_H
#define TEXTEDIT_H

#include <QPlainTextEdit>
#include <QObject>
#include <QWidget>

class QDragEnterEvent;
class QDropEvent;
class QString;


/**
 * @brief The TextEdit class is a wrapper for filtering some drag-n-drop events.
 */
class TextEdit : public QPlainTextEdit
{
    Q_OBJECT
public:
    TextEdit(QWidget *parent = nullptr);
    TextEdit(const QString &text, QWidget *parent = nullptr);
    ~TextEdit();

    /*
     * The QPlainTextEdit class already has a drag-n-drop mechanism, but in
     * the case of files, QPlainTextEdit inserts a text representation of url
     * into the edited document. So we add event handlers to filter such events
     * and handle those events in the main window.
     * see https://doc.qt.io/qt-5/dnd.html#dropping
     */
    void dragEnterEvent(QDragEnterEvent *event) override;
    void dropEvent(QDropEvent *event) override;
};

#endif // TEXTEDIT_H
