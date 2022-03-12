//
// Created by Expert on 3/20/2021.
//

#ifndef A45_OCTAVIAAH_REPOSITORY_H
#define A45_OCTAVIAAH_REPOSITORY_H

#include "event.h"
#include "dynamic_vector.h"
#include <vector>

class Repository
{
    private:
        vector<Event> events;

    public:
        /*
         * default constructor for the repository
         */
        Repository() = default;

        void short_init(string file_name);

        /*
         * adds event to the repository
         * param event -> event to be added(const Event&)
         * returns -> 1 if the event was successfully added
         *           -1 if not
         */
        int add_event(const Event& event);


        /*
         * removes event from the repository
         * param title -> the unique identifier of the event(const string&)
         * returns -> 1 if the event was successfully removed
         *           -1 if not
         */
        int remove_event(const string& title);


        /*
         * returns the events in the repository
         */
        vector<Event> get_events() {return this->events;};


        /*
         * searches for an event with a given title
         * param title -> the unique identifier of the event(const string&)
         * returns -> the index of the event if it is in the repository
         *            -1 if not
         */
        int find_event(const string& title);


        /*
         * updates the title of the event
         * param title -> the unique identifier of the event(const string&)
         * param new_title -> new title of the event(string)
         * return -> 1 if the title of event was updated successfully
         *          -1 if not
         */
        int update_event_title(const string &title, string new_title);


        /*
         * updates the description of the event
         * param description -> the unique identifier of the event(const string&)
         * param new_description -> new description of the event(string)
         * return -> 1 if the description of event was updated successfully
         *          -1 if not
         */
        int update_event_description(const string &title, string new_description);


        /*
         * updates the date and time of the event
         * param date and time -> the unique identifier of the event(const string&)
         * param new_date and time -> new date and time of the event(date time structure)
         * return -> 1 if the date and time of event was updated successfully
         *          -1 if not
         */
        int update_event_date_time(const string &title, struct tm new_date_time);


        /*
         * updates the number of people of the event
         * param people -> the unique identifier of the event(const string&)
         * param new_people -> new number of people of the event(int)
         * return -> 1 if the number of people of event was updated successfully
         *          -1 if not
         */
        int update_event_people(const string &title, int new_people);


        /*
         * updates the link of the event
         * param link -> the unique identifier of the event(const string&)
         * param new_link -> new link of the event(string)
         * return -> 1 if the link of event was updated successfully
         *          -1 if not
         */
        int update_event_link(const string &title, string new_link);

};

class RepoException {
private:
    string message;
public:
    RepoException(string mess);
    string get_message() const;
};
#endif //A45_OCTAVIAAH_REPOSITORY_H
