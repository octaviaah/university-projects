//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_USER_H
#define ISSUE_TRACKER_USER_H

#include <string>

using namespace std;

class User
{
private:
    string name;
    string type;
public:
    User(const string &name, const string &type);

    const string getName() const { return this->name;}
    const string getType() const { return this->type;}

    const string toString() const{
        return name + " - " + type;
    }
};


#endif //ISSUE_TRACKER_USER_H
