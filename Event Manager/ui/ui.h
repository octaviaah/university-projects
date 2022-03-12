//
// Created by Expert on 3/22/2021.
//

#ifndef A45_OCTAVIAAH_UI_H
#define A45_OCTAVIAAH_UI_H

#include "service.h"

class UI
{
private:
    Service service;
public:
    UI(const Service& serv): service{serv} {};
    void print_choose_user_menu();
    void print_admin_menu();
    void print_user_menu();
    void print_display_user_menu();
    void print_update_submenu();
    void print_user_file_menu();
    void start();
    void add_ui();
    void delete_ui();
    void update_ui();
    void display();
    void display_event_list();
    void display_month();
    
};

#endif //A45_OCTAVIAAH_UI_H
