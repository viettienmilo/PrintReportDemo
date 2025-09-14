#ifndef PRINTHANDLER_H
#define PRINTHANDLER_H

#include <QObject>
#include <QQmlEngine>

#include <QPrinter>
#include <QPrintDialog>
#include <QPrintPreviewDialog>
#include <QTextDocument>
#include <QTextCursor>

#include "ordermodel.h"
#include "orderdetailmodel.h"

class PrintHandler : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit PrintHandler(QObject *parent = nullptr);

public slots:
    void print(int _orderId);
    void printPreview(int _orderId);

private slots:
    void createReportDocument();
    void printRequest();
    void printPreviewRequest();

signals:

private:
    QPrinter* printer;
    QTextDocument* document;
    OrderModel orderModel;
    OrderDetailModel orderDetailModel;
    int orderID;
};

#endif // PRINTHANDLER_H
