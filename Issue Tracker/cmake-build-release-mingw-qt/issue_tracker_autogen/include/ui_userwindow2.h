/********************************************************************************
** Form generated from reading UI file 'userwindow2.ui'
**
** Created by: Qt User Interface Compiler version 5.15.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_USERWINDOW2_H
#define UI_USERWINDOW2_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_userwindow2
{
public:

    void setupUi(QWidget *userwindow2)
    {
        if (userwindow2->objectName().isEmpty())
            userwindow2->setObjectName(QString::fromUtf8("userwindow2"));
        userwindow2->resize(400, 300);

        retranslateUi(userwindow2);

        QMetaObject::connectSlotsByName(userwindow2);
    } // setupUi

    void retranslateUi(QWidget *userwindow2)
    {
        userwindow2->setWindowTitle(QCoreApplication::translate("userwindow2", "userwindow2", nullptr));
    } // retranslateUi

};

namespace Ui {
    class userwindow2: public Ui_userwindow2 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_USERWINDOW2_H
