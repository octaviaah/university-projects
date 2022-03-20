//
// Created by Expert on 5/6/2021.
//

#include "table_model.h"
#include <qbrush.h>
#include <qcolor.h>

TableModel::~TableModel() noexcept {}

int TableModel::rowCount(const QModelIndex &parent) const {
    return this->serv.get_repository().get_events().size();
}

int TableModel::columnCount(const QModelIndex &parent) const {
    return 5;
}

QVariant TableModel::data(const QModelIndex& index, int role) const{
    if(index.row() >= this->serv.get_event_list().get_events().size()) return QVariant();
    auto event = this->serv.get_event_list().get_events()[index.row()];
    if (role == Qt::DisplayRole || role == Qt::EditRole)
    {
        switch(index.column())
        {
            case 0:
                return QString::fromStdString(event.get_title());
            case 1:
                return QString::fromStdString(event.get_description());
            case 2: {
                string date = to_string(event.get_date_time().tm_mday) + "." + to_string(event.get_date_time().tm_mon) + "." + to_string(event.get_date_time().tm_year) + " " + to_string(event.get_date_time().tm_hour) + ":" + to_string(event.get_date_time().tm_min);
                return QString::fromStdString(date);
            }
            case 3:
                return QString::number(event.get_people());
            case 4:
                return QString::fromStdString(event.get_link());
            default:
                break;
        }
    }
    return QVariant();
}

QVariant TableModel::headerData(int section, Qt::Orientation orientation, int role) const {
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch(section)
            {
                case 0:
                    return QString{ "Title" };
                case 1:
                    return QString{ "Description" };
                case 2:
                    return QString{ "Date and time" };
                case 3:
                    return QString{ "Number of people" };
                case 4:
                    return QString{ "Link" };
                default:
                    break;
            }
        }
    }
    return QVariant();
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || role != Qt::EditRole)
        return false;
    int row = index.row();
    int col = index.column();

    Event &ev = this->serv.get_repository().get_events()[index.row()];

    if (role == Qt::EditRole)
    {
        switch(col)
        {
            case 0: break;
            case 1: break;
            case 2: break;
            case 3: {
                std::string people{value.toString().toStdString()};
                ev.set_people(stoi(people));
                break;
            }
            case 4: break;
        }
    }
    emit dataChanged(index, index);
    return true;

}

Qt::ItemFlags TableModel::flags(const QModelIndex & index) const{
    int col = index.column();
    if (col == 0)
        return Qt::ItemFlags{};
    return Qt::ItemFlags{};
}
