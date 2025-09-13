#include "printhandler.h"
#include <QTextTable>
#include <QTextFrame>

PrintHandler::PrintHandler(QObject *parent)
    : QObject{parent}
{
    printer = new QPrinter(QPrinter::ScreenResolution);
    // printer->setResolution(600);
    printer->setPageSize(QPageSize::A4);
    printer->setPageOrientation(QPageLayout::Portrait);
    printer->setPageMargins(QMarginsF(2.5, 2., 2., 2.), QPageLayout::Millimeter);
    printer->setFullPage(true);
    // printer->setOutputFormat(QPrinter::PdfFormat);
    // printer->setOutputFileName("test.pdf");
}

void PrintHandler::print(int _orderId)
{
    QPrintDialog* dialog = new QPrintDialog(printer);
    if(dialog->exec() == QDialog::Accepted){
        // printer = dialog->printer();
        this->printRequest(_orderId);
    }
}

void PrintHandler::printRequest(int _orderId)
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

    orderModel.fetchData(_orderId);
    // QString customerId = orderModel.data(orderModel.index(0, 1), Qt::DisplayRole).toString();
    // QString companyName = orderModel.data(orderModel.index(0, 9), Qt::DisplayRole).toString();
    // QString address = orderModel.data(orderModel.index(0, 10), Qt::DisplayRole).toString();
    // QString city = orderModel.data(orderModel.index(0, 11), Qt::DisplayRole).toString();
    // QString postalCode = orderModel.data(orderModel.index(0, 12), Qt::DisplayRole).toString();
    // QString country = orderModel.data(orderModel.index(0, 13), Qt::DisplayRole).toString();

    // QString shipName = orderModel.data(orderModel.index(0, 4), Qt::DisplayRole).toString();
    // QString shipAddress = orderModel.data(orderModel.index(0, 5), Qt::DisplayRole).toString();
    // QString shipCity = orderModel.data(orderModel.index(0, 6), Qt::DisplayRole).toString();
    // QString shipPostalCode = orderModel.data(orderModel.index(0, 7), Qt::DisplayRole).toString();
    // QString shipCountry = orderModel.data(orderModel.index(0, 8), Qt::DisplayRole).toString();

    // QString shipVia = orderModel.data(orderModel.index(0, 15), Qt::DisplayRole).toString();
    // QString shipperPhone = orderModel.data(orderModel.index(0, 16), Qt::DisplayRole).toString();

    QString orderDate = orderModel.data(orderModel.index(0, 2), Qt::DisplayRole).toDate().toString("dd-MM-yyyy");
    // QString salePerson = orderModel.data(orderModel.index(0, 14), Qt::DisplayRole).toString();

    QString freight = orderModel.data(orderModel.index(0, 3), Qt::DisplayRole).toString();
    cursor->setBlockFormat(rightAlignment);
    cursor->insertText("Order No: ", defaultTextFormat);
    cursor->insertText(QString("%1").arg(_orderId), boldFormat);
    cursor->insertBlock();
    cursor->insertText("Order Date: ", defaultTextFormat);
    cursor->insertText(orderDate, italicFormat);
    cursor->insertBlock();
    cursor->setBlockFormat(defaultBlockFormat);
    cursor->insertText("Freight: ", defaultTextFormat);
    cursor->insertText(freight, italicFormat);
    cursor->insertText("(g)", italicFormat);
    cursor->insertBlock();
    QTextFrameFormat line;
    line.setHeight(10);
    line.setWidth(2350);
    line.setBackground(Qt::black);
    cursor->insertFrame(line);

    // QTextFrameFormat frameFormat;
    // frameFormat.setMargin(0);
    // frameFormat.setPadding(8);
    // frameFormat.setBorder(1);
    // cursor->insertFrame(frameFormat);

    // QTextBlockFormat centerFormat;
    // centerFormat.setAlignment(Qt::AlignCenter);
    // cursor->insertBlock(centerFormat);
    // cursor->insertText("This text is centered horizontally and visually centered vertically.");
    // cursor->insertBlock();

    // cursor->movePosition(QTextCursor::NextBlock);
    // cursor->insertBlock(); // new paragraph after the line
    // cursor->insertText("Outside");

    /*
     print out Order Detail table
    */
    cursor->insertBlock(defaultBlockFormat);
    cursor->insertBlock(defaultBlockFormat);

    orderDetailModel.fetchData(_orderId);

    // table header texts
    QList<QString> headers = {"No", "Product Name", "Unit Price ($)", "Quantity", "Discount (%)", "Total Price ($)"};
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

    // table number of rows and columns
    int tableRow = orderDetailModel.rowCount() + 1;    // +1 for table header
    int tableCol = orderDetailModel.columnCount() + 1; // +1 for table order number

    // insert table to document
    QTextTable* table = cursor->insertTable(tableRow, tableCol, *tbformat);



    // print table header
    for(auto col=0; col<table->columns(); col++){
        QTextTableCell headerCell = table->cellAt(0, col); // get each cell of the header
        QTextCharFormat charFormat;// = headerCell.format();
        charFormat.setBackground(Qt::lightGray); // Set background color
        charFormat.setFontWeight(QFont::Bold); // Make text bold
        headerCell.setFormat(charFormat);
        cursor->setBlockFormat(centerAlignment);
        cursor->insertText(headers[col]);
        cursor->movePosition(QTextCursor::NextCell);
    }

    // print table body
    for (auto row = 1; row < table->rows(); row++){
        cursor->setBlockFormat(centerAlignment);
        cursor->insertText(QString("%1").arg(row));
        cursor->movePosition(QTextCursor::NextCell);
        for (auto col = 1; col < table->columns(); col++){
            QString text = orderDetailModel.data(orderDetailModel.index(row-1, col-1), Qt::DisplayRole).toString();
            if(col>1) cursor->setBlockFormat(rightAlignment);
            cursor->insertText(text);
            cursor->movePosition(QTextCursor::NextCell);
        }
    }

    // export document to printer
    document->print(printer);
}

