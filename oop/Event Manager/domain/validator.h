//
// Created by Expert on 3/23/2021.
//

#ifndef A45_OCTAVIAAH_VALIDATOR_H
#define A45_OCTAVIAAH_VALIDATOR_H

#include <string>

using namespace std;

class Validator {
public:
    /*
     * validates the data for an event
     * param title -> title of the event(string)
     * param description -> description of the event(string)
     * param date_time -> date and time of the event(date time structure)
     * param people -> number of people of the event(int)
     * param link -> link of the event(string)
     * returns 1 if the data is valid
     *        -1 if not
     */
    static int validate_event(string title, string description, struct tm date_time, int people, string link);

    /*
     * validates the title of an event
     * param title -> title of the event(string)
     * returns 1 if the title is valid(not empty)
     *        -1 if not
     */
    static int validate_title(string title);

    /*
     * validates the description for an event
     * param description -> description of the event(string)
     * returns 1 if the description is valid(not empty)
     *        -1 if not
     */
    static int validate_description(string description);

    /*
     * validates the date and time for an event
     * param date_time -> date and time of the event(date time structure)
     * returns 1 if the date and time are valid
     *        -1 if not
     */
    static int validate_date_time(struct tm date_time);

    /*
     * validates the number of people for an event
     * param people -> number of people of the event(int)
     * returns 1 if the number is valid(>0)
     *        -1 if not
     */
    static int validate_people(int people);

    /*
     * validates the link for an event
     * param link -> link of the event(string)
     * returns 1 if the link is valid(not empty)
     *        -1 if not
     */
    static int validate_link(string link);
};

class ValidationException {
    private:
        string message;
    public:
        ValidationException(string mess);
        string get_message() const;
};
#endif //A45_OCTAVIAAH_VALIDATOR_H
