#pragma once

#include "main.hpp"

class CAD : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible)

   private:
    bool visible;

   public:
    CAD(QObject* pobj = NULL) : QObject(pobj), visible(false) {}
    bool isVisible() { return visible; }
    void setVisible(bool visible) { this->visible = visible; }
};
