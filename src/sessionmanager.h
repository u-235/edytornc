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

#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H

#include <QByteArray>
#include <QList>
#include <QObject>
#include <QString>
#include <QStringList>

#include "gcoderinfo.h"

class QSettings;


class SessionManager : public QObject
{
    Q_OBJECT

public:
    enum Limits {
        DEFAULT_FILES_LIMIT = 16,
        MAX_FILES_LIMIT = 32,
        DEFAULT_SESSION_LIMIT = 8,
        MAX_SESSION_LIMIT = 32
    };

    explicit SessionManager(QObject *parent = nullptr);

    bool addSession(const QString &name);
    bool removeSession(const QString &name);
    bool renameSession(const QString &oldName, const QString &newName);
    bool copySession(const QString &from, const QString &to);
    void clearSessions();
    QString currentSession() const;
    bool setCurrentSession(const QString &name);
    QStringList sessionList() const;
    void setSessionList(const QStringList &list);

    int sessionsLimit() const;
    void setSessionsLimit(int lim);

    bool addFile(const QString &filePath);
    void removeFile(const QString &filePath);
    void clearFiles();
    bool documentInfo(GCoderInfo &info) const;
    bool setDocumentInfo(const GCoderInfo &info);
    QList<GCoderInfo> documentInfoList() const;
    void setDocumentInfoList(const QList<GCoderInfo> &infoList);

    int filesLimit() const;
    void setFilesLimit(int lim);

    void load(QSettings *cfg);
    void save(QSettings *cfg) const;

signals:
    void saveRequest();
    void beforeCurrentSessionChanged();
    void currentSessionChanged();
    void sessionListChanged(const QStringList &sessionList);

protected:
    int index(const QString &name) const;
    bool trim(int lim);

    int m_sessionsLimit;
    int m_filesLimit;

    struct SessionItem {
        int index(const QString &filePath) const;
        bool trim(int lim);
        int add(const QString &filePath, int lim);

        QString name;
        QList<GCoderInfo> files;
    };

    QList<SessionItem> m_sessions;
};

#endif // SESSIONMANAGER_H
