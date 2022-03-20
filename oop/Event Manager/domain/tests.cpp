//
// Created by Expert on 3/20/2021.
//

#include "tests.h"
#include <cassert>
#include <iostream>
#include "validator.h"

using namespace std;

void RunTestsDomain::testEvent() {
    struct tm date;
    date.tm_mday = 14; date.tm_mon = 4; date.tm_year = 2021; date.tm_hour = 19; date.tm_min = 30;
    Event event = Event("party", "very cool party", date, 20, "www.party.com");
    assert(event.get_title() == "party");
    assert(event.get_description() == "very cool party");
    assert(event.get_date_time().tm_mday == 14);
    assert(event.get_date_time().tm_mon == 4);
    assert(event.get_date_time().tm_year == 2021);
    assert(event.get_date_time().tm_hour == 19);
    assert(event.get_date_time().tm_min == 30);
    assert(event.get_people() == 20);
    assert(event.get_link() == "www.party.com");
    event.set_title("fundraising");
    event.set_description("for a noble cause");
    date.tm_mday = 19; date.tm_year = 2021; date.tm_mon = 5; date.tm_min = 30; date.tm_hour = 10;
    event.set_date_time(date);
    event.set_people(15);
    event.set_link("www.fundraising.com");
    assert(event.get_title() == "fundraising");
    assert(event.get_description() == "for a noble cause");
    assert(event.get_date_time().tm_mday == 19);
    assert(event.get_date_time().tm_mon == 5);
    assert(event.get_date_time().tm_year == 2021);
    assert(event.get_date_time().tm_hour == 10);
    assert(event.get_date_time().tm_min == 30);
    assert(event.get_people() == 15);
    assert(event.get_link() == "www.fundraising.com");
}

void RunTestsDomain::testValidatorEvent()
{
    struct tm date;
    int truth;
    date.tm_mday = 14; date.tm_mon = 4; date.tm_year = 2021; date.tm_hour = 19; date.tm_min = 30;
    try{
        truth = Validator::validate_event("party", "very cool party", date, 20, "www.party.com");
    }
    catch (ValidationException& ex){
    }
    assert(truth == 1);
    try{
        Validator::validate_event("", "fsdfds", date, 222, "dhsjds");
    }
    catch (ValidationException& ex){
        truth = 0;
    }
    assert(truth == 0);
}

void RunTestsDomain::testValidatorTitle()
{
    int truth=0;
    try{
        Validator::validate_title("mello");
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert (truth == 0);
    try{
        Validator::validate_title("");
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);
}

void RunTestsDomain::testValidatorDescription()
{
    int truth=0;
    try{
        Validator::validate_description("mello");
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert (truth == 0);
    try{
        Validator::validate_description("");
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);
}

void RunTestsDomain::testValidatorDateTime()
{
    struct tm date;
    int truth=0;
    date.tm_min = 20; date.tm_hour = 22; date.tm_mday = 22; date.tm_year = 2021; date.tm_mon = 2;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth =1;
    }
    assert(truth == 0);

    date.tm_mon = 2; date.tm_year = 2019; date.tm_mday = 22; date.tm_hour = 22; date.tm_min = 11;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);

    date.tm_min = 14; date.tm_hour = 3; date.tm_mday = 7; date.tm_mon = 15; date.tm_year = 2021;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);

    date.tm_year = 2021; date.tm_mon = 7; date.tm_mday = 36; date.tm_hour = 14; date.tm_min = 0;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);

    date.tm_min = 14; date.tm_hour = 25; date.tm_mday = 8; date.tm_year = 2022; date.tm_mon = 9;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth =1;
    }
    assert(truth == 1);

    date.tm_min = 63; date.tm_hour = 6; date.tm_mon = 6; date.tm_year = 2021; date.tm_mday = 29;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth =1;
    }
    assert(truth==1);

    date.tm_year = 2022; date.tm_mon = 2; date.tm_mday = 29; date.tm_hour = 8; date.tm_min = 33;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth =1;
    }
    assert(truth == 1);

    date.tm_min = 5; date.tm_hour = 9; date.tm_mday = 31; date.tm_mon = 6; date.tm_year = 2021;
    try{
        Validator::validate_date_time(date);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);

}

void RunTestsDomain::testValidatorPeople()
{
    int truth=0;
    try{
        Validator::validate_people(88);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 0);
    try{
        Validator::validate_people(-999);
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);
}

void RunTestsDomain::testValidatorLink()
{
    int truth=0;
    try{
        Validator::validate_link("mello");
    }
    catch(ValidationException& ex)
    {
        truth = 1;
    }
    assert (truth == 0);
    try {
        Validator::validate_link("");
    }
    catch (ValidationException& ex)
    {
        truth = 1;
    }
    assert(truth == 1);
}

void RunTestsDomain::test_read_from_file()
{
    ifstream fin("D:/facultate/oop/a45-octaviaah/domain/testing.txt");
    Event ev;
    fin >> ev;
    assert(ev.get_title() == "Jane's dream");
    assert(ev.get_description() == "tfdhtfdsa");
    assert(ev.get_date_time().tm_year == 2021);
    assert(ev.get_date_time().tm_mon == 5);
    assert(ev.get_date_time().tm_mday==17);
    assert(ev.get_date_time().tm_hour==16);
    assert(ev.get_date_time().tm_min==0);
    assert(ev.get_link()=="www.janesdream.com");
    assert(ev.get_people()==200);
}

void RunTestsDomain::test_write_to_console()
{
    ifstream fin("D:/facultate/oop/a45-octaviaah/domain/testing.txt");
    Event ev;
    fin >> ev;
    ofstream fout("D:/facultate/oop/a45-octaviaah/domain/testing2.txt");
    fout << ev;
}

void RunTestsDomain::run_tests_domain() {
    RunTestsDomain::testEvent();
    RunTestsDomain::testValidatorEvent();
    RunTestsDomain::testValidatorDateTime();
    RunTestsDomain::testValidatorDescription();
    RunTestsDomain::testValidatorTitle();
    RunTestsDomain::testValidatorLink();
    RunTestsDomain::testValidatorPeople();
    RunTestsDomain::test_read_from_file();
    RunTestsDomain::test_write_to_console();
}