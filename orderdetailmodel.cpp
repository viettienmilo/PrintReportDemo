#include "orderdetailmodel.h"


OrderDetailModel::OrderDetailModel(QObject *parent)
    : QSqlQueryModel{parent}
{
}

QVariant OrderDetailModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) return {};
    if(role < Qt::UserRole) return QSqlQueryModel::data(index, role);

    int colIndex = role-Qt::UserRole;
    QModelIndex modelIndex = this->index(index.row(), colIndex);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> OrderDetailModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for(int i=0; i<columnCount(); i++){
        roles[Qt::UserRole+i] = headerData(i, Qt::Horizontal).toByteArray();
    }
    return roles;
}

void OrderDetailModel::fetchData(int _orderId)
{
    beginResetModel();
    QString queryString {"select p.ProductName, "
                         "od.UnitPrice, "
                         "od.Quantity, "
                         "od.Discount, "
                         "(od.UnitPrice*od.Quantity*(1-od.Discount)) as TotalPrice "
                         "from `order details` od "
                         "inner join products p on od.ProductID = p.ProductID "
                         "where od.OrderID = :orderid"
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

double OrderDetailModel::getGrandTotal(int _orderId)
{
    QString queryString{"select sum(UnitPrice * Quantity * (1-Discount)) as GrandTotal "
                        "from `order details` "
                        "where OrderID = :orderid "
                        "group by OrderID"
                       };
    QSqlQuery query;
    query.prepare(queryString);
    query.bindValue(":orderid", _orderId);
    query.exec();
    if(query.first())
        return query.value(0).toDouble();
    return 0;
}
