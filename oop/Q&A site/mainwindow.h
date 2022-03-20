//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_MAINWINDOW_H
#define QUESTION_AND_ANSWER_SITE_MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class mainwindow; }
QT_END_NAMESPACE

class mainwindow : public QMainWindow {
Q_OBJECT

public:
    explicit mainwindow(QWidget *parent = nullptr);

    ~mainwindow() override;

private:
    Ui::mainwindow *ui;
};

#endif //QUESTION_AND_ANSWER_SITE_MAINWINDOW_H
