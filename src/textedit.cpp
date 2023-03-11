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

#include <QDragEnterEvent>
#include <QDropEvent>
#include <QMimeData>
#include <QString>
#include <QWidget>

#include "textedit.h" // TextEdit QPlainTextEdit


TextEdit::TextEdit(QWidget *parent) : QPlainTextEdit(parent)
{
}

TextEdit::TextEdit(const QString &text, QWidget *parent) : QPlainTextEdit(text, parent)
{
}

TextEdit::~TextEdit()
{

}

void TextEdit::dragEnterEvent(QDragEnterEvent *event)
{
    if (!event->mimeData()->hasUrls()) {
        QPlainTextEdit::dragEnterEvent(event);
    }
}

void TextEdit::dropEvent(QDropEvent *event)
{
    if (!event->mimeData()->hasUrls()) {
        QPlainTextEdit::dropEvent(event);
    }
}
