//
// Created by Expert on 4/10/2021.
//

#include "ui.h"
#include "tests.h"
#include "tests_serv.h"
#include "tests_repo.h"
#include <fstream>
#include "event.h"
#include "windows.h"
#include "../file_manager/file_manager.h"


void UI::print_choose_user_menu()
{
    cout << endl << "Choose user mode:" << endl;
    cout << "1.Administrator" << endl;
    cout << "2.User" << endl;
    cout << "0.Exit program." << endl;
}

void UI::print_admin_menu()
{
    cout << endl << "Administrator mode" << endl;
    cout << "1.Add an event." << endl;
    cout << "2.Delete an event." << endl;
    cout << "3.Update an event." << endl;
    cout << "4.Display all events" << endl;
    cout << "0.Exit administrator mode." << endl << endl;
}

void UI::print_user_menu()
{
    cout << endl << "User mode" << endl;
    cout << "1.Display events from a given month." << endl;
    cout << "2.Display your event list." << endl;
    cout << "0.Exit user mode" << endl << endl;
}

void UI::print_display_user_menu()
{
    cout << endl << "1.Add \t\t" << "2.Delete \t" << "3.Next \t\t" << "0.Exit" << endl << endl;
}

void UI::print_update_submenu()
{
    cout << "    1.Update title" << endl;
    cout << "     2.Update description" << endl;
    cout << "     3.Update date and time" << endl;
    cout << "     4.Update number of people" << endl;
    cout << "     5.Update link" << endl << endl;
}

void UI::print_user_file_menu()
{
    cout << "1.Display HTML file" << endl;
    cout << " 2.Display CSV file" << endl << endl;
}

void UI::add_ui()
{
    FileManager* tfm = new FileManagerText();
    string title, description, link;
    int people;
    struct tm date_time;
    cout << "Title: ";
    getline(cin, title);
    cout << "Description: ";
    getline(cin, description);
    cout << "\tDate and time: \n\tDay: ";
    cin >> date_time.tm_mday;
    cin.ignore();
    cout << "\t    Month: ";
    cin >> date_time.tm_mon;
    cin.ignore();
    cout << "\t  Year: ";
    cin >> date_time.tm_year;
    cin.ignore();
    cout << "       Hour: ";
    cin >> date_time.tm_hour;
    cin.ignore();
    cout << "\t    Minutes: ";
    cin >> date_time.tm_min;
    cin.ignore();
    cout << "  Number of people: ";
    cin >> people;
    cin.ignore();
    cout << "  Link: ";
    getline(cin, link);
    int t;
    t = this->service.add_event_serv(title, description, date_time, people, link);
    if (t == 1)
    {
        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
        cout << "Event was added in the database!" << endl;
    }
}

void UI::delete_ui()
{
    FileManager* tfm = new FileManagerText();
    string title;
    cout << " Title: ";
    getline(cin, title);
    int t;
    t = this->service.delete_event_serv(title);
    if (t == 1) {
        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
        cout << "Event was deleted from the database!" << endl;
    }
}

void UI::update_ui()
{
    FileManager* tfm = new FileManagerText();
    string title;
    cout << " Title: ";
    getline(cin, title);
    int t;
    t = Validator::validate_title(title);
    if (t == 1)
    {
        if (this->service.get_repository().find_event(title) != -1)
        {
            int option;
            UI::print_update_submenu();
            cout << "option > ";
            cin >> option;
            cin.ignore();
            switch(option) {
                case 1: {
                    string new_title;
                    cout << "\tNew title: ";
                    getline(cin, new_title);
                    t = this->service.update_event_title_serv(title, new_title);
                    if (t == 1) {
                        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                        cout << "Title of event was updated!" << endl;
                    }
                }
                break;
                case 2: {
                    string new_description;
                    cout << "\tNew description: ";
                    getline(cin, new_description);
                    t = this->service.update_event_description_serv(title, new_description);
                    if (t == 1) {
                        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                        cout << "Description of event was updated!" << endl;
                    }
                }
                break;
                case 3: {
                    struct tm new_date;
                    cout << "\tNew date and time: \n";
                    cout << "\t\tDay: ";
                    cin >> new_date.tm_mday;
                    cin.ignore();
                    cout << "\t\t    Month: ";
                    cin >> new_date.tm_mon;
                    cin.ignore();
                    cout << "\t\t  Year: ";
                    cin >> new_date.tm_year;
                    cin.ignore();
                    cout << "\t       Hour: ";
                    cin >> new_date.tm_hour;
                    cin.ignore();
                    cout << "\t\t    Minutes: ";
                    cin >> new_date.tm_min;
                    cin.ignore();
                    t = this->service.update_event_date_time_serv(title, new_date);
                    if (t == 1) {
                        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                        cout << "Date and time of event were updated!" << endl;
                    }
                }
                break;
                case 4: {
                    int new_people;
                    cout << "\tNew number of people: ";
                    cin >> new_people;
                    cin.ignore();
                    t = this->service.update_event_people_serv(title, new_people);
                    if (t == 1) {
                        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                        cout << "Number of people for the event was updated!" << endl;
                    }
                }
                break;
                case 5: {
                    string new_link;
                    cout << "\tNew link: ";
                    getline(cin, new_link);
                    t = this->service.update_event_link_serv(title, new_link);
                    if (t == 1) {
                        tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                        cout << "link of event was updated!" << endl;
                    }
                }
            }
        }
        else cout << "Event does not exist." << endl;
    }
}

