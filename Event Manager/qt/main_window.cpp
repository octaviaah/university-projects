//
// Created by Expert on 5/6/2021.
//

// You may need to build the project (run Qt uic code generator) to get "ui_main_windo.h" resolved

#include "main_window.h"
#include "ui_main_window.h"
#include <QPushButton>
#include <QCoreApplication>
#include <QListView>
#include <QStringListModel>
#include <string>
#include <QMessageBox>
#include <QPlainTextEdit>
#include <QTextEdit>
#include <QListWidget>
#include <QSortFilterProxyModel>
#include <QTableView>
#include "file_manager.h"
#include "event.h"
#include "table_model.h"
#include <QtCharts>

MainWindow::MainWindow(Service &serv, QWidget *parent):
        QMainWindow(parent), ui(new Ui::MainWindow), serv(serv) {
    ui->setupUi(this);
    this->ok1 = false; this->ok2 = false;

    this->main_widget = new QWidget(this);
    QPushButton *admin = new QPushButton(main_widget);
    admin->setText(tr("Administrator mode"));
    admin->setGeometry(QRect(QPoint(100, 50), QSize(200, 50)));
    this->serv.short_init();

    QPushButton *user = new QPushButton(main_widget);
    user->setText("User mode");
    user->setGeometry(QRect(QPoint(100, 125), QSize(200, 50)));

    QPushButton *chart = new QPushButton(main_widget);
    chart->setText("See chart");
    chart->setGeometry(QRect(QPoint(100, 200), QSize(200, 50)));
    setCentralWidget(main_widget);

    connect(admin, &QPushButton::clicked, this, [this](){
        QWidget* wdg = this->init_admin_gui();
        wdg->show();
    });

    connect(user, &QPushButton::clicked, this, [this](){
        QWidget* wdg = this->init_user_gui();
        wdg->show();
    });

    connect(chart, &QPushButton::clicked, this, [this](){
        QWidget* wdg = this->init_chart();
        wdg->show();
    });

}

MainWindow::~MainWindow() {
    delete ui;
}

