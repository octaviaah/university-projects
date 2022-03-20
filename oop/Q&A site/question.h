//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_QUESTION_H
#define QUESTION_AND_ANSWER_SITE_QUESTION_H

#include <string>

using namespace std;

class Question
{
private:
    int id;
    string text;
    string creator;
public:
    Question(const int &id, const string &text, const string &creator);

    const int getId() const { return this->id;}
    const string getText() const { return this->text;}
    const string getCreator() const { return this->creator;}

    const string toString() const{
        return to_string(id) + " - " + text + " - " + creator;
    }
};

#endif //QUESTION_AND_ANSWER_SITE_QUESTION_H
