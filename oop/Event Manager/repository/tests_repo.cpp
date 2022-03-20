//
// Created by Expert on 3/21/2021.
//

#include "tests_repo.h"
#include <cassert>
#include "event.h"
#include <iostream>

using namespace std;

void RunTestsRepository::testAddEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    int result;
    try{
        result = repo.add_event(ev);
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == 1);
    assert(repo.get_events().size() == 1);
    assert(repo.get_events()[0].get_title() == "party");
    try{
        result = repo.add_event(ev);
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == -1);
    try{
        result = repo.update_event_title("party", "ffff");
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == 1);
    assert(repo.get_events()[0].get_title()== "ffff");
}

void RunTestsRepository::testRemoveEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result;
    try {
        result = repo.remove_event(ev.get_title());
    }
    catch (RepoException& ex){
        result = -1;
    }
    assert(result == 1);
    assert(repo.get_events().size() == 0);
    ev = Event("fundraising", "for a noble cause", date, 2000, "www.noble.com");
    try{
        result = repo.remove_event(ev.get_title());
    }
    catch (RepoException& ex){
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::testFindEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result = repo.find_event(ev.get_title());
    assert(result == 0);
    repo.remove_event(ev.get_title());
    result = repo.find_event(ev.get_title());
    assert(result == -1);
}

void RunTestsRepository::testUpdateTitleEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result;
    try{
        result = repo.update_event_title("party","karaoke");
    }
    catch (RepoException& ex)
    {
        result =-1;
    }
    assert (result == 1);
    assert(repo.get_events()[0].get_title() == "karaoke");
    try{
        result = repo.update_event_title("parfdsfdsfty", "fhsudhfs");
    }
    catch (RepoException& ex){
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::testUpdateDescriptionEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result;
    try{
        result = repo.update_event_description("party","karaoke");
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert (result == 1);
    assert(repo.get_events()[0].get_description() == "karaoke");
    try{
        result = repo.update_event_description("parfdfdsfty", "fhsudhfs");
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::testUpdateDateTimeEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    date.tm_mday = 30; date.tm_mon = 6; date.tm_year = 2022; date.tm_hour = 21; date.tm_min = 44;
    int result;
    try {
        result = repo.update_event_date_time("party", date);
    }
    catch (RepoException& ex){
        result = -1;
    }
    assert (result == 1);
    assert(repo.get_events()[0].get_date_time().tm_min == date.tm_min);
    assert(repo.get_events()[0].get_date_time().tm_mon == date.tm_mon);
    assert(repo.get_events()[0].get_date_time().tm_mday == date.tm_mday);
    assert(repo.get_events()[0].get_date_time().tm_hour == date.tm_hour);
    assert(repo.get_events()[0].get_date_time().tm_year == date.tm_year);
    try{
        result = repo.update_event_date_time("fjisdjf", date);
    }
    catch (RepoException& ex){
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::testUpdatePeopleEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result;
    try{
        result = repo.update_event_people("party",4444);
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert (result == 1);
    assert(repo.get_events()[0].get_people() == 4444);
    try{
        result = repo.update_event_people("parfdfdsfty", 2222);
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::testUpdateLinkEvent()
{
    Repository repo = Repository();
    assert(repo.get_events().capacity() == 0);
    assert(repo.get_events().size() == 0);
    struct tm date;
    date.tm_mon = 12; date.tm_hour = 23; date.tm_min = 0; date.tm_year = 2021; date.tm_mday = 31;
    Event ev = Event("party", "cool party", date, 250, "www.party.com");
    repo.add_event(ev);
    int result;
    try {
        result = repo.update_event_link("party","karaoke");
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert (result == 1);
    assert(repo.get_events()[0].get_link() == "karaoke");
    try{
        result = repo.update_event_link("pafdsfsdfrty", "fhsudhfs");
    }
    catch (RepoException& ex)
    {
        result = -1;
    }
    assert(result == -1);
}

void RunTestsRepository::run_tests_repo()
{
    RunTestsRepository::testAddEvent();
    RunTestsRepository::testRemoveEvent();
    RunTestsRepository::testFindEvent();
    RunTestsRepository::testUpdateTitleEvent();
    RunTestsRepository::testUpdateDescriptionEvent();
    RunTestsRepository::testUpdateDateTimeEvent();
    RunTestsRepository::testUpdatePeopleEvent();
    RunTestsRepository::testUpdateLinkEvent();
}
