//
// Created by Expert on 6/20/2021.
//

// You may need to build the project (run Qt uic code generator) to get "ui_userwindow2.h" resolved

#include "userwindow2.h"
#include "ui_userwindow2.h"
#include <iostream>

userwindow2::userwindow2(string name, string type, Session &s, QWidget *parent) :
        QWidget(parent), ui(new Ui::userwindow2), name(name), type(type), s(s) {
    ui->setupUi(this);

    s.registerObserver(this);
    string title = name + " - " + type;
    this->setWindowTitle(title.c_str());
    this->setFixedSize(500, 450);

    issuesLw = new QListWidget(this);
    issuesLw->setGeometry(0, 0, 500, 200);
    for(const auto &i: s.getIssues())
        issuesLwItems.emplace_back(new QListWidgetItem(i.toString().c_str(), issuesLw));

    removeIssueButton = new QPushButton(this);
    removeIssueButton->setText("Remove issue");
    removeIssueButton->setGeometry(120, 250, 250, 50);

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

    resolveIssueButton = new QPushButton(this);
    resolveIssueButton->setText("Resolve issue");
    resolveIssueButton->setGeometry(120, 200, 250, 50);
    resolveIssueButton->setVisible(false);

    QModelIndex index = this->issuesLw->currentIndex();
    QItemSelectionModel *i = this->issuesLw->selectionModel();
    connect(i, &QItemSelectionModel::selectionChanged, this, [this](){
        resolveIssueButton->setVisible(true);
        connect(resolveIssueButton, &QPushButton::clicked, this, [this](){
            QModelIndex index = this->issuesLw->currentIndex();
            int i = index.row();
            try{
                this->s.resolveIssue(i, this->name);
            }
            catch (std::runtime_error &e){
                cout << e.what() << endl;
            }
        });
    });
}

userwindow2::~userwindow2() {
    delete ui;
    s.unregisterObserver(this);
}

void userwindow2::update() {
    issuesLw->clear();
    issuesLwItems.clear();
    for (const auto &i:s.getIssues()){
        issuesLwItems.emplace_back(new QListWidgetItem(i.toString().c_str(), issuesLw));
    }
}
