//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_USER_WINDOW_H
#define QUESTION_AND_ANSWER_SITE_USER_WINDOW_H

#include <QWidget>
#include "Observer.h"
#include <QListWidget>
#include <QListWidgetItem>
#include "session.h"
#include <QPushButton>
#include <QPlainTextEdit>

QT_BEGIN_NAMESPACE
namespace Ui { class user_window; }
QT_END_NAMESPACE

class user_window : public QWidget, public Observer {
    Q_OBJECT

public:
    explicit user_window(string name, Session &s, QWidget *parent = nullptr);
    ~user_window();
    void update() override;

private:
    Ui::user_window *ui;
    string name;
    Session &s;

    QListWidget *questionsLw;
    vector<QListWidgetItem*> questionsLwItems;
    QPushButton *addQuestionButton;
    QPlainTextEdit *newQuestionText;

    QListWidget *answersLw;
    vector<QListWidgetItem*> answersLwItems;
    QPlainTextEdit *newAnswerText;
    QPushButton *addAnswerButton;

};

#endif //QUESTION_AND_ANSWER_SITE_USER_WINDOW_H
