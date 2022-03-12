//
// Created by Expert on 3/21/2021.
//

#ifndef A45_OCTAVIAAH_TESTS_REPO_H
#define A45_OCTAVIAAH_TESTS_REPO_H

#include "dynamic_vector.h"
#include "repository.h"

class RunTestsRepository
{
public:

    static void testAddEvent();
    static void testRemoveEvent();
    static void testFindEvent();
    static void testUpdateTitleEvent();
    static void testUpdateDescriptionEvent();
    static void testUpdateDateTimeEvent();
    static void testUpdatePeopleEvent();
    static void testUpdateLinkEvent();
    static void run_tests_repo();
};

#endif //A45_OCTAVIAAH_TESTS_REPO_H
