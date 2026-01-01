#pragma once

#include <QObject>
#include <QStringList>
#include <QtQml/qqml.h>

class FontsLoader final : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString directory READ directory WRITE setDirectory)
    Q_PROPERTY(QStringList extensions READ extensions WRITE setExtensions)
    Q_PROPERTY(bool recursive READ recursive WRITE setRecursive)

    Q_PROPERTY(QStringList families READ families NOTIFY familiesChanged)

    QML_ELEMENT
    QML_SINGLETON

public:
    explicit FontsLoader(QObject *parent = nullptr);

    QString directory() const;
    void setDirectory(const QString &dir);

    QStringList extensions() const;
    void setExtensions(const QStringList &exts);

    bool recursive() const;
    void setRecursive(bool value);

    Q_INVOKABLE void load();

    QStringList families() const;

signals:
    void familiesChanged();

private:
    QString m_directory;
    QStringList m_extensions;
    bool m_recursive = false;

    QStringList m_families;
};
