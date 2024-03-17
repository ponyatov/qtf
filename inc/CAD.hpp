#pragma once

#include "main.hpp"

class CAD : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible)

   private:
    bool visible;
    QString name;

   public:
    CAD(QString name = "", QObject* pobj = NULL)
        : QObject(pobj), name(name), visible(false) {}
    bool isVisible() { return visible; }
    void setVisible(bool visible) { this->visible = visible; }

   signals:
    void sync();

   public slots:
    void slot() { qDebug() << sender()->objectName(); }
};
