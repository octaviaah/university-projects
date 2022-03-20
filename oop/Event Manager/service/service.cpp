//
// Created by Expert on 4/10/2021.
//

#include "service.h"

void Service::initialise()
{
    struct tm date;
    date.tm_mday = 17; date.tm_mon = 5; date.tm_year = 2021; date.tm_hour = 16; date.tm_min = 0;
    this->repository.add_event(Event("Jane's dream", "fundraiser", date, 200, "www.janesdream.com"));
    date.tm_mday = 1; date.tm_mon = 4; date.tm_year = 2021; date.tm_hour = 10; date.tm_min = 45;
    this->repository.add_event(Event("Individual cooking 101", "cooking", date, 100, "www.indvcourses.com"));
    date.tm_mday = 12; date.tm_mon = 4; date.tm_year = 2022; date.tm_hour = 20; date.tm_min = 0;
    this->repository.add_event(Event("Virtual music!", "karaoke", date, 100, "www.virtual.com"));
    date.tm_mday = 30; date.tm_mon = 3; date.tm_year = 2021; date.tm_hour = 15; date.tm_min = 20;
    this->repository.add_event(Event("Spring Sing-Open House", "karaoke", date, 150, "www.spring-sing.com"));
    date.tm_mday = 14; date.tm_mon = 4; date.tm_year = 2021; date.tm_hour = 14; date.tm_min = 10;
    this->repository.add_event(Event("Afterlife conversations", "beliefs", date, 20, "www.conversewithgod.com"));
    date.tm_mday = 7; date.tm_mon = 4; date.tm_year = 2021; date.tm_hour = 22; date.tm_min = 0;
    this->repository.add_event(Event("PSG vs Bayern CL Quarterfinal", "football match", date, 2000, "www.football-live.com"));
    date.tm_mday = 6; date.tm_mon = 5; date.tm_year = 2021; date.tm_hour = 17; date.tm_min = 25;
    this->repository.add_event(Event("Let's discuss: Science fiction books", "book club", date, 350, "www.letsdiscuss.com"));
    date.tm_mday = 11; date.tm_mon = 7; date.tm_year = 2021; date.tm_hour = 17; date.tm_min = 55;
    this->repository.add_event(Event("'The Philadelphia Story' Screening", "film screening", date, 2000, "www.cinema.com"));
    date.tm_mday = 17; date.tm_mon = 5; date.tm_year = 2021; date.tm_hour = 12; date.tm_min = 30;
    this->repository.add_event(Event("Espanol 101", "language and culture", date, 100, "www.espanol.com"));
    date.tm_mday = 15; date.tm_mon = 5; date.tm_year = 2021; date.tm_hour = 13; date.tm_min = 15;
    this->repository.add_event(Event("Bird walk in Central Park", "bird walk", date, 50, "www.birdwalksnyc.com"));
}

