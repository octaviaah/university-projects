/********************************************************************************
** Form generated from reading UI file 'user_window.ui'
**
** Created by: Qt User Interface Compiler version 5.15.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_USER_WINDOW_H
#define UI_USER_WINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_user_window
{
public:

    void setupUi(QWidget *user_window)
    {
        if (user_window->objectName().isEmpty())
            user_window->setObjectName(QString::fromUtf8("user_window"));
        user_window->resize(400, 300);

        retranslateUi(user_window);

        QMetaObject::connectSlotsByName(user_window);
    } // setupUi

    void retranslateUi(QWidget *user_window)
    {
        user_window->setWindowTitle(QCoreApplication::translate("user_window", "user_window", nullptr));
    } // retranslateUi

};

namespace Ui {
    class user_window: public Ui_user_window {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_USER_WINDOW_H
