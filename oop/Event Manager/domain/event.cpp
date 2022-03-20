//
// Created by Expert on 3/20/2021.
//

#include "event.h"
#include <iostream>
#include <string>

using namespace std;

Event::Event(string title, string description, struct tm date_time, int people, string link) : title(title), description(description), date_time(date_time), people(people), link(link)
{}

string Event::get_title() const {
    return this->title;
}

string Event::get_description() const {
    return this->description;
}

struct tm Event::get_date_time() const {
    return this->date_time;
}

int Event::get_people() const {
    return this->people;
}

string Event::get_link() const {
    return this->link;
}

void Event::set_title(string title) {
    this->title = title;
}

void Event::set_description(string description) {
    this->description = description;
}

void Event::set_date_time(struct tm date_time) {
    this->date_time = date_time;
}

void Event::set_people(int people) {
    this->people = people;
}

void Event::set_link(string link) {
    this->link = link;
}

istream& operator >> (istream& fin, Event& event){
    string title;
    string description;
    struct tm date_time{};
    int people;
    string link;

    /**getline(fin, title);
    getline(fin, description);
    fin >> date_time.tm_mday >> date_time.tm_mon >> date_time.tm_year >> date_time.tm_hour >> date_time.tm_min >> people;
    getline(fin, link);*/
    string line;
    getline(fin, line);
    size_t position = line.find(",");
    title = line.substr(0, position);
    line.erase(0, position + 1);

    position = line.find(",");
    description = line.substr(0, position);
    line.erase(0, position+1);

    position = line.find("-");
    date_time.tm_mday = atoi(line.substr(0, position).c_str());
    line.erase(0, position +1);

    position = line.find("-");
    date_time.tm_mon = atoi(line.substr(0, position).c_str());
    line.erase(0, position + 1);

    position = line.find(" ");
    date_time.tm_year = atoi(line.substr(0, position).c_str());
    line.erase(0, position + 1);

    position = line.find(":");
    date_time.tm_hour = atoi(line.substr(0, position).c_str());
    line.erase(0, position + 1);

    position = line.find(",");
    date_time.tm_min= atoi(line.substr(0, position).c_str());
    line.erase(0, position + 1);

    position = line.find(",");
    people = atoi(line.substr(0, position).c_str());
    line.erase(0, position + 1);

    link = line;

    event.set_title(title);
    event.set_description(description);
    event.set_date_time(date_time);
    event.set_people(people);
    event.set_link(link);

    return fin;
}

ostream& operator << (ostream& out, const Event& event){
    out << event.get_title() << " - " << event.get_description() << " - " << event.get_date_time().tm_mday << "-" << event.get_date_time().tm_mon << "-" << event.get_date_time().tm_year << " " << event.get_date_time().tm_hour << ":" << event.get_date_time().tm_min << " - " << event.get_people() << " - " << event.get_link() << endl;
    return out;
}

