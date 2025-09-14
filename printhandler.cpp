#include "printhandler.h"
#include <QTextTable>
#include <QTextFrame>

PrintHandler::PrintHandler(QObject *parent)
    : QObject{parent}
{
    printer = new QPrinter(QPrinter::PrinterResolution);
    // printer->setResolution(72);
    printer->setPageSize(QPageSize::A4);
    printer->setPageOrientation(QPageLayout::Portrait);
    printer->setPageMargins(QMarginsF(0, 0, 0, 0), QPageLayout::Inch);
    // printer->setFullPage(true);
    printer->setOutputFormat(QPrinter::NativeFormat);
}

void PrintHandler::print(int _orderId)
{
    orderID = _orderId;

    QPrintDialog* dialog = new QPrintDialog(printer);
    if(dialog->exec() == QDialog::Accepted){
        // if (printer.outputFormat() == QPrinter::NativeFormat &&
        //         printer.printerName().contains("PDF", Qt::CaseInsensitive)) {
        // printer->setOutputFileName(QString("%1.pdf").arg(orderID));
        // }
        this->printRequest();
    }
}

void PrintHandler::printPreview(int _orderId)
{
    orderID = _orderId;
    QPrintPreviewDialog* previewDialog = new QPrintPreviewDialog(printer, nullptr, Qt::Window);
    connect(previewDialog, &QPrintPreviewDialog::paintRequested, this, &PrintHandler::printPreviewRequest);
    previewDialog->setModal(true);
    previewDialog->showMaximized();
}

