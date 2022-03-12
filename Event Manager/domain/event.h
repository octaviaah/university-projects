//
// Created by Expert on 3/20/2021.
//

#ifndef A45_OCTAVIAAH_EVENT_H
#define A45_OCTAVIAAH_EVENT_H

#include <fstream>
#include <string>
#include <ctime>

using namespace std;

class Event{
    private:
        string title;
        string description;
        struct tm date_time{};
        int people;
        string link;

    public:
        /*
         * default constructor for event
         */
        Event() = default;

        /*
         * constructor with parameters for event
         */
        Event(string title, string description, struct tm date_time, int people, string link);

        /*
         * destructor for event
         */
        ~Event() = default;


        /*
         * returns the title of an event(string)
         */
        string get_title() const;

        /*
         * returns the title of an event(string)
         */
        string get_description() const;

        /*
         * returns the date and time of an event(date time structure)
         */
        struct tm get_date_time() const;

        /*
         * returns the number of people of an event(int)
         */
        int get_people() const;

        /*
         * returns the link of an event(string)
         */
        string get_link() const;


        /*
         * sets the title of an event
         * param title -> the title the event will receive(string)
         */
        void set_title(string title);

        /*
         * sets the description of an event
         * param description -> the description the event will receive(string)
         */
        void set_description(string description);

        /*
         * sets the date and time of an event
         * param date_time -> the date and time the event will receive(date time structure)
         */
        void set_date_time(struct tm date_time);

        /*
         * sets the number of people of an event
         * param people -> the number of people the event will receive(int)
         */
        void set_people(int people);

        /*
         * sets the link of an event
         * param link -> the link the event will receive(string)
         */
        void set_link(string link);
};

/*
 * operator >> is overloaded(used to read from a file)
 * return the operator
 */
istream& operator >> (istream& fin, Event& event);

/*
 * operator << is overloaded(used to print from a file/memory database in a certain way
 * return the operator
 */
ostream& operator << (ostream& out, const Event& event);

#endif //A45_OCTAVIAAH_EVENT_H
