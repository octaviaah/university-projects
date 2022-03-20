//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_REPOSITORY_H
#define QUESTION_AND_ANSWER_SITE_REPOSITORY_H

#include "observer.h"
#include "user_window.h"

class Repository{
private:
    vector<user_window*> users;
public:
    Repository(Session &s){
        ifstream f("D:/facultate/oop/question and answer site/users.txt");
        string username;

        while (f >> username){
            cout << username;
            users.emplace_back(new user_window(username, s));
        }
    }
    const vector<user_window*> &getUsers() const { return users;}
};

#endif //QUESTION_AND_ANSWER_SITE_REPOSITORY_H
