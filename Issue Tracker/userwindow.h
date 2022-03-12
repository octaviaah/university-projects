//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_USERWINDOW_H
#define ISSUE_TRACKER_USERWINDOW_H

#include <QWidget>
#include "observer.h"
#include "session.h"
#include <QListWidget>
#include <QPlainTextEdit>
#include <QPushButton>

QT_BEGIN_NAMESPACE
namespace Ui { class userwindow; }
QT_END_NAMESPACE

class userwindow : public QWidget, public Observer {
    Q_OBJECT

public:
    explicit userwindow(string name, string type, Session &s, QWidget *parent = nullptr);

    ~userwindow();

    void update() override;

private:
    Ui::userwindow *ui;
    string name;
    string type;
    Session &s;

    QListWidget *issuesLw;
    vector<QListWidgetItem*> issuesLwItems;
    QPlainTextEdit *newIssueText;
    QPushButton *addIssueButton;
    QPushButton *removeIssueButton;
};

#endif //ISSUE_TRACKER_USERWINDOW_H
