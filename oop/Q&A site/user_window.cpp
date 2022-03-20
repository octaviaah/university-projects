//
// Created by Expert on 6/19/2021.
//

// You may need to build the project (run Qt uic code generator) to get "ui_user_window.h" resolved

#include "user_window.h"
#include "ui_user_window.h"
#include <iostream>

using namespace std;

user_window::user_window(string name, Session &s, QWidget *parent) :
        QWidget(parent), ui(new Ui::user_window), name(name), s(s) {
    ui->setupUi(this);
    s.registerObserver(this);
    this->setWindowTitle(name.c_str());
    this->setFixedSize(800, 500);

    questionsLw = new QListWidget(this);
    questionsLw->setGeometry(0, 0, 500, 200);
    for(const auto &q: s.getQuestions())
        questionsLwItems.emplace_back(new QListWidgetItem(q.toString().c_str(), questionsLw));

    newQuestionText = new QPlainTextEdit(this);
    newQuestionText->setPlaceholderText("Question text");
    newQuestionText->setGeometry(0, 200, 250, 250);

    addQuestionButton = new QPushButton(this);
    addQuestionButton->setText("Add question");
    addQuestionButton->setGeometry(250, 200, 250, 50);

    connect(addQuestionButton, &QPushButton::clicked, this, [this](){
        string questionText = this->newQuestionText->toPlainText().toUtf8().constData();
        try{
            this->s.addQuestion(questionText, this->name);
        }catch (std::runtime_error &e) {
            cout << e.what() << endl;
        }
    });

    answersLw = new QListWidget(this);
    answersLw->setGeometry(500, 0, 300, 300);

    connect(questionsLw, &QListWidget::clicked, this, [this](){
        QModelIndex index = this->questionsLw->currentIndex();
        this->answersLw->clear();
        this->answersLwItems.clear();

        for (const auto &ans: this->s.getAnswersForQuestion(this->s.getQuestions()[index.row()].getId())){
            answersLwItems.push_back(new QListWidgetItem(ans.toString().c_str(), this->answersLw));
            if (ans.getCreator() == this->name){
                answersLwItems.back()->setBackground(QBrush(QColor(Qt::GlobalColor::yellow)));
            }
        }
    });

    addAnswerButton = new QPushButton(this);
    addAnswerButton->setText("Add answer");
    addAnswerButton->setGeometry(250, 250, 250, 50);

    newAnswerText = new QPlainTextEdit(this);
    newAnswerText->setPlaceholderText("Answer text");
    newAnswerText->setGeometry(250, 300, 550, 150);

    connect(addAnswerButton, &QPushButton::clicked, this, [this](){
       QModelIndex index = this->questionsLw->currentIndex();
       string answerText = this->newAnswerText->toPlainText().toUtf8().constData();
       int questionId = this->s.getQuestions()[index.row()].getId();
       try{
           this->s.addAnswer(questionId, answerText, this->name);
       }
       catch (std::runtime_error &e){
           cout << e.what() << endl;
       }
    });
}

user_window::~user_window() {
    delete ui;
    s.unregisterObserver(this);
}

void user_window::update() {
    questionsLw->clear();
    questionsLwItems.clear();
    for (const auto &q:s.getQuestions()){
        questionsLwItems.emplace_back(new QListWidgetItem(q.toString().c_str(), questionsLw));
    }
}
