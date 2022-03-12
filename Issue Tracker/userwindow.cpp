//
// Created by Expert on 6/20/2021.
//

// You may need to build the project (run Qt uic code generator) to get "ui_userwindow.h" resolved

#include "userwindow.h"
#include "ui_userwindow.h"
#include <iostream>

userwindow::userwindow(string name, string type, Session &s, QWidget *parent) :
        QWidget(parent), ui(new Ui::userwindow), name(name), type(type), s(s) {
    ui->setupUi(this);

    s.registerObserver(this);
    string title = name + " - " + type;
    this->setWindowTitle(title.c_str());
    this->setFixedSize(500, 450);

    issuesLw = new QListWidget(this);
    issuesLw->setGeometry(0, 0, 500, 200);
    for(const auto &i: s.getIssues())
        issuesLwItems.emplace_back(new QListWidgetItem(i.toString().c_str(), issuesLw));

    newIssueText = new QPlainTextEdit(this);
    newIssueText->setPlaceholderText("Write your issue here");
    newIssueText->setGeometry(0, 200, 250, 250);

    addIssueButton = new QPushButton(this);
    addIssueButton->setText("Add issue");
    addIssueButton->setGeometry(250, 200, 250, 50);

    connect(addIssueButton, &QPushButton::clicked, this, [this](){
        string issueDesc = this->newIssueText->toPlainText().toUtf8().constData();
        try{
            this->s.addIssue(issueDesc, this->name);
        }
        catch (std::runtime_error &e){
            cout << e.what() << endl;
        }
    });

    removeIssueButton = new QPushButton(this);
    removeIssueButton->setText("Remove issue");
    removeIssueButton->setGeometry(250, 250, 250, 50);

    connect(removeIssueButton, &QPushButton::clicked, this, [this](){
        QModelIndex index = this->issuesLw->currentIndex();
        int i = index.row();
        try{
            this->s.removeIssue(i);
        }
        catch (std::runtime_error &e){
            cout << e.what() << endl;
        }
    });

}

userwindow::~userwindow() {
    delete ui;
    s.unregisterObserver(this);
}

void userwindow::update() {
    issuesLw->clear();
    issuesLwItems.clear();
    for (const auto &i:s.getIssues()){
        issuesLwItems.emplace_back(new QListWidgetItem(i.toString().c_str(), issuesLw));
    }
}
