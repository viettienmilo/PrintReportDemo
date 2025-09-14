import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import PrintReportDemo

Window {
    id: window
    minimumWidth: 1000
    minimumHeight: 550
    visible: true
    title: qsTr("Print Report Demo")

    property int currentOrderId
    property real currentGrandTotal

    Connections {
        target: OrderModel
        function onModelReset() {
            window.currentOrderId = OrderModel.data(OrderModel.index(0, 0))

            customerIdField.text = OrderModel.data(OrderModel.index(0, 1))
            companyNameField.text = OrderModel.data(OrderModel.index(0, 9))
            addressField.text = OrderModel.data(OrderModel.index(0, 10))
            cityField.text = OrderModel.data(OrderModel.index(0, 11))
            postalCodeField.text = OrderModel.data(OrderModel.index(0, 12))
            countryField.text = OrderModel.data(OrderModel.index(0, 13))

            shipNameField.text = OrderModel.data(OrderModel.index(0, 4))
            shipAddressField.text = OrderModel.data(OrderModel.index(0, 5))
            shipCityField.text = OrderModel.data(OrderModel.index(0, 6))
            shipPostalCodeField.text = OrderModel.data(OrderModel.index(0, 7))
            shipCountryField.text = OrderModel.data(OrderModel.index(0, 8))

            shipViaField.text = OrderModel.data(OrderModel.index(0, 15))
            shipperPhoneField.text = OrderModel.data(OrderModel.index(0, 16))

            orderIdField.text = window.currentOrderId
            orderDateField.text = Qt.formatDateTime(OrderModel.data(OrderModel.index(0, 2)), "dd-MM-yyyy hh:mm")
            salePersonField.text = OrderModel.data(OrderModel.index(0, 14))
            freightField.text = OrderModel.data(OrderModel.index(0, 3))

            OrderDetailModel.fetchData(window.currentOrderId)
            window.currentGrandTotal = OrderDetailModel.getGrandTotal(window.currentOrderId)
        }
    }

    ColumnLayout {
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 25
            topMargin: 60
        }
        spacing: 15

        ColumnLayout {
            spacing: -5
            Label {
                text: qsTr("Customer Info")
                horizontalAlignment: Text.AlignLeft
                font {
                    underline: true
                    pointSize: 10
                    bold: true
                }
                Layout.preferredWidth: 100
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Customer ID:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: customerIdField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Company Name:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: companyNameField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Address:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: addressField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("City:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: cityField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Postal Code:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: postalCodeField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Country:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: countryField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }
        }

        ColumnLayout {
            spacing: -5
            Label {
                text: qsTr("Shipping Info")
                horizontalAlignment: Text.AlignLeft
                font {
                    underline: true
                    pointSize: 10
                    bold: true
                }
                Layout.preferredWidth: 100
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Ship Name:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipNameField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Address:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipAddressField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("City:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipCityField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Postal Code:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipPostalCodeField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Country:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipCountryField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }
        }

        ColumnLayout {
            spacing: -5
            Label {
                text: qsTr("Shipper Info")
                horizontalAlignment: Text.AlignLeft
                font {
                    underline: true
                    pointSize: 10
                    bold: true
                }
                Layout.preferredWidth: 100
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Ship Via:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipViaField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("Phone:")
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 100
                }

                Label {
                    id: shipperPhoneField
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 3
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 30
                }
            }
        }
    }

    ColumnLayout {
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 400
            topMargin: 60
        }
        spacing: 0
        Label {
            text: qsTr("Order No.")
            font.weight: Font.DemiBold
            font.bold: true
            font.underline: true
            font.pointSize: 10
        }

        RowLayout {
            spacing: 0
            Rectangle {
                color: "#ffffff"
                radius: 8
                border.width: 1
                Label {
                    id: orderIdField
                    text: qsTr("Label")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 11
                    font.italic: true
                    font.bold: true
                }
                Layout.preferredWidth: 100
                Layout.preferredHeight: 50
            }

            ColumnLayout {
                spacing: 0
                RowLayout {
                    spacing: 10
                    Label {
                        text: qsTr("Order Date:")
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 100
                    }

                    Label {
                        id: orderDateField
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 3
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 30
                    }
                }

                RowLayout {
                    spacing: 10
                    Label {
                        text: qsTr("Sale Person:")
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 100
                    }

                    Label {
                        id: salePersonField
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 3
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 30
                    }
                }
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: qsTr("Freight (g):")
                horizontalAlignment: Text.AlignRight
                Layout.preferredWidth: 60
            }

            Label {
                id: freightField
                verticalAlignment: Text.AlignVCenter
                leftPadding: 3
                Layout.preferredWidth: 200
                Layout.preferredHeight: 30
            }
        }
    }

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: 5
            rightMargin: 5
            topMargin: 15
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            spacing: 2
            Label {
                text: qsTr("Order ID:")
            }

            TextField {
                id: orderIdTextField
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                placeholderText: qsTr("Enter OrderID")
                onTextChanged: {
                    let orderid = parseInt(text)
                    if(orderid >= 10248 && orderid <=11077)
                        OrderModel.fetchData(orderid)
                }
                color: parseInt(text)>=10248 ? parseInt(text)<=11077 ? "black" : "red" : "red"
                leftPadding: 3
                Layout.preferredWidth: 200
                Layout.preferredHeight: 30
            }

            RoundButton {
                id: backButton
                radius: 4
                Layout.preferredHeight: 26
                Layout.preferredWidth: 26
                padding: 3
                highlighted: false
                icon.color: "#000000"
                icon.source: Qt.resolvedUrl("icons/back")
                display: AbstractButton.IconOnly
                flat: true
                onClicked: {
                    let orderid = parseInt(orderIdTextField.text)
                    orderid = Math.max(10248, orderid-1)
                    orderIdTextField.text = orderid
                }
            }

            RoundButton {
                id: nextButton
                radius: 4
                Layout.preferredHeight: 26
                Layout.preferredWidth: 26
                padding: 3
                icon.source: Qt.resolvedUrl("icons/forward")
                icon.color: "#000000"
                highlighted: false
                flat: true
                display: AbstractButton.IconOnly
                onClicked: {
                    let orderid = parseInt(orderIdTextField.text)
                    orderid = Math.min(orderid+1, 11077)
                    orderIdTextField.text = orderid
                }
            }

            RoundButton {
                id: printButton
                radius: 4
                padding: 3
                icon.source: Qt.resolvedUrl("icons/printer")
                icon.color: "#000000"
                highlighted: false
                flat: true
                display: AbstractButton.IconOnly
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                onClicked: PrintHandler.print(window.currentOrderId)
            }

            RoundButton {
                id: printPreviewButton
                radius: 4
                padding: 3
                icon.source: Qt.resolvedUrl("icons/preview")
                icon.color: "#000000"
                highlighted: false
                flat: true
                display: AbstractButton.IconOnly
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                onClicked: PrintHandler.printPreview(window.currentOrderId)
            }
        }

        Rectangle {
            color: "#ffffff"
            border.color: "#979797"
            border.width: 1
            Layout.fillWidth: true
            Layout.preferredWidth: 615
            Layout.preferredHeight: 1
        }
    }

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 400
            rightMargin: 20
            topMargin: 190
        }
        spacing: 10
        Label {
            text: qsTr("Order Details:")
            font.weight: Font.DemiBold
            font.underline: true
            font.pointSize: 10
            font.bold: true
        }

        ListView {
            id: orderDetailView
            clip: true
            model: OrderDetailModel

            component HeaderComponent : Rectangle {
                property alias text: header.text
                color: "lightgray"
                border {
                    color: "#808080"
                    width: 1
                }
                Label {
                    id: header
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.styleName: "Semibold"
                }
                height: 40
            }

            property var headers: ["No.", "Product Name", "Unit Price ($)", "Quantity", "Discount (%)", "Total Price ($)"]
            property var headerWidths: [40, -1, 80, 80, 80, 80]

            header: RowLayout {
                width: orderDetailView.width
                spacing: 0

                Repeater {
                    model: orderDetailView.headers
                    HeaderComponent {
                        text: modelData
                        Component.onCompleted: if(index !== 1) Layout.preferredWidth = orderDetailView.headerWidths[index]
                                               else Layout.fillWidth = true
                    }
                }
            }

            component DelegateComponent : Rectangle {
                property alias text: delegate.text
                property alias textHAlignment: delegate.horizontalAlignment
                border {
                    color: "#808080"
                    width: 1
                }
                Label {
                    id: delegate
                    anchors.fill: parent
                    padding: 5
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                height: 40
            }

            delegate: RowLayout {
                width: orderDetailView.width
                spacing: 0

                DelegateComponent {
                    text: model.index + 1
                    Layout.preferredWidth: 40
                    textHAlignment: Qt.AlignHCenter
                }
                DelegateComponent {
                    text: model.ProductName
                    Layout.fillWidth: true
                }
                DelegateComponent {
                    text: model.UnitPrice
                    Layout.preferredWidth: 80
                    textHAlignment: Qt.AlignRight
                }
                DelegateComponent {
                    text: model.Quantity
                    Layout.preferredWidth: 80
                    textHAlignment: Qt.AlignRight
                }
                DelegateComponent {
                    text: model.Discount
                    Layout.preferredWidth: 80
                    textHAlignment: Qt.AlignRight
                }
                DelegateComponent {
                    text: model.TotalPrice
                    Layout.preferredWidth: 80
                    textHAlignment: Qt.AlignRight
                }
            }
            Layout.topMargin: 1
            Layout.rightMargin: 10
            Layout.fillWidth: true
            Layout.preferredHeight: orderDetailView.contentHeight
        }

        RowLayout {
            spacing: 10
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Label {
                text: qsTr("Grand Total:")
                horizontalAlignment: Text.AlignRight
                Layout.preferredWidth: 100
            }

            Label {
                id: grandTotalField
                text: `$${Number(window.currentGrandTotal).toLocaleString(Qt.locale())}`
                font {
                    pointSize: 10
                    bold: true
                    letterSpacing: 1
                }
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                leftPadding: 3
                Layout.preferredWidth: 80
                Layout.preferredHeight: 30
            }
        }
        Item { Layout.fillHeight: true }
    }

    Component.onCompleted: {
        OrderModel.fetchData()
        OrderDetailModel.fetchData(window.currentOrderId)
        window.currentGrandTotal = OrderDetailModel.getGrandTotal(window.currentOrderId)
        orderIdTextField.text = window.currentOrderId
    }
}
