//
// Created by Expert on 3/20/2021.
//

#include "repository.h"
#include "../file_manager/file_manager.h"
#include <iostream>

using namespace std;

RepoException::RepoException(string mess) : message{mess} {
}

string RepoException::get_message() const {
    return this->message;
}

void Repository::short_init(string file_name) {
    FileManager::read_from_file(this->events, file_name);
}

int Repository::add_event(const Event &event)
{
    string errors;
    if (find_event(event.get_title()) == -1)
    {
        this->events.push_back(event);
        return 1;
    }
    errors += string("Event already in the list!");
    throw RepoException(errors);
}

int Repository::remove_event(const string &title)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events.erase(this->events.begin() + position);
    return 1;
}

int Repository::find_event(const string& title)
{
    //for (index = 0; index < this->events.size(); index ++)
    for (auto& event: this->events)
        if (event.get_title() == title)
        {
            int position = &event - &this->events[0];
            return position;
        }
    return -1;
}

int Repository::update_event_title(const string &title, string new_title)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events[position].set_title(new_title);
    return 1;
}

int Repository::update_event_description(const string &title, string new_description)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events[position].set_description(new_description);
    return 1;
}

int Repository::update_event_date_time(const string &title, struct tm new_date_time)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events[position].set_date_time(new_date_time);
    return 1;
}

int Repository::update_event_people(const string &title, int new_people)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events[position].set_people(new_people);
    return 1;
}

int Repository::update_event_link(const string &title, string new_link)
{
    string errors;
    int position = find_event(title);
    if (position == -1)
    {
        errors += string("Event doesn't exist!");
        throw RepoException(errors);
    }
    this->events[position].set_link(new_link);
    return 1;
}