#include "TestPlug.hpp"

TestPlug::TestPlug(QObject* parent)
  : QObject(parent)
{}

double TestPlug::testProperty() const {
    return 3.14159265;
}
