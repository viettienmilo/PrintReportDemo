#ifndef ORDERMODEL_H
#define ORDERMODEL_H

#include <QObject>
#include <QQmlEngine>
#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QModelIndex>

class OrderModel : public QSqlQueryModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:

    // enum Roles {
    //     OrderIdRole = Qt::UserRole + 1,
    //     CustomerIdRole,
    //     OrderDateRole,
    //     FreightRole,
    //     ShipNameRole,
    //     ShipAddressRole,
    //     ShipCityRole,
    //     ShipPostalCodeRole,
    //     ShipCountryRole,
    //     CompanyNameRole,
    //     AddressRole,
    //     CityRole,
    //     PostalCodeRole,
    //     CountryRole,
    //     SalePersonRole,
    //     ShipViaRole
    // }

    OrderModel();

    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void fetchData(int _orderId = 10248);

};

#endif // ORDERMODEL_H
