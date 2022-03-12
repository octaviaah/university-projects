//
// Created by Expert on 6/20/2021.
//

#include "session.h"
#include <iostream>

Session::Session(bool load): load(load) {
    if (load)
    {
        readIssues();
    }
}

Session::~Session() noexcept {
    if (load){
        writeIssues();
    }
}

void Session::readIssues() {
    ifstream f("D:/facultate/oop/issue tracker/issues.txt");
    string description;
    string status;
    string reporter;
    string solver;
    string delimiter;

    while (getline(f, description, ';') && getline(f, status, ';') && getline(f, reporter, ';') && getline(f, solver, '\n')){
        issues.emplace_back(Issue(description, status, reporter, solver));
    }
    sortByStatus();
    sortByDescription();
}

void Session::writeIssues() {
    ofstream fout("D:/facultate/oop/issue tracker/issues.txt");
    for (const auto &i: issues){
        fout << i.getDescription() << ';' << i.getStatus() << ';' << i.getReporter() << ";" << i.getSolver() << endl;
    }
}

void Session::addIssue(const string &description, const string &reporter) {
    /*
     * adds issue to the list of issues with the given description and reporter
     * if the description is empty, an exception will be thrown
     * if the description matches one in the list, and exception will be thrown
     */
    if (description.empty()) throw std::runtime_error("Description can't be empty!");
    for (const auto i: issues)
        if (i.getDescription() == description)
            throw std::runtime_error("There is already an issue with the same description!");
    issues.emplace_back(Issue(description, "open", reporter, " "));
    this->notify();
}

void Session::removeIssue(const int &index) {
    if (issues[index].getStatus() == "open") throw std::runtime_error("Open issues can't be removed!");
    issues.erase(issues.begin() + index);
    this->notify();
}

void Session::resolveIssue(const int &index, const string& solver) {
    /*
     * resolves an open issue and the name of the solver is added to the issue
     * if the issue is closed, an exception will be thrown
     */
    if (issues[index].getStatus() == "closed") throw std::runtime_error("Closed issues can't be solved!");
    issues[index].setSolver(solver);
    issues[index].setStatus("closed");
    this->notify();
}