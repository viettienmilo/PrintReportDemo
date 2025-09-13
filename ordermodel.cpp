#include "ordermodel.h"


OrderModel::OrderModel()
{
}

QVariant OrderModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) return {};
    if(role < Qt::UserRole) return QSqlQueryModel::data(index, role);
    int colIndex = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), colIndex);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> OrderModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < columnCount(); ++i)
        roles[Qt::UserRole + i] = headerData(i, Qt::Horizontal).toByteArray();
    return roles;
}

void OrderModel::fetchData(int _orderId)
{
    beginResetModel();
    QString queryString{"select o.OrderID, o.CustomerID, o.OrderDate, o.Freight, "
                        "o.ShipName, o.ShipAddress, o.ShipCity, o.ShipPostalCode, o.ShipCountry, "
                        "c.CompanyName, c.Address, c.City, c.PostalCode, c.Country, "
                        "concat(e.FirstName, ' ', e.LastName) as SalePerson, "
                        "s.CompanyName as ShipVia, s.Phone "
                        "from orders o "
                        "inner join customers c on o.CustomerID = c.CustomerID "
                        "inner join employees e on e.EmployeeID = o.EmployeeID "
                        "inner join shippers s on o.ShipVia = s.ShipperID "
                        "where o.OrderID = :orderid"
                       };
    QSqlQuery query;
    query.prepare(queryString);
    query.bindValue(":orderid", _orderId);
    query.exec();

    QSqlQueryModel::setQuery(std::move(query));

    if(this->record().isEmpty()){
        qDebug() << "Empty Model";
    }
    // else{
    //     QSqlRecord rec = this->record(0);

    //     qDebug() << QString("Order (%1): ").arg(rec.value(0).toInt());
    //     for(int i=1; i<rec.count(); i++){
    //         qDebug() << rec.value(i).toString();
    //     }
    // }
    endResetModel();
}
