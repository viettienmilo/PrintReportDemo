import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import PrintReportDemo

Window {
    id: window
    minimumWidth: 1000
    minimumHeight: 600
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
        id: columnLayout3
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 25
        anchors.topMargin: 60
        spacing: 15
        ColumnLayout {
            id: columnLayout
            spacing: 0
            Label {
                id: label6
                text: qsTr("Customer Info")
                horizontalAlignment: Text.AlignLeft
                font.underline: true
                font.pointSize: 10
                font.bold: true
                Layout.preferredWidth: 100
            }

            RowLayout {
                id: rowLayout1
                spacing: 10
                Label {
                    id: label
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
                id: rowLayout2
                spacing: 10
                Label {
                    id: label1
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
                id: rowLayout3
                spacing: 10
                Label {
                    id: label2
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
                id: rowLayout4
                spacing: 10
                Label {
                    id: label3
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
                id: rowLayout5
                spacing: 10
                Label {
                    id: label4
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
                id: rowLayout6
                spacing: 10
                Label {
                    id: label5
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
            id: columnLayout1
            spacing: 0
            Label {
                id: label7
                text: qsTr("Shipping Info")
                horizontalAlignment: Text.AlignLeft
                font.underline: true
                font.pointSize: 10
                font.bold: true
                Layout.preferredWidth: 100
            }

            RowLayout {
                id: rowLayout7
                spacing: 10
                Label {
                    id: label8
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
                id: rowLayout8
                spacing: 10
                Label {
                    id: label9
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
                id: rowLayout10
                spacing: 10
                Label {
                    id: label11
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
                id: rowLayout11
                spacing: 10
                Label {
                    id: label12
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
                id: rowLayout12
                spacing: 10
                Label {
                    id: label13
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
            id: columnLayout2
            spacing: 0
            Label {
                id: label10
                text: qsTr("Shipper Info")
                horizontalAlignment: Text.AlignLeft
                font.underline: true
                font.pointSize: 10
                font.bold: true
                Layout.preferredWidth: 100
            }

            RowLayout {
                id: rowLayout9
                spacing: 10
                Label {
                    id: label14
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
                id: rowLayout13
                spacing: 10
                Label {
                    id: label15
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
        id: columnLayout4
        width: 260
        height: 108
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 400
        anchors.topMargin: 60
        spacing: 0
        Label {
            id: label16
            text: qsTr("Order No.")
            font.weight: Font.DemiBold
            font.bold: true
            font.underline: true
            font.pointSize: 10
        }


        RowLayout {
            id: rowLayout16
            x: 0
            y: 23
            spacing: 0
            Rectangle {
                id: rectangle
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
                id: columnLayout5
                spacing: 0
                RowLayout {
                    id: rowLayout14
                    spacing: 10
                    Label {
                        id: label17
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
                    id: rowLayout15
                    spacing: 10
                    Label {
                        id: label18
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
            id: rowLayout17
            spacing: 10
            Label {
                id: label19
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
        id: columnLayout6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 15
        RowLayout {
            id: rowLayout
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
                text: ""
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
                text: "+"
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
            id: rectangle1
            color: "#ffffff"
            border.color: "#979797"
            border.width: 1
            Layout.fillWidth: true
            Layout.preferredWidth: 615
            Layout.preferredHeight: 1
        }
    }



    Component.onCompleted: {
        OrderModel.fetchData()
        OrderDetailModel.fetchData(window.currentOrderId)
        window.currentGrandTotal = OrderDetailModel.getGrandTotal(window.currentOrderId)
        orderIdTextField.text = window.currentOrderId
    }

    ColumnLayout {
        id: columnLayout8
        height: 344
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 400
        anchors.rightMargin: 30
        anchors.topMargin: 190
        ColumnLayout {
            id: columnLayout7
            spacing: 10
            Label {
                id: label20
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
                header: RowLayout {
                    width: orderDetailView.width
                    spacing: 0
                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("No.")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("Product Name")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("Unit Price ($)")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("Quantity")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("Discount (%)")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: qsTr("Total Price ($)")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.styleName: "Semibold"
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }
                }
                delegate: RowLayout {
                    width: orderDetailView.width
                    spacing: 0
                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.index + 1
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.ProductName
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 5
                        }
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.UnitPrice
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            rightPadding: 5
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.Quantity
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            rightPadding: 5
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.Discount
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            rightPadding: 5
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }

                    Rectangle {
                        border.color: "#808080"
                        border.width: 1
                        Label {
                            text: model.TotalPrice
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            rightPadding: 5
                        }
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 40
                    }
                }
                Layout.topMargin: 1
                Layout.rightMargin: 10
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            id: rowLayout18
            Layout.fillHeight: true
            spacing: 10
            Label {
                id: label21
                text: qsTr("Grand Total:")
                horizontalAlignment: Text.AlignRight
                Layout.preferredWidth: 100
            }

            Label {
                id: grandTotalField
                text: `$${Number(window.currentGrandTotal).toLocaleString(Qt.locale())}`
                font.letterSpacing: 1
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                leftPadding: 3
                font.styleName: "Bold"
                font.pointSize: 10
                font.bold: true
                Layout.preferredWidth: 80
                Layout.preferredHeight: 30
            }
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
        }
    }
}
