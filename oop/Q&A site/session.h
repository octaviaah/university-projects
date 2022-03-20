//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_SESSION_H
#define QUESTION_AND_ANSWER_SITE_SESSION_H

#include "observer.h"
#include "question.h"
#include "answer.h"
#include <fstream>
#include <string>

using namespace std;

class Session: public Subject{
private:
    void readQuestions();
    void readAnswers();
    void writeQuestions();
    void writeAnswers();

    vector<Question> questions;
    vector<Answer> answers;

    bool load;
public:
    Session(bool load = true);
    ~Session();

    const vector<Question> &getQuestions() const {return questions;}
    const vector<Answer> &getAnswers() const {return answers;}

    //descending by no of answers
    int getCountAnswersForQuestion(int questionId){
        int count = 0;
        for (const auto &ans: answers)
            if (ans.getQuestionId() == questionId) count++;
        return count;
    }
    void sortQuestions()
    {
        sort(questions.begin(), questions.end(), [this](const Question &q1, const Question &q2){
            return getCountAnswersForQuestion(q1.getId()) > getCountAnswersForQuestion(q2.getId());
        });
    }
    vector<Answer> getAnswersForQuestion(int questionId);

    int matchingCharacters(string s1, string s2){
        int len = s1.size() > s2.size() ? s2.size() : s1.size();
        int count = 0;
        int i;
        for (i = 0; i < len; i++)
            if (s1[i] == s2[i]) count++;
        return count;
    }

    vector <Question> sortByMatchingCharacters(string input);

    void addQuestion(const string&text, const string &creator);
    void addAnswer(const int &questionId, const string &text, const string &creator);

    //get top 3 answers for a given question
    vector<Answer> getTopThreeAnswers(int questionId);
};

#endif //QUESTION_AND_ANSWER_SITE_SESSION_H
