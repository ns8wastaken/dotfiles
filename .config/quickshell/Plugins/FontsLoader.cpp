#include "FontsLoader.hpp"

#include <QFontDatabase>
#include <QDirIterator>
#include <QSet>

FontsLoader::FontsLoader(QObject *parent)
    : QObject(parent)
{}

QString FontsLoader::directory() const {
    return m_directory;
}

void FontsLoader::setDirectory(const QString &dir) {
    m_directory = dir;
}

QStringList FontsLoader::extensions() const {
    return m_extensions;
}

void FontsLoader::setExtensions(const QStringList &exts) {
    m_extensions = exts;
}

bool FontsLoader::recursive() const {
    return m_recursive;
}

void FontsLoader::setRecursive(bool value) {
    m_recursive = value;
}

QStringList FontsLoader::families() const {
    return m_families;
}

void FontsLoader::load() {
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