QWidget* MainWindow::init_admin_gui() {
    QWidget* wdg = new QWidget();
    wdg->setFixedSize(800, 750);

    QListView* lv = this->build_list(wdg, this->serv.get_repository().get_events());
    lv->setGeometry(QRect(QPoint(0, 0), QSize(800, 400)));

    FileManager* tfm = new FileManagerText();
    QPlainTextEdit* title = new QPlainTextEdit(wdg);
    title->document()->setPlainText("Title");
    title->setGeometry(QRect(QPoint(80, 505), QSize(300, 30)));

    QPlainTextEdit* description = new QPlainTextEdit(wdg);
    description->document()->setPlainText("Description");
    description->setGeometry(QRect(QPoint(80+350, 505), QSize(300, 30)));

    QPlainTextEdit* day = new QPlainTextEdit(wdg);
    day->document()->setPlainText("Day");
    day->setGeometry(QRect(QPoint(80, 505+50), QSize(200, 30)));

    QPlainTextEdit* month = new QPlainTextEdit(wdg);
    month->document()->setPlainText("Month");
    month->setGeometry(QRect(QPoint(80+225, 505+50), QSize(200, 30)));

    QPlainTextEdit* year = new QPlainTextEdit(wdg);
    year->document()->setPlainText("Year");
    year->setGeometry(QRect(QPoint(80+450, 505+50), QSize(200, 30)));

    QPlainTextEdit* hour = new QPlainTextEdit(wdg);
    hour->document()->setPlainText("Hour");
    hour->setGeometry(QRect(QPoint(80, 505+100), QSize(300, 30)));

    QPlainTextEdit* min = new QPlainTextEdit(wdg);
    min->document()->setPlainText("Minutes");
    min->setGeometry(QRect(QPoint(80+350, 505+100), QSize(300, 30)));

    QPlainTextEdit* people = new QPlainTextEdit(wdg);
    people->document()->setPlainText("Number of people");
    people->setGeometry(QRect(QPoint(80, 505+150), QSize(300, 30)));

    QPlainTextEdit* link = new QPlainTextEdit(wdg);
    link->document()->setPlainText("Link");
    link->setGeometry(QRect(QPoint(80+350, 505+150), QSize(300, 30)));

    QPushButton *undo_button = new QPushButton(wdg);
    undo_button->setText("Undo");
    undo_button->setGeometry(QRect(QPoint(80+450, 425), QSize(50, 50)));

    QShortcut *undo_shortcut = new QShortcut(QKeySequence(tr("Ctrl+Z", "Undo")), wdg);

    connect(undo_button, &QPushButton::clicked,this, [this, lv, tfm](){
        this->serv.undo();
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    connect(undo_shortcut, &QShortcut::activated, this, [this, lv, tfm](){
        this->serv.undo();
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    QPushButton* redo_button = new QPushButton(wdg);
    redo_button->setText("Redo");
    redo_button->setGeometry(QRect(QPoint(80+600, 425), QSize(50, 50)));

    QShortcut *redo_shortcut = new QShortcut(QKeySequence(tr("Ctrl+Y", "Redo")), wdg);

    connect(redo_button, &QPushButton::clicked, this, [this, lv, tfm](){
        this->serv.redo();
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    connect(redo_shortcut, &QShortcut::activated, this, [this, lv, tfm](){
        this->serv.redo();
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    QPushButton * addbutton = new QPushButton(wdg);
    addbutton->setText("Add");
    addbutton->setGeometry(QRect(QPoint(80+0, 425), QSize(50, 50)));

    connect(addbutton, &QPushButton::clicked, this, [tfm, wdg, lv, title, description, day, month, year, hour, min, people, link, this](){
        struct tm date_time;
        date_time.tm_mday = stoi(day->toPlainText().toUtf8().constData()); date_time.tm_mon = stoi(month->toPlainText().toUtf8().constData()); date_time.tm_year = stoi(year->toPlainText().toUtf8().constData());
        date_time.tm_hour = stoi(hour->toPlainText().toUtf8().constData()); date_time.tm_min = stoi(min->toPlainText().toUtf8().constData());
        this->serv.add_event_serv(title->toPlainText().toUtf8().constData(), description->toPlainText().toUtf8().constData(), date_time, stoi(people->toPlainText().toUtf8().constData()), link->toPlainText().toUtf8().constData());


        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    QPushButton *delbutton = new QPushButton(wdg);
    delbutton->setText("Delete");
    delbutton->setGeometry(QRect(QPoint(80+150, 425), QSize(50, 50)));

    connect(delbutton, &QPushButton::clicked, this, [tfm, wdg, lv, this](){
        QModelIndex index = lv->currentIndex();
        this->serv.delete_event_serv(this->serv.get_repository().get_events()[index.row()].get_title());
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    QPushButton* updatebutton = new QPushButton(wdg);
    updatebutton->setText("Update");
    updatebutton->setGeometry(QRect(QPoint(80+300, 425), QSize(50, 50)));

    connect(updatebutton, &QPushButton::clicked, this, [tfm, wdg, lv, title, description, day, month, year, hour, min, people, link, this](){
        QModelIndex index = lv->currentIndex();
        struct tm date_time;
        date_time.tm_min = stoi(min->toPlainText().toUtf8().constData());
        date_time.tm_mon = stoi(month->toPlainText().toUtf8().constData());
        date_time.tm_year = stoi(year->toPlainText().toUtf8().constData());
        date_time.tm_hour = stoi(hour->toPlainText().toUtf8().constData());
        date_time.tm_mday = stoi(day->toPlainText().toUtf8().constData());
        this->serv.update_event_serv(this->serv.get_repository().get_events()[index.row()].get_title(), title->toPlainText().toUtf8().constData(), description->toPlainText().toUtf8().constData(), date_time, stoi(people->toPlainText().toUtf8().constData()), link->toPlainText().toUtf8().constData());
        /*this->serv.update_event_title_serv(this->serv.get_repository().get_events()[index.row()].get_title(), title->toPlainText().toUtf8().constData());
        this->serv.update_event_description_serv(this->serv.get_repository().get_events()[index.row()].get_title(), description->toPlainText().toUtf8().constData());
        this->serv.update_event_date_time_serv(this->serv.get_repository().get_events()[index.row()].get_title(), date_time);
        this->serv.update_event_people_serv(this->serv.get_repository().get_events()[index.row()].get_title(), stoi(people->toPlainText().toUtf8().constData()));
        this->serv.update_event_link_serv(this->serv.get_repository().get_events()[index.row()].get_title(), link->toPlainText().toUtf8().constData());*/
        lv->setModel(this->build_model(this->serv.get_repository().get_events()));
        tfm->write_to_file(this->serv.get_repository().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/database.txt");
    });

    return wdg;
}

QStringListModel* MainWindow::build_model(const vector<Event> &vect) {
    QStringListModel* model = new QStringListModel(this);
    QStringList list;
    for (int i=0; i<vect.size(); i++)
    {
        string current = vect[i].get_title() + " - " + vect[i].get_description() + " - " + to_string(vect[i].get_date_time().tm_mday) + "." + to_string(vect[i].get_date_time().tm_mon) + "." + to_string(vect[i].get_date_time().tm_year) + " " + to_string(vect[i].get_date_time().tm_hour) + ":" + to_string(vect[i].get_date_time().tm_min) + " - " + to_string(vect[i].get_people()) + " - " + vect[i].get_link();
        list << current.c_str();
    }

    model->setStringList(list);
    return model;
}

QListView* MainWindow::build_list(QWidget *wdg, const vector<Event> &vect) {
    QListView *listView = new QListView(wdg);
    QStringListModel *model = new QStringListModel(this);
    QStringList list;
    listView->setEditTriggers(QAbstractItemView::NoEditTriggers);

    for (int i=0; i<vect.size(); i++)
    {
        string current = vect[i].get_title() + " - " + vect[i].get_description() + " - " + to_string(vect[i].get_date_time().tm_mday) + "." + to_string(vect[i].get_date_time().tm_mon) + "." + to_string(vect[i].get_date_time().tm_year) + " " + to_string(vect[i].get_date_time().tm_hour) + ":" + to_string(vect[i].get_date_time().tm_min) + " - " + to_string(vect[i].get_people()) + " - " + vect[i].get_link();
        list << current.c_str();
    }

    model->setStringList(list);
    listView->setModel(model);

    return listView;
}

QWidget* MainWindow::init_user_gui() {
    QWidget* wdg = new QWidget();
    wdg->setFixedSize(1050, 875);

    QListView* ulv = this->build_list(wdg, this->serv.get_event_list().get_events());
    ulv->setGeometry(QRect(QPoint(550, 0), QSize(500, 300)));

    QTableView* tableView = new QTableView(wdg);
    tableView->setGeometry(QRect(QPoint(0, 475), QSize(1050, 400)));
    TableModel* tableModel = new TableModel(this->serv);
    tableView->setModel(tableModel);
    tableView->resizeColumnsToContents();

    QListView* filtrdlv = this->build_list(wdg, this->serv.get_repository().get_events());
    filtrdlv->setGeometry(QRect(QPoint(0, 0), QSize(500, 300)));

    FileManager* tfm = new FileManagerText();
    FileManager* htfm = new FileManagerHTML();

    QPlainTextEdit* month = new QPlainTextEdit(wdg);
    month->document()->setPlainText("Month");
    month->setGeometry(QRect(QPoint(130, 405), QSize(255, 30)));

    QPushButton* signbutton = new QPushButton(wdg);
    signbutton->setText("Sign up");
    signbutton->setGeometry((QRect(QPoint(130, 325), QSize(50, 50))));

    connect(signbutton, &QPushButton::clicked, this, [tableView, tfm, htfm, ulv, filtrdlv, month, this](){
        QModelIndex index = filtrdlv->currentIndex();
        auto ev = this->serv.filter_events_by_month(stoi(month->toPlainText().toUtf8().constData()))[index.row()];
        this->serv.add_event_evlist(ev);
        ulv->setModel(this->build_model(this->serv.get_event_list().get_events()));
        tfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.txt");
        htfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.html");
        tfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.csv");

        TableModel* tableModel = new TableModel(this->serv);
        tableView->setModel(tableModel);
    });

    QPushButton * filterbutton = new QPushButton(wdg);
    filterbutton->setText("Filter");
    filterbutton->setGeometry(QRect(QPoint(130+205, 325), QSize(50, 50)));

    connect(filterbutton, &QPushButton::clicked, this, [filtrdlv, month, this](){
        filtrdlv->setModel(this->build_model(this->serv.filter_events_by_month(stoi(month->toPlainText().toUtf8().constData()))));
    });

    QPushButton* deletebutton = new QPushButton(wdg);
    deletebutton->setText("Delete");
    deletebutton->setGeometry(QRect(QPoint(130+630, 325), QSize(50, 50)));

    connect(deletebutton, &QPushButton::clicked, this, [tfm, htfm, ulv, tableView, this](){
        QModelIndex index = ulv->currentIndex();
        this->serv.delete_event_evlist(this->serv.get_event_list().get_events()[index.row()]);
        ulv->setModel(this->build_model(this->serv.get_event_list().get_events()));
        tfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.txt");
        tfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.csv");
        htfm->write_to_file(this->serv.get_event_list().get_events(), "D:/facultate/oop/a10-octaviaah-1/ui/event_list.html");

        TableModel* tableModel = new TableModel(this->serv);
        tableView->setModel(tableModel);
    });

    return wdg;
}

QWidget* MainWindow::init_chart() {
    string str[20];
    int times[20];
    for (int i=0; i<19; i++)
        times[i] = 0;
    str[0] = this->serv.get_repository().get_events()[0].get_description();
    times[0] = 1;
    int len_str = 1;
    for (int i=1; i<this->serv.get_repository().get_events().size(); i++)
    {
        int found = 0;
        for (int j = 0; j<len_str; j++)
            if (str[j] == this->serv.get_repository().get_events()[i].get_description())
            {
                times[j]++;
                found = 1;
                break;
            }
        if (found == 0) {
            str[len_str] = this->serv.get_repository().get_events()[i].get_description();
            times[len_str] = 1;
            len_str++;
        }
    }
    QBarCategoryAxis *axisX = new QBarCategoryAxis();
    QChart *chart = new QChart();
    QValueAxis *axisY = new QValueAxis();
    axisY->setRange(0,4);
    chart->setTitle("Simple barchart example");
    chart->setAnimationOptions(QChart::SeriesAnimations);
    chart->addAxis(axisX, Qt::AlignBottom);
    chart->addAxis(axisY, Qt::AlignLeft);
    QStackedBarSeries *series = new QStackedBarSeries();

    for (int i=0; i<len_str; i++)
    {
        QBarSet *set = new QBarSet(QString::fromStdString(str[i]));
        int aux = i;
        while (aux != 0)
        {
            *set << 0;
            aux--;
        }
        *set << times[i];
        series->append(set);
        QString category;
        category =  QString::fromStdString(str[i]);
        chart->addSeries(series);
        axisX->append(category);
        series->attachAxis(axisX);
        series->attachAxis(axisY);

    }

    chart->legend()->setVisible(true);
    chart->legend()->setAlignment(Qt::AlignBottom);

    QChartView *chartView = new QChartView(chart);
    chartView->setRenderHint(QPainter::Antialiasing);
    chartView->setFixedSize(1250, 750);

    return chartView;
}