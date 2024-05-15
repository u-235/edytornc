/***************************************************************************
 *   Copyright (C) 2006-2018 by Artur Kozioł                               *
 *   artkoz78@gmail.com                                                    *
 *                                                                         *
 *   This file is part of EdytorNC.                                        *
 *                                                                         *
 *   EdytorNC is free software; you can redistribute it and/or modify      *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#ifndef SESSIONDIALOG_H
#define SESSIONDIALOG_H

#include <QDialog>      // for QDialog
#include <QObject>      // for Q_OBJECT, slots
#include <QString>      // for QString
#include <QStringList>  // for QStringList

class QWidget;

class SessionManager;

#include "ui_sessiondialog.h"  // for Ui::SessionDialog


class SessionDialog: public QDialog, private Ui::SessionDialog
{
	Q_OBJECT

public:
	explicit SessionDialog(QWidget* parent, SessionManager* sessions);
	~SessionDialog();

private slots:
	void updateSessionList(const QStringList& list);
	void newButtonClicked();
	void renameButtonClicked();
	void deleteButtonClicked();
	void cloneButtonClicked();
	void switchButtonClicked();
	void sessionListItemSelectionChanged();

private:
	SessionManager* m_sessions;
};

#endif // SESSIONDIALOG_H
