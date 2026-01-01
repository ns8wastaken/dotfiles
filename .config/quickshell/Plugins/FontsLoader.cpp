#include "FontsLoader.hpp"

#include <QFontDatabase>
#include <QDirIterator>
#include <QSet>

FontService::FontService(QObject *parent)
    : QObject(parent)
{}

QString FontService::directory() const {
    return m_directory;
}

void FontService::setDirectory(const QString &dir) {
    m_directory = dir;
}

QStringList FontService::extensions() const {
    return m_extensions;
}

void FontService::setExtensions(const QStringList &exts) {
    m_extensions = exts;
}

bool FontService::recursive() const {
    return m_recursive;
}

void FontService::setRecursive(bool value) {
    m_recursive = value;
}

QStringList FontService::families() const {
    return m_families;
}

void FontService::load() {
    QSet<QString> families;

    QStringList filters;
    for (const QString &ext : m_extensions)
        filters << ("*." + ext);

    QDirIterator it(
        m_directory,
        filters,
        QDir::Files,
        m_recursive
            ? QDirIterator::Subdirectories
            : QDirIterator::NoIteratorFlags
    );

    while (it.hasNext()) {
        const QString path = it.next();

        const int id = QFontDatabase::addApplicationFont(path);
        if (id < 0)
            continue;

        const auto fams = QFontDatabase::applicationFontFamilies(id);

        for (const QString &f : fams)
            families.insert(f);
    }

    m_families = QStringList(families.begin(), families.end());
    m_families.sort();

    emit familiesChanged();
}
