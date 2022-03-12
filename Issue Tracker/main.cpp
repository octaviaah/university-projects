#include <iostream>
#include <QApplication>
#include "session.h"
#include "tests.h"
#include "userwindow2.h"
#include "userwindow.h"


int main(int argc, char* argv[]) {
    QApplication a(argc, argv);
    Session s;
    vector<userwindow*> testers;
    vector<userwindow2*> programmers;
    ifstream f("D:/facultate/oop/issue tracker/users.txt");
    string name;
    string type;

    while (f >> name >> type){
        if (type == "tester")
            testers.emplace_back(new userwindow(name, type, s));
        else programmers.emplace_back(new userwindow2(name, type, s));
    }
    Testing t;
    t.test_add();
    t.test_update();

    for (const auto &tester: testers) {
        tester->show();
    }

    for (const auto &programmer: programmers) {
        programmer->show();
    }

    return a.exec();
}
