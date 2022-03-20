//
// Created by Expert on 3/23/2021.
//

#include "validator.h"
#include <iostream>

ValidationException::ValidationException(string mess) : message{mess} {
}

string ValidationException::get_message() const {
    return this->message;
}

int Validator::validate_event(string title, string description, struct tm date_time, int people, string link)
{
    try{
        validate_title(title);
        validate_description(description);
        validate_date_time(date_time);
        validate_people(people);
        validate_link(link);
    }
    catch(ValidationException& ex){
        throw ValidationException(ex.get_message());
    }
    return 1;
}

int Validator::validate_title(string title)
{
    string errors;
    if (title.empty())
        errors += string("Title cannot be empty!");
    if (errors.size() > 0)
        throw ValidationException(errors);
    return 1;
}

int Validator::validate_description(string description)
{
    string errors;
    if (description.empty())
        errors += string("Description cannot be empty!");
    if (errors.size() > 0)
        throw ValidationException(errors);
    return 1;
}

int Validator::validate_date_time(struct tm date_time)
{
    string errors;
    if (date_time.tm_year < 2021 || date_time.tm_year > 2022)
        errors += string("Invalid year");
    if (date_time.tm_mon < 1 ||date_time.tm_mon > 12)
        errors += string("Invalid month");
    if (date_time.tm_mday < 1 || date_time.tm_mday > 31)
        errors += string("Invalid day");
    if (date_time.tm_hour < 0 || date_time.tm_hour > 23)
        errors += string("Invalid hour");
    if (date_time.tm_min < 0 || date_time.tm_min > 59)
        errors += string("Invalid minutes");
    if (date_time.tm_mon == 2)
        if (date_time.tm_mday > 28)
            if (errors.size() == 0)
                errors += string("There is no February 29th, 30th and so on");
    if (date_time.tm_mon == 4 || date_time.tm_mon == 6 || date_time.tm_mon == 9 || date_time.tm_mon == 11)
        if (date_time.tm_mday > 30)
            if (errors.size() == 0)
                errors += string("I haven't heard of April 31st, or September 31st and so on");
    if (errors.size() > 0)
        throw ValidationException(errors);
    return 1;
}

int Validator::validate_people(int people)
{
    string errors;
    if (people <=0)
        errors += string("Number of people cannot be 0 or less!");
    if (errors.size() > 0)
        throw ValidationException(errors);
    return 1;
}

int Validator::validate_link(string link)
{
    string errors;
    if (link.empty())
        errors += string("Link cannot be empty!");
    if (errors.size() > 0)
        throw ValidationException(errors);
    return 1;
}