void UI::display()
{
    vector<Event> eves = this->service.get_repository().get_events();
    if (eves.data() == NULL)
        return;
    if (eves.size() == 0)
    {
        cout << "There are no events in the database!" << endl;
        return;
    }
    cout << "The available events are:" << endl;
    //for (int index = 0; index < eves.size(); index++)
    for (auto& event: eves)
    {
        int index = &event - &eves[0];
        cout << index +1 << ". ";
        cout << event;
    }
}

void UI::display_event_list()
{
    vector<Event> eves = this->service.get_event_list().get_events();
    /*
    if (eves.size() == 0)
    {
        cout << "There are no events in the event list!" << endl;
        return;
    }
    cout << "Your events are are:" << endl;
    //for (int index = 0; index < eves.size(); index++)
    for (auto& event: eves)
    {
        int index = &event - &eves[0];
        cout << index +1 << ". ";
        cout << event;
    }*/
    UI::print_user_file_menu();
    int file_option;
    cout << "option > ";
    cin >> file_option;
    cin.ignore();
    switch(file_option)
    {
        case 1:
            ShellExecute(NULL, "open", "D:/facultate/oop/a67-octaviaah/ui/event_list.html", NULL, NULL, SW_SHOWNORMAL);
        break;
        case 2:
            ShellExecute( NULL, "open", "D:/facultate/oop/a67-octaviaah/ui/event_list.csv", NULL, NULL, SW_SHOWNORMAL);
        break;
    }
}


void UI::display_month()
{
    FileManager* tfm = new FileManagerText();
    FileManager* htfm = new FileManagerHTML();
    int month;
    cout << "Enter month: ";
    cin >> month;
    cin.ignore();
    vector<Event> eves = this->service.get_repository().get_events();
    if (eves.data() == NULL)
        return;
    if (eves.size() == 0)
    {
        cout << "There are no events in the database!" << endl;
        return;
    }
    vector<Event> filtered_eves = this->service.filter_events_by_month(month);
    if (filtered_eves.size() == 0)
    {
        cout << "There are no events with this month in the database!" << endl;
        return;
    }
    int index = 0;
    while (index < filtered_eves.size())
    {
        cout << index + 1 << ". ";
        cout << filtered_eves[index];
        UI::print_display_user_menu();
        int user_option;
        cout << "option > ";
        //system(std::string("start " + filtered_eves[index].get_link()).c_str());
        cin >> user_option;
        cin.ignore();
        if (user_option == 0)
            break;
        switch(user_option)
        {
            case 1: {
                int result;
                result = this->service.add_event_evlist(filtered_eves[index]);
                if (result == 1) {
                    filtered_eves[index].set_people(filtered_eves[index].get_people()+1);
                    //UI::write_to_file_evlist();
                    tfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.txt");
                    //UI::write_to_file();
                    tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                    //UI::write_to_file_html();
                    htfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.html");
                    tfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.csv");
                    cout << "Event added to event list!" << endl << endl;
                }
            }
            break;
            case 2: {
                int result;
                result = this->service.delete_event_evlist(filtered_eves[index]);
                if (result == 1) {
                    filtered_eves[index].set_people(filtered_eves[index].get_people()-1);
                    //UI::write_to_file_evlist();
                    tfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.txt");
                    //UI::write_to_file();
                    tfm->write_to_file(this->service.get_repository().get_events(), "D:/facultate/oop/a67-octaviaah/ui/database.txt");
                    //UI::write_to_file_html();
                    htfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.html");
                    tfm->write_to_file(this->service.get_event_list().get_events(), "D:/facultate/oop/a67-octaviaah/ui/event_list.csv");
                    cout << "Event deleted from the event list!" << endl << endl;
                }
            }
            break;
            case 3:
                index++;
            break;
        }
        if (index == filtered_eves.size())
            index = 0;
    }
}


void UI::start()
{
    //RunTestsDomain::run_tests_domain();
    //RunTestsRepository::run_tests_repo();
    //RunTestsService::run_tests_serv();
    //this->service.initialise();
    //UI::read_from_file();
    //UI::read_from_file_evlist();
    this->service.short_init();
    while (true)
    {
        UI::print_choose_user_menu();
        int option;
        cout << "Enter option: ";
        cin >> option;
        cin.ignore();
        if (option > 2)
            cout << "Invalid option";
        else {
            switch (option) {
                case 1: {
                    while (true) {
                        UI::print_admin_menu();
                        int admin_option;
                        cout << "option > ";
                        cin >> admin_option;
                        cin.ignore();
                        if (admin_option == 0)
                            break;
                        if (admin_option > 4)
                            cout << "Invalid admin option";
                        else {
                            switch (admin_option) {
                                case 1:
                                    this->add_ui();
                                    break;
                                case 2:
                                    this->delete_ui();
                                    break;
                                case 3:
                                    this->update_ui();
                                    break;
                                case 4:
                                    this->display();
                            }
                        }
                    }
                }
                    break;
                case 2:
                    while (true) {
                        UI::print_user_menu();
                        int du_option;
                        cout << "option > ";
                        cin >> du_option;
                        cin.ignore();
                        if (du_option == 0)
                            break;
                        if (du_option > 2)
                            cout << "Invalid display option";
                        else {
                            switch (du_option) {
                                case 1:
                                    this->display_month();
                                    break;
                                case 2:
                                    this->display_event_list();
                            }
                        }
                    }
                    break;
                case 0:
                    exit(0);
            }
        }
    }
}
