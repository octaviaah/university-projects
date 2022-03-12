//
// Created by Expert on 5/6/2021.
//

#ifndef A89_OCTAVIAAH_TABLE_MODEL_H
#define A89_OCTAVIAAH_TABLE_MODEL_H

#include <QAbstractItemModel>
#include "service.h"
#include "event.h"

class TableModel: public QAbstractTableModel
{
private:
    Service &serv;
public:
    TableModel(Service &serv) : serv(serv){}
    ~TableModel();
    int rowCount(const QModelIndex& parent = QModelIndex{}) const override;
    int columnCount(const QModelIndex& parent = QModelIndex{}) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;

    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
};

#endif //A89_OCTAVIAAH_TABLE_MODEL_H