void Service::short_init() {
    this->repository.short_init("D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    this->event_list.short_init("D:/facultate/oop/a10-octaviaah-1/ui/event_list.txt");
}

int Service::add_event_serv(string title, string description, struct tm date_time, int people, string link, bool record)
{
    try{
        Validator::validate_event(title, description, date_time, people, link);
    }
    catch (ValidationException& ex){
        cout << ex.get_message() << endl;
        return -2;
    }
    if (record)
        undo_operations.emplace_back(new UndoAdd(*this, title, this->repository.get_events()[this->repository.get_events().size()-1]));
    Event event = Event(title, description, date_time, people, link);
    try {
        this->repository.add_event(event);
    }
    catch (RepoException& ex)
    {
        cout << ex.get_message() << endl;
        return -1;
    }
    return 1;
}

int Service::delete_event_serv(string title, bool record)
{
    try{
        Validator::validate_title(title);
    }
    catch (ValidationException& ex){
        cout << ex.get_message() << endl;
        return -2;
    }
    if (record) {
        Event t;
        for (auto ev: this->repository.get_events())
            if (ev.get_title() == title)
                t = ev;
        undo_operations.emplace_back(new UndoRemove(*this, t));
    }
    try {
        this->repository.remove_event(title);
    }
    catch (RepoException& ex)
    {
        cout << ex.get_message() << endl;
        return -1;
    }
    return 1;
}

int Service::update_event_title_serv(string title, string new_title, bool record)
{
    try{
        Validator::validate_title(new_title);
    }
    catch (ValidationException& ex) {
        cout << ex.get_message() << endl;
        return -2;
    }
    /*if (record) {
        int index;
        for (int i=0; i<this->repository.get_events().size(); i++)
            if (this->repository.get_events()[i].get_title() == title)
                index = i;
        undo_operations.emplace_back(new UndoUpdate(*this, this->repository.get_events()[index], title, title));
    }*/
    int position = this->repository.find_event(title);
    if (position == -1)
        return -1;
    position = this->repository.find_event(new_title);
    if (position != -1)
        return -1;
    this->repository.update_event_title(title, new_title);
    return 1;
}

int Service::update_event_description_serv(string title, string new_description, bool record)
{
    try{
        Validator::validate_description(new_description);
    }
    catch (ValidationException& ex) {
        cout << ex.get_message() << endl;
        return -2;
    }
    int position = this->repository.find_event(title);
    if (position == -1)
        return -1;
    this->repository.update_event_description(title, new_description);
    return 1;
}

int Service::update_event_date_time_serv(string title, struct tm new_date_time, bool record)
{
    try{
        Validator::validate_date_time(new_date_time);
    }
    catch (ValidationException& ex) {
        cout << ex.get_message() << endl;
        return -2;
    }
    int position = this->repository.find_event(title);
    if (position == -1)
        return -1;
    this->repository.update_event_date_time(title, new_date_time);
    return 1;
}

int Service::update_event_people_serv(string title, int new_people, bool record)
{
    try {
        Validator::validate_people(new_people);
    }
    catch (ValidationException& ex) {
        cout << ex.get_message() << endl;
        return -2;
    }
    int position = this->repository.find_event(title);
    if (position == -1)
        return -1;
    this->repository.update_event_people(title, new_people);
    return 1;
}

int Service::update_event_link_serv(string title, string new_link, bool record)
{
    try{
        Validator::validate_link(new_link);
    }
    catch (ValidationException& ex) {
        cout << ex.get_message() << endl;
        return -2;
    }
    int position = this->repository.find_event(title);
    if (position == -1)
        return -1;
    this->repository.update_event_link(title, new_link);
    return 1;
}

void Service::update_event_serv(string title, string new_title, string new_desc, struct tm dt, int p, string newl,
                                bool record) {
    if (record) {
        int index;
        for (int i=0; i<this->repository.get_events().size(); i++)
            if (this->repository.get_events()[i].get_title() == title)
                index = i;
        undo_operations.emplace_back(new UndoUpdate(*this, this->repository.get_events()[index], new_title, title));
    }
    this->update_event_description_serv(title, new_desc);
    this->update_event_date_time_serv(title, dt);
    this->update_event_people_serv(title, p);
    this->update_event_link_serv(title, newl);
    this->update_event_title_serv(title, new_title);
}

int Service::add_event_evlist(const Event &event)
{
    try {
        this->event_list.add_event(event);
    }
    catch (RepoException& ex)
    {
        cout << ex.get_message() << endl;
        return -1;
    }
    this->repository.update_event_people(event.get_title(), event.get_people()+1);
    this->event_list.update_event_people(event.get_title(), event.get_people()+1);
    return 1;
}

int Service::delete_event_evlist(const Event &event)
{
    try {
        this->event_list.remove_event(event.get_title());
    }
    catch (RepoException& ex)
    {
        cout << ex.get_message() << endl;
        return -1;
    }
    this->repository.update_event_people(event.get_title(), event.get_people()-1);
    return 1;
}

vector<Event> Service::filter_events_by_month(int month)
{
    vector<Event> filtered_events;
    //for (index = 0; index < this->repository.get_events().size(); index++)
    for (auto& event: this->repository.get_events())
        if (event.get_date_time().tm_mon == month)
            filtered_events.push_back(event);
    if (filtered_events.size() != 0)
        sort(filtered_events);
    return filtered_events;
}

int verify_date(Event e1, Event e2)
/**
 * verifies if the dates are in ascending order(used for the sorting function)
 * @tparam T -> elements of the vector are of type T
 * @param e1 -> element of class T
 * @param e2 -> element of class T
 * @return 1 if the dates are in ascending order
 *        -1 otherwise
 */
{
    if (e1.get_date_time().tm_year > e2.get_date_time().tm_year)
        return 1;
    else if (e1.get_date_time().tm_year == e2.get_date_time().tm_year && e1.get_date_time().tm_mday > e2.get_date_time().tm_mday)
        return 1;
    else if (e1.get_date_time().tm_mday == e2.get_date_time().tm_mday && e1.get_date_time().tm_hour > e2.get_date_time().tm_hour)
        return 1;
    else if (e1.get_date_time().tm_hour == e2.get_date_time().tm_hour && e1.get_date_time().tm_min > e2.get_date_time().tm_min)
        return 1;
    else return -1;
}

void sort(vector<Event> vect)
{
    int index, ok;
    Event elem;
    ok = 7;
    do
    {
        ok = 9;
        index = 0;
        while (index < vect.size() - 1)
        {
            if (verify_date(vect[index], vect[index + 1]) == 1) {
                elem = vect[index];
                vect[index] = vect[index + 1];
                vect[index + 1] = elem;
                ok = 7;
            }
            index ++;
        }
    }while(ok == 7);
}