#ifndef ORDERDETAILMODEL_H
#define ORDERDETAILMODEL_H

#include <QSqlQueryModel>
#include <QObject>
#include <QQmlEngine>

#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QSqlRecord>

class OrderDetailModel : public QSqlQueryModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit OrderDetailModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    double getGrandTotal() const;

public slots:
    void fetchData(int _orderId);
    double getGrandTotal(int _orderId);

};

#endif // ORDERDETAILMODEL_H