void PrintHandler::createReportDocument()
{
    document = new QTextDocument();
    QTextCursor* cursor = new QTextCursor(document);

    // text default format
    QTextCharFormat defaultTextFormat;
    QTextBlockFormat defaultBlockFormat;
    // text alignment format
    QTextBlockFormat centerAlignment;
    centerAlignment.setAlignment(Qt::AlignCenter);
    QTextBlockFormat rightAlignment;
    rightAlignment.setAlignment(Qt::AlignRight);
    // text font format
    QTextCharFormat boldFormat;
    boldFormat.setFontWeight(QFont::Bold);
    QTextCharFormat italicFormat;
    italicFormat.setFontItalic(true);

    /*
     print out Order table
    */

    orderModel.fetchData(orderID);
    QString customerId = orderModel.data(orderModel.index(0, 1), Qt::DisplayRole).toString();
    QString companyName = orderModel.data(orderModel.index(0, 9), Qt::DisplayRole).toString();
    QString address = orderModel.data(orderModel.index(0, 10), Qt::DisplayRole).toString();
    QString city = orderModel.data(orderModel.index(0, 11), Qt::DisplayRole).toString();
    QString postalCode = orderModel.data(orderModel.index(0, 12), Qt::DisplayRole).toString();
    QString country = orderModel.data(orderModel.index(0, 13), Qt::DisplayRole).toString();

    QString shipName = orderModel.data(orderModel.index(0, 4), Qt::DisplayRole).toString();
    QString shipAddress = orderModel.data(orderModel.index(0, 5), Qt::DisplayRole).toString();
    QString shipCity = orderModel.data(orderModel.index(0, 6), Qt::DisplayRole).toString();
    QString shipPostalCode = orderModel.data(orderModel.index(0, 7), Qt::DisplayRole).toString();
    QString shipCountry = orderModel.data(orderModel.index(0, 8), Qt::DisplayRole).toString();

    QString shipVia = orderModel.data(orderModel.index(0, 15), Qt::DisplayRole).toString();
    QString shipperPhone = orderModel.data(orderModel.index(0, 16), Qt::DisplayRole).toString();

    QString orderDate = orderModel.data(orderModel.index(0, 2), Qt::DisplayRole).toDate().toString("dd-MM-yyyy");
    QString salePerson = orderModel.data(orderModel.index(0, 14), Qt::DisplayRole).toString();

    QString freight = orderModel.data(orderModel.index(0, 3), Qt::DisplayRole).toString();

    // cursor->setBlockFormat(rightAlignment);
    QTextFrameFormat rect;
    rect.setMargin(0);
    rect.setPadding(8);
    rect.setBorder(1);
    rect.setPosition(QTextFrameFormat::FloatRight);
    rect.setWidth(QTextLength(QTextLength::FixedLength, 150));
    cursor->insertFrame(rect);
    cursor->setBlockFormat(rightAlignment);
    cursor->insertText("Order No: ", defaultTextFormat);
    cursor->insertText(QString("%1").arg(orderID), boldFormat);
    cursor->insertBlock();
    cursor->insertText("Order Date: ", defaultTextFormat);
    cursor->insertText(orderDate, italicFormat);
    cursor->movePosition(QTextCursor::NextBlock);

    cursor->insertBlock();
    cursor->setBlockFormat(defaultBlockFormat);
    cursor->insertText("Customer ID: ", defaultTextFormat);
    cursor->insertText(customerId, italicFormat);
    cursor->insertBlock();
    cursor->insertText("Customer Name: ", defaultTextFormat);
    cursor->insertText(companyName, boldFormat);
    cursor->insertBlock();
    cursor->insertText("Address: ", defaultTextFormat);
    cursor->insertText(address, italicFormat);
    cursor->insertBlock();
    cursor->insertText("City: ", defaultTextFormat);
    cursor->insertText(city, italicFormat);
    cursor->insertText("  /  Postal code: ", defaultTextFormat);
    cursor->insertText(postalCode, italicFormat);
    cursor->insertBlock();
    cursor->insertText("Country: ", defaultTextFormat);
    cursor->insertText(country, italicFormat);
    cursor->insertBlock();
    cursor->insertText("------------------------------------", defaultTextFormat);
    cursor->insertBlock();
    cursor->insertText("Ship to: ", defaultTextFormat);
    cursor->insertText(shipName, boldFormat);
    cursor->insertBlock();
    cursor->insertText("Address: ", defaultTextFormat);
    cursor->insertText(shipAddress, italicFormat);
    cursor->insertBlock();
    cursor->insertText("City: ", defaultTextFormat);
    cursor->insertText(shipCity, italicFormat);
    cursor->insertText("  /  Postal code: ", defaultTextFormat);
    cursor->insertText(shipPostalCode, italicFormat);
    cursor->insertBlock();
    cursor->insertText("Country: ", defaultTextFormat);
    cursor->insertText(shipCountry, italicFormat);
    cursor->insertBlock();
    cursor->insertText("------------------------------------", defaultTextFormat);
    cursor->insertBlock();
    cursor->insertText("Ship Via: ", defaultTextFormat);
    cursor->insertText(shipVia, boldFormat);
    cursor->insertBlock();
    cursor->insertText("Phone: ", defaultTextFormat);
    cursor->insertText(shipperPhone, italicFormat);
    cursor->insertBlock();
    cursor->insertText("Freight: ", defaultTextFormat);
    cursor->insertText(freight, italicFormat);
    cursor->insertText("(g)", italicFormat);
    cursor->insertBlock();
    cursor->insertText("------------------------------------", defaultTextFormat);
    cursor->insertBlock();
    cursor->insertText("Saled by: ", defaultTextFormat);
    cursor->insertText(salePerson, boldFormat);
    cursor->insertBlock();
    QTextFrameFormat hline;
    hline.setHeight(3);
    hline.setWidth(QTextLength(QTextLength::PercentageLength, 100));
    hline.setBackground(Qt::black);
    cursor->insertFrame(hline);
    cursor->movePosition(QTextCursor::NextBlock); // Move cursor out of the frame
    cursor->insertBlock();
    cursor->insertText("Order details: ", boldFormat);
    cursor->insertBlock();

    /*
     print out Order Detail table
    */
    orderDetailModel.fetchData(orderID);
    // table header texts
    QList<QString> headers = {"No.", "Product Name", "Unit Price ($)", "Quantity", "Discount (%)", "Total Price ($)"};
    // table column widths
    QList<QTextLength> column_widths;
    column_widths.append(QTextLength(QTextLength::FixedLength, 40));  // takes remaining space proportionally
    column_widths.append(QTextLength(QTextLength::VariableLength, 1));  // takes remaining space proportionally
    column_widths.append(QTextLength(QTextLength::FixedLength, 80));
    column_widths.append(QTextLength(QTextLength::FixedLength, 80));
    column_widths.append(QTextLength(QTextLength::FixedLength, 80));
    column_widths.append(QTextLength(QTextLength::FixedLength, 80));
    // table format
    QTextTableFormat* tbformat = new QTextTableFormat();
    tbformat->setBorderBrush(QBrush(Qt::SolidPattern));
    tbformat->setBorderStyle(QTextFrameFormat::BorderStyle_Solid);
    tbformat->setCellPadding(5);
    tbformat->setBorder(1.0);
    tbformat->setHeaderRowCount(1);
    tbformat->setColumnWidthConstraints(column_widths);
    tbformat->setHeaderRowCount(1);
    tbformat->setWidth(QTextLength(QTextLength::PercentageLength, 100)); // full page width

    // table number of rows and columns
    int tableRow = orderDetailModel.rowCount() + 1;    // +1 for table header
    int tableCol = orderDetailModel.columnCount() + 1; // +1 for table order number

    // insert table to document
    QTextTable* table = cursor->insertTable(tableRow, tableCol, *tbformat);

    // print table header
    for(auto col=0; col<table->columns(); col++){
        QTextTableCell headerCell = table->cellAt(0, col); // get each cell of the header
        QTextCharFormat charFormat;
        charFormat.setBackground(Qt::lightGray);
        charFormat.setFontWeight(QFont::Bold);
        headerCell.setFormat(charFormat);
        QTextCursor cellCursor = headerCell.firstCursorPosition();
        cellCursor.setBlockFormat(centerAlignment);
        cellCursor.insertText(headers[col], charFormat);
    }

    // print table body
    for (auto row = 1; row < table->rows(); row++){
        QTextTableCell numberCell = table->cellAt(row, 0);
        QTextCursor numberCursor = numberCell.firstCursorPosition();
        numberCursor.setBlockFormat(centerAlignment);
        numberCursor.insertText(QString::number(row));
        for (auto col = 1; col < table->columns(); col++){
            QTextTableCell cell = table->cellAt(row, col);
            QTextCursor cellCursor = cell.firstCursorPosition();
            QString text = orderDetailModel.data(orderDetailModel.index(row-1, col-1), Qt::DisplayRole).toString();
            if(col>1) cellCursor.setBlockFormat(rightAlignment);
            cellCursor.insertText(text);
        }
    }

    // move out of table
    cursor->setPosition(table->lastPosition());
    cursor->movePosition(QTextCursor::NextBlock);

    // print GrandTotal
    double grandTotal = orderDetailModel.getGrandTotal(orderID);
    cursor->insertBlock();
    cursor->setBlockFormat(rightAlignment);
    cursor->insertText("Grand Total:\t", defaultTextFormat);
    cursor->insertText("$", boldFormat);
    cursor->insertText(QString::number(grandTotal, 'f', 2), boldFormat);
    cursor->insertBlock();
}

void PrintHandler::printRequest()
{
    createReportDocument();
    document->print(printer);
}

void PrintHandler::printPreviewRequest()
{
    createReportDocument();
    document->print(printer);
}

