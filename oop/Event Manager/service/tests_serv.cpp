//
// Created by Expert on 4/10/2021.
//

#include "tests_serv.h"
#include <cassert>
#include <iostream>

using namespace std;

void RunTestsService::testAddEventServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    struct tm date;
    date.tm_min = 25; date.tm_hour = 22; date.tm_year = 2021; date.tm_mon = 7; date.tm_mday = 31;
    int result = serv.add_event_serv("party", "cool party", date, 55, "www.party.com");
    assert (result == 1);
    assert (serv.get_repository().get_events().size() == 11);
    assert(serv.get_repository().get_events()[10].get_title() == "party");
    result = serv.add_event_serv("Jane's dream", "mdsfhsd", date, 222, "ijdksdh");
    assert (result == -1);
    result = serv.add_event_serv("", "jfisd", date, 222, "fsdifhd");
    assert(result == -2);
}

void RunTestsService::testRemoveEventServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    int result = serv.delete_event_serv("Virtual music!");
    assert (result == 1);
    assert(serv.get_repository().get_events().size() == 9);
    assert(serv.get_repository().get_events()[2].get_title() == "Spring Sing-Open House");
    result = serv.delete_event_serv("Virtual music!");
    assert(result == -1);
    result = serv.delete_event_serv("");
    assert(result == -2);
}

void RunTestsService::testUpdateEventTitleServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    int result = serv.update_event_title_serv("Virtual music!", "Not so virtual music");
    assert (result == 1);
    assert(serv.get_repository().get_events()[2].get_title() == "Not so virtual music");
    result = serv.update_event_title_serv("hfskjfh", "jfidshdd");
    assert(result == -1);
    result = serv.update_event_title_serv("Jane's dream", "");
    assert(result == -2);
    result = serv.update_event_title_serv("Jane's dream", "Individual cooking 101");
    assert (result == -1);
}

void RunTestsService::testUpdateEventDescriptionServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    int result = serv.update_event_description_serv("Virtual music!", "karaoke and dance");
    assert (result == 1);
    assert(serv.get_repository().get_events()[2].get_description() == "karaoke and dance");
    result = serv.update_event_description_serv("hfskjfh", "jfidshdd");
    assert(result == -1);
    result = serv.update_event_description_serv("Jane's dream", "");
    assert(result == -2);
}

void RunTestsService::testUpdateEventDateTimeServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    struct tm date;
    date.tm_mday = 5; date.tm_mon = 2; date.tm_year = 2022; date.tm_hour = 18; date.tm_min = 44;
    int result = serv.update_event_date_time_serv("Virtual music!", date);
    assert (result == 1);
    assert(serv.get_repository().get_events()[2].get_date_time().tm_mday == 5);
    assert(serv.get_repository().get_events()[2].get_date_time().tm_mon == 2);
    assert(serv.get_repository().get_events()[2].get_date_time().tm_hour == 18);
    assert(serv.get_repository().get_events()[2].get_date_time().tm_year == 2022);
    assert(serv.get_repository().get_events()[2].get_date_time().tm_min == 44);
    result = serv.update_event_date_time_serv("hfskjfh", date);
    assert(result == -1);
    date.tm_mon = 4; date.tm_year = 2021; date.tm_mday = 31; date.tm_hour = 22; date.tm_min = 14;
    result = serv.update_event_date_time_serv("Jane's dream", date);
    assert(result == -2);
}

void RunTestsService::testUpdateEventPeopleServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    int result = serv.update_event_people_serv("Virtual music!", 55555);
    assert (result == 1);
    assert(serv.get_repository().get_events()[2].get_people() == 55555);
    result = serv.update_event_people_serv("hfskjfh", 2453);
    assert(result == -1);
    result = serv.update_event_people_serv("Jane's dream", -9);
    assert(result == -2);
}

void RunTestsService::testUpdateEventLinkServ()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    int result = serv.update_event_link_serv("Virtual music!", "www.music.com");
    assert (result == 1);
    assert(serv.get_repository().get_events()[2].get_link() == "www.music.com");
    result = serv.update_event_link_serv("hfskjfh", "fjkdjf");
    assert(result == -1);
    result = serv.update_event_link_serv("Jane's dream", "");
    assert(result == -2);
}

void RunTestsService::testAddEventEvlist()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    assert(serv.get_event_list().get_events().size() == 0);
    int result = serv.add_event_evlist(serv.get_repository().get_events()[0]);
    assert (result == 1);
    assert(serv.get_event_list().get_events().size() == 1);
    result = serv.add_event_evlist(serv.get_repository().get_events()[0]);
    assert(result == -1);
}

void RunTestsService::testDeleteEventEvlist()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    assert(serv.get_event_list().get_events().size() == 0);
    int result = serv.delete_event_evlist(serv.get_repository().get_events()[0]);
    assert(result == -1);
    serv.add_event_evlist(serv.get_repository().get_events()[0]);
    result = serv.delete_event_evlist(serv.get_repository().get_events()[0]);
    assert(result == 1);
    assert(serv.get_event_list().get_events().size() == 0);
}

void RunTestsService::testFilterEventsByMonth()
{
    Repository repo = Repository();
    Service serv = Service(repo);
    serv.initialise();
    assert(serv.get_repository().get_events().size() == 10);
    assert(serv.get_event_list().get_events().size() == 0);
    vector<Event> filtrd = serv.filter_events_by_month(5);
    assert(filtrd.size() == 4);
    filtrd = serv.filter_events_by_month(6);
    assert(filtrd.size() == 0);
    filtrd = serv.filter_events_by_month(4);
    assert(filtrd.size() == 4);
}

void RunTestsService::run_tests_serv()
{
    RunTestsService::testAddEventServ();
    RunTestsService::testRemoveEventServ();
    RunTestsService::testUpdateEventTitleServ();
    RunTestsService::testUpdateEventDescriptionServ();
    RunTestsService::testUpdateEventDateTimeServ();
    RunTestsService::testUpdateEventPeopleServ();
    RunTestsService::testUpdateEventLinkServ();
    RunTestsService::testAddEventEvlist();
    RunTestsService::testDeleteEventEvlist();
    RunTestsService::testFilterEventsByMonth();
}
