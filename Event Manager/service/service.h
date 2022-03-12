//
// Created by Expert on 4/10/2021.
//

#ifndef A45_OCTAVIAAH_SERVICE_H
#define A45_OCTAVIAAH_SERVICE_H

#include <iostream>
#include "repository.h"
#include "validator.h"

using namespace std;

class Service
{
    private:
        Repository repository;
        Repository event_list;
        class UndoOperation{
        public:
            UndoOperation(string title): title(title){}
            virtual void undo() = 0;
            virtual string getType(){
                return "it's a no no";
            }
            string title;
            virtual Event get_event(){
                return Event();
            }
            virtual string get_title() = 0;
        };
        class UndoAdd: public UndoOperation{
        public:
            UndoAdd(Service &serv, string title, Event ev): UndoOperation(title), serv{serv}, title{title}, ev(ev){}
            void undo() override{
                serv.delete_event_serv(title, false);
            }
            string getType() override{
                return "add";
            }
            Event get_event() override{
                return ev;
            }
            string get_title() override{
                return title;
            }
        private:
            Service &serv;
            string title;
            Event ev;
        };

        class UndoRemove: public UndoOperation{
        public:
            UndoRemove(Service &serv, Event ev): UndoOperation(ev.get_title()), serv{serv}, ev(ev){};
            void undo() override{
                serv.add_event_serv(ev.get_title(), ev.get_description(), ev.get_date_time(), ev.get_people(), ev.get_link(), false);
            }
            string getType() override{
                return "remove";
            }
            Event get_event() override{
                return ev;
            }
            string get_title() override{
                return ev.get_title();
            }
        private:
            Service &serv;
            Event ev;
        };

        class UndoUpdate: public UndoOperation{
        public:
            UndoUpdate(Service &serv, Event ev, string title, string new_title): UndoOperation(title), serv{serv}, ev(ev), title{title}, new_title(new_title) {};
            void undo() override{
                serv.update_event_serv(title, ev.get_title(), ev.get_description(), ev.get_date_time(), ev.get_people(), ev.get_link(), false);

            }
            string getType() override{
                return "update";
            }
            Event get_event() override{
                return ev;
            }
            string get_title() override{
                return title;
            }
        private:
            Service &serv;
            Event ev;
            string title;
            string new_title;
        };
        vector<UndoOperation*> undo_operations;
        vector<UndoOperation*> redo_operations;
    public:

        Service(const Repository& repo) : repository{repo}, event_list() {}


        Repository get_repository() const {return repository;}

        Repository get_event_list() const {return event_list;}

        void initialise();

        void short_init();

        int add_event_serv(string title, string description, struct tm date_time, int people, string link, bool record = true);

        int delete_event_serv(string title, bool record = true);

        int update_event_title_serv(string title, string new_title, bool record = true);

        int update_event_description_serv(string title, string new_description, bool record = true);

        int update_event_date_time_serv(string title, struct tm new_date_time, bool record = true);

        int update_event_people_serv(string title, int new_people, bool record = true);

        int update_event_link_serv(string title, string new_link, bool record = true);

        void update_event_serv(string title, string new_title, string new_desc, struct tm dt, int p, string newl, bool record = true);

        void undo()
        {
            if (!undo_operations.empty())
            {
                if (undo_operations.back()->getType() == "update")
                {
                    int index=-1;
                    for (int i =0; i<repository.get_events().size(); i++) {
                        if (repository.get_events()[i].get_title() == undo_operations.back()->title)
                            index = i;
                    }
                    redo_operations.emplace_back(new UndoUpdate(*this, repository.get_events()[index], undo_operations.back()->get_event().get_title(), undo_operations.back()->get_title()));
                }

                if (undo_operations.back()->getType() == "add"){
                    int index = -1;
                    for (int i =0; i<repository.get_events().size(); i++)
                        if (repository.get_events()[i].get_title() == undo_operations.back()->title)
                            index = i;
                    redo_operations.emplace_back(new UndoRemove(*this, repository.get_events()[index]));
                }
                else if (undo_operations.back()->getType() == "remove")
                {
                    redo_operations.emplace_back(new UndoAdd(*this, undo_operations.back()->title, undo_operations.back()->get_event()));
                }
                undo_operations.back()->undo();
                undo_operations.pop_back();
            }
        }

        void redo()
        {
            if (!redo_operations.empty())
            {
                if (redo_operations.back()->getType() == "update")
                {
                    int index;
                    for (int i =0; i<repository.get_events().size(); i++)
                        if (repository.get_events()[i].get_title() == redo_operations.back()->title)
                            index = i;
                    undo_operations.emplace_back(new UndoUpdate(*this, repository.get_events()[index], redo_operations.back()->get_event().get_title(), redo_operations.back()->get_title()));
                }
                if (redo_operations.back()->getType() == "add"){
                    int index = -1;
                    for (int i =0; i<repository.get_events().size(); i++)
                        if (repository.get_events()[i].get_title() == redo_operations.back()->title)
                            index = i;
                    undo_operations.emplace_back(new UndoRemove(*this, repository.get_events()[index]));
                }
                else if (redo_operations.back()->getType() == "remove")
                {
                    undo_operations.emplace_back(new UndoAdd(*this, redo_operations.back()->title, redo_operations.back()->get_event()));
                }
                redo_operations.back()->undo();
                redo_operations.pop_back();
            }
        }


        /*
         * adds an event to the event list
         * because only events from the repository can be added to the event list, there's no need to verify if an event is in the repo or not
         * param event -> event to be added(const Event&)
         * returns -> 1 if the event was successfully added
         *           -1 if not
         */
        int add_event_evlist(const Event& event);


        /*
         * deletes event from the event list
         * same restrictions as above
         * param event -> event to be added(const Event&)
         * returns -> 1 if the event was successfully delete
         *           -1 if not
         */
        int delete_event_evlist(const Event& event);


        /*
         * filters the events from the repository by creating a new dynamic vector and storing the filtered events there. the fitlered events are also sorted in ascending order after the date and time
         * param month -> the month after which the events will be filtered(int)
         * returns -> the filtered_events dynamic vector
         */
        vector<Event> filter_events_by_month(int month);
};
int verify_date(Event e1, Event e2);

void sort(vector<Event> vect);
#endif //A45_OCTAVIAAH_SERVICE_H
