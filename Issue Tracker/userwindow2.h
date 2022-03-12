//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_USERWINDOW2_H
#define ISSUE_TRACKER_USERWINDOW2_H

#include <QWidget>
#include "observer.h"
#include "session.h"
#include <QListWidget>
#include <QPlainTextEdit>
#include <QPushButton>

QT_BEGIN_NAMESPACE
namespace Ui { class userwindow2; }
QT_END_NAMESPACE

class userwindow2 : public QWidget, public Observer {
Q_OBJECT

public:
    explicit userwindow2(string name, string type, Session &s, QWidget *parent = nullptr);

    ~userwindow2();

    void update() override;

private:
    Ui::userwindow2 *ui;
    string name;
    string type;
    Session &s;

    QListWidget *issuesLw;
    vector<QListWidgetItem*> issuesLwItems;
    QPushButton *removeIssueButton;
    QPushButton *resolveIssueButton;
};

#endif //ISSUE_TRACKER_USERWINDOW2_H
