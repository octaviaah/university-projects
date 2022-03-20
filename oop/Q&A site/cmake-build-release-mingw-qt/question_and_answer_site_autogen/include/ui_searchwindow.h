/********************************************************************************
** Form generated from reading UI file 'searchwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.15.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SEARCHWINDOW_H
#define UI_SEARCHWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_searchwindow
{
public:

    void setupUi(QWidget *searchwindow)
    {
        if (searchwindow->objectName().isEmpty())
            searchwindow->setObjectName(QString::fromUtf8("searchwindow"));
        searchwindow->resize(400, 300);

        retranslateUi(searchwindow);

        QMetaObject::connectSlotsByName(searchwindow);
    } // setupUi

    void retranslateUi(QWidget *searchwindow)
    {
        searchwindow->setWindowTitle(QCoreApplication::translate("searchwindow", "searchwindow", nullptr));
    } // retranslateUi

};

namespace Ui {
    class searchwindow: public Ui_searchwindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SEARCHWINDOW_H
