//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_SESSION_H
#define ISSUE_TRACKER_SESSION_H

#include "observer.h"
#include "issue.h"
#include <fstream>
#include <string>

using namespace std;

class Session: public Subject{
private:
    void readIssues();
    void writeIssues();

    vector<Issue> issues;

    bool load;
public:
    Session(bool load = true);
    ~Session();

    const vector<Issue> &getIssues() const {return issues;}

    void sortByStatus(){
        sort(issues.begin(), issues.end(), [this](const Issue &i1, const Issue &i2){
            return i1.getStatus() > i2.getStatus();
        });
    }

    void sortByDescription(){
        sort(issues.begin(), issues.end(), [this](const Issue &i1, const Issue &i2){
            return i1.getDescription() > i2.getDescription();
        });
    }

    void addIssue(const string &description, const string &reporter);
    void removeIssue(const int &index);
    void resolveIssue(const int &index, const string &solver);
};

#endif //ISSUE_TRACKER_SESSION_H
