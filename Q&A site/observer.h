//
// Created by Expert on 6/19/2021.
//

#ifndef QUESTION_AND_ANSWER_SITE_OBSERVER_H
#define QUESTION_AND_ANSWER_SITE_OBSERVER_H

#include <vector>
#include <algorithm>

using namespace std;

class Observer{
public:
    virtual void update() = 0;
    virtual ~Observer() {}
};

class Subject{
private:
    vector<Observer*> observers;
public:
    virtual ~Subject() {}
    void registerObserver(Observer* obs)
    {
        this->observers.push_back(obs);
    }
    void unregisterObserver(Observer* obs)
    {
        this->observers.erase(find(this->observers.begin(), this->observers.end(), obs));
    }
    void notify(){
        for (auto obs: observers)
            obs->update();
    }
};

#endif //QUESTION_AND_ANSWER_SITE_OBSERVER_H
