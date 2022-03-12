//
// Created by Expert on 3/22/2021.
//

#ifndef A45_OCTAVIAAH_TESTS_SERV_H
#define A45_OCTAVIAAH_TESTS_SERV_H

#include "service.h"

class RunTestsService
{
public:
    static void testAddEventServ();
    static void testRemoveEventServ();
    static void testUpdateEventTitleServ();
    static void testUpdateEventDescriptionServ();
    static void testUpdateEventDateTimeServ();
    static void testUpdateEventPeopleServ();
    static void testUpdateEventLinkServ();
    static void testAddEventEvlist();
    static void testDeleteEventEvlist();
    static void testFilterEventsByMonth();
    static void run_tests_serv();
};

#endif //A45_OCTAVIAAH_TESTS_SERV_H
