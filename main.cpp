#include <QApplication>
#include <QQmlApplicationEngine>

#include "backendhelper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    if(!openDatabase()){
        qDebug() << "Connection error.";
        return -1;
    }

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
    Qt::QueuedConnection);
    engine.loadFromModule("PrintReportDemo", "Main");

    return app.exec();
}
