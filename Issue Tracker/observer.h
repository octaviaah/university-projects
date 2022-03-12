//
// Created by Expert on 6/20/2021.
//

#ifndef ISSUE_TRACKER_OBSERVER_H
#define ISSUE_TRACKER_OBSERVER_H

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

#endif //ISSUE_TRACKER_OBSERVER_H
