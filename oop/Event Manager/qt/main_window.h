//
// Created by Expert on 5/6/2021.
//

#ifndef A89_OCTAVIAAH_MAIN_WINDOW_H
#define A89_OCTAVIAAH_MAIN_WINDOW_H

#include <QMainWindow>
#include <iostream>
#include <QWidget>
#include "event.h"
#include <QListView>
#include "service.h"
#include <QStringListModel>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow {
Q_OBJECT

public:
    MainWindow(Service &serv, QWidget *parent=0);
    ~MainWindow();

    QWidget* init_admin_gui();
    QWidget* init_user_gui();
    QWidget* init_chart();

    QListView* build_list(QWidget *wdg, const vector<Event> &vect);
    QStringListModel* build_model(const vector<Event> &vect);

private:
    Ui::MainWindow *ui;
    QWidget* main_widget;
    Service& serv;
    bool ok1, ok2;
};

#endif //A89_OCTAVIAAH_MAIN_WINDOW_H
