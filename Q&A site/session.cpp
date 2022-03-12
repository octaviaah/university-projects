//
// Created by Expert on 6/19/2021.
//

#include "session.h"
#include <iostream>

Session::Session(bool load): load(load) {
    if (load)
    {
        readAnswers();
        readQuestions();
    }
}

Session::~Session() noexcept {
    if (load){
        writeAnswers();
        writeQuestions();
    }
}

void Session::readQuestions() {
    ifstream f("D:/facultate/oop/question and answer site/questions.txt");
    int id;
    string text;
    string creator;

    while (f >> id && getline(f, text, ';') && getline(f, text, ';') && f >> creator){
        questions.emplace_back(Question(id, text, creator));
    }
    sortQuestions();
}

void Session::readAnswers() {
    ifstream f("D:/facultate/oop/question and answer site/answers.txt");
    int id;
    int questionId;
    string creator;
    string text;
    int votes;

    while (f >> id >> questionId && getline(f, creator, ';') && getline(f, creator, ';') && getline(f, text, ';') && f >> votes) {
        answers.emplace_back(Answer(id, questionId, creator, text, votes));
    }
}

void Session::writeQuestions() {
    ofstream fout("D:/facultate/oop/question and answer site/questions.txt");
    for (const auto &q: questions){
        fout << q.getId() << ';' << q.getText() << ';' << q.getCreator() << endl;
    }
}

void Session::writeAnswers() {
    ofstream fout("D:/facultate/oop/question and answer site/answers.txt");
    for (const auto &a: answers){
        fout << a.getId() << " " << a.getQuestionId() << ";" << a.getCreator() << ";" << a.getText() << ";" << a.getVotes() << endl;
    }
}

vector<Answer> Session::getAnswersForQuestion(int questionId) {
    vector<Answer> v;
    for (const auto &a: this->answers){
        if (a.getQuestionId() == questionId)
            v.push_back(a);
    }
    return v;
}

vector<Answer> Session::getTopThreeAnswers(int questionId) {
    vector<Answer> v = this->getAnswersForQuestion(questionId);

    if (v.size() > 3)
        v.erase(v.begin() + 3, v.end());

    sort(v.begin(), v.end(), [](const Answer &a1, const Answer &a2){
        return a1.getVotes() > a2.getVotes();
    });
    return v;
}

void Session::addAnswer(const int &questionId, const string &text, const string &creator) {
    if (text.empty()) throw std::runtime_error("Answer text is empty!");
    answers.emplace_back(Answer(answers.size(), questionId, creator, text, 0));
    this->notify();
}

void Session::addQuestion(const string &text, const string &creator) {
    if (text.empty()) throw std::runtime_error("Question text is empty!");
    questions.emplace_back(Question(questions.size(), text, creator));
    this->notify();
}

vector<Question> Session::sortByMatchingCharacters(string input) {
    vector<Question> v = questions;
    sort(v.begin(), v.end(), [this, input](const Question &q1, const Question &q2){
        return matchingCharacters(input, q1.getText()) > matchingCharacters(input, q2.getText());
    });
    return v;
}