#include <QObject>
#include <QtQml/qqml.h>

class TestPlug : public QObject {
    Q_OBJECT
    Q_PROPERTY(double testProperty READ testProperty)
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit TestPlug(QObject* parent = nullptr);
    double testProperty() const;
};
