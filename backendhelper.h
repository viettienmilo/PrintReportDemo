#ifndef BACKENDHELPER_H
#define BACKENDHELPER_H

#include <QSqlDatabase>
#include <QSqlError>

static bool openDatabase(){
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setDatabaseName("northwind");
    db.setHostName("localhost");
    db.setUserName("root");
    db.setPassword("12345");
    return db.open();
}

#endif // BACKENDHELPER_H
