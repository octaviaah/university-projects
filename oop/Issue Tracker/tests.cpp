//
// Created by Expert on 6/20/2021.
//

#include "tests.h"
#include "session.h"
#include <cassert>

void Testing::test_add() {
    Session s(false);
    assert(s.getIssues().size() == 0);
    bool ok = false;
    try{
        s.addIssue("", "Andrei");
    }
    catch(std::runtime_error &e){
        ok = true;
    }
    assert(ok == true);
    s.addIssue("hello", "Andrei");
    assert(s.getIssues().size() == 1);
    assert(s.getIssues()[0].getDescription() == "hello");
    assert(s.getIssues()[0].getStatus() == "open");
    assert(s.getIssues()[0].getReporter() == "Andrei");
    assert(s.getIssues()[0].getSolver() == " ");
    ok = false;
    try{
        s.addIssue("hello", "Mihai");
    }
    catch(std::runtime_error &e){
        ok = true;
    }
    assert(ok == true);
}

void Testing::test_update() {
    Session s(false);
    assert(s.getIssues().size() == 0);
    s.addIssue("hello", "Andrei");
    s.addIssue("mmmmm", "Maria");
    assert(s.getIssues().size() == 2);
    s.resolveIssue(0, "Mihai");
    assert(s.getIssues()[0].getStatus() == "closed");
    assert(s.getIssues()[0].getSolver() == "Mihai");
    bool ok = false;
    try{
        s.resolveIssue(0, "Paul");
    }
    catch(std::runtime_error &e){
        ok = true;
    }
    assert(ok == true);
}