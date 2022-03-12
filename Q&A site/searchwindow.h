//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_SEARCHWINDOW_H
#define QUESTION_AND_ANSWER_SITE_SEARCHWINDOW_H

#include <QWidget>
#include <QPlainTextEdit>
#include <QListWidget>
#include <QListWidgetItem>
#include <vector>
#include "session.h"
#include "observer.h"

QT_BEGIN_NAMESPACE
namespace Ui { class searchwindow; }
QT_END_NAMESPACE

class searchwindow : public QWidget, public Observer {
Q_OBJECT

public:
    explicit searchwindow(Session &s, QWidget *parent = nullptr);

    ~searchwindow();

    void update() override;

private:
    Ui::searchwindow *ui;
    QPlainTextEdit *searchTextEdit;
    QListWidget *lw;
    vector<QListWidgetItem*> lwItems;
    Session &s;
};

#endif //QUESTION_AND_ANSWER_SITE_SEARCHWINDOW_H
