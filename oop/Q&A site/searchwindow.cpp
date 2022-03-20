//
// Created by Expert on 6/19/2021.
//

// You may need to build the project (run Qt uic code generator) to get "ui_searchwindow.h" resolved

#include "searchwindow.h"
#include "ui_searchwindow.h"

searchwindow::searchwindow(Session &s, QWidget *parent) :
        QWidget(parent), ui(new Ui::searchwindow), s(s) {
    ui->setupUi(this);
    s.registerObserver(this);
    this->setWindowTitle("Search a question");
    this->setFixedSize(500, 500);

    searchTextEdit = new QPlainTextEdit(this);
    searchTextEdit->setGeometry(0, 0, 300, 30);

    lw = new QListWidget(this);
    lw->setGeometry(0, 50, 500, 400);
    for(const auto&q: s.getQuestions())
        lwItems.emplace_back(new QListWidgetItem(q.toString().c_str(), lw));

    connect(searchTextEdit, &QPlainTextEdit::textChanged, this, [this](){
       this->lw->clear();
       this->lwItems.clear();
       vector<Question> v;
       string input = this->searchTextEdit->toPlainText().toUtf8().constData();
       for(int i=0; i<this->s.sortByMatchingCharacters(input).size(); i++){
           auto q = this->s.sortByMatchingCharacters(input)[i];
           if (this->s.matchingCharacters(q.getText(), input) >= input.length())
               v.push_back(q);
       }
       for (int i = 0; i < v.size(); i++)
       {
           if(i==0) {
               auto q = v[i];
               lwItems.emplace_back(new QListWidgetItem(q.toString().c_str(), lw));

               for (int j = 0; j < this->s.getTopThreeAnswers(q.getId()).size(); j++) {
                   string itemStr = '\t' + this->s.getTopThreeAnswers(q.getId())[j].toString();
                   lwItems.emplace_back(new QListWidgetItem(itemStr.c_str(), lw));
               }
           }
           else{
               auto q = v[i];
               lwItems.emplace_back(new QListWidgetItem(q.toString().c_str(), lw));
           }
       }
    });
}

searchwindow::~searchwindow() {
    delete ui;
    s.unregisterObserver(this);
}

void searchwindow::update(){
    lw->clear();
    lwItems.clear();
    for (const auto &q: s.getQuestions())
        lwItems.emplace_back((new QListWidgetItem(q.toString().c_str(), lw)));
}