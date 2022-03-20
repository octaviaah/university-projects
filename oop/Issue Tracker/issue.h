//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_ISSUE_H
#define ISSUE_TRACKER_ISSUE_H

#include <string>

using namespace std;

class Issue
{
private:
    string description;
    string status;
    string reporter;
    string solver;
public:
    Issue(const string &description, const string &status, const string &reporter, const string &solver);

    const string getDescription() const { return this->description;}
    const string getStatus() const { return this->status;}
    const string getReporter() const { return this->reporter;}
    const string getSolver() const { return this->solver;}

    void setSolver(string s){
        this->solver = s;
    }
    void setStatus(string s){
        this->status = s;
    }

    const string toString() const{
        return description + " - " + status + " - " + reporter + " - " + solver;
    }
};

#endif //ISSUE_TRACKER_ISSUE_H
