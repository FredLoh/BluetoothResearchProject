//
//  ViewController.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 26/Oct/15.
//  Copyright © 2015 JeongGroup. All rights reserved.
//

import UIKit
import CoreBluetooth
import SnapKit
import Charts

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    let backgroundView = UIView()
    let greenRedView = UIView()
    let scanButton =  UIButton()
    let sendButton = UIButton()
    let messageField = UITextField()
    let messageLabel = UILabel()
    let chartView = LineChartView()
    var months: [String]!
    var unitsSold: [Double]!
    
    // BLE
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    //    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
    var bluetoothAvailable = false
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        chartView.descriptionText = ""
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Test Data")
        let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData
//        chartDataSet.colors = ChartColorTemplates.joyful()
        chartView.xAxis.labelPosition = .Bottom
        chartView.notifyDataSetChanged()
        
    }
    
    func changeChart() {
        print("Changing Chart")
        print(months)
        months.append("Test")
        months.append("Test2")
        unitsSold.append(2.0)
        unitsSold.append(3.0)
        setChart(months, values: unitsSold)
        chartView.notifyDataSetChanged()
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [1.0, 4.0, 6.0, 3.0, 5.0, 8.0, 4.0, 8.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
        scanButton.setTitle("Scan", forState: UIControlState.Normal)
        scanButton.addTarget(self, action: "startScanning", forControlEvents: UIControlEvents.TouchUpInside)
        scanButton.backgroundColor = UIColor.blackColor()
        
        sendButton.setTitle("Send", forState: UIControlState.Normal)
        sendButton.addTarget(self, action: "sendMessage", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton.backgroundColor = UIColor.blackColor()
        
        messageField.textAlignment = .Center
        messageField.autocorrectionType = UITextAutocorrectionType.No
        messageField.borderStyle = .RoundedRect
        
        messageLabel.text = "Message to send"
        greenRedView.backgroundColor = UIColor.redColor()
        
        
        
        
        self.view.addSubview(backgroundView)

        
        backgroundView.addSubview(scanButton)
        backgroundView.addSubview(sendButton)
        backgroundView.addSubview(messageField)
        backgroundView.addSubview(messageLabel)
        backgroundView.addSubview(greenRedView)
        backgroundView.addSubview(chartView)
        
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        scanButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(sendButton.snp_left).offset(-10)
            make.bottom.equalTo(sendButton)
            make.width.height.equalTo(60)
        }
        sendButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageField.snp_bottom)
            make.centerX.equalTo(messageField)
            make.width.height.equalTo(60)
        }
        messageField.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(messageField.snp_top)
            make.centerX.equalTo(messageField)
        }
        greenRedView.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(20)
            make.bottom.equalTo(messageLabel.snp_top).offset(-20)
            make.centerX.equalTo(messageField)
        }
        chartView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(backgroundView)
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(backgroundView).offset(50)
//            make.bottom.equalTo(greenRedView.snp_top).offset(-10)
            make.height.equalTo(200)
        }
    }
    
    func startScanning() {
        print("Started Scanning!")
        //Could add service UUID here to scan for only relevant services
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func sendMessage() {
        if let message = messageField.text {
            let data = message.dataUsingEncoding(NSUTF8StringEncoding)
            if terminalChar != nil {
                peripheral!.writeValue(data!,  forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value was sent")
    }
    
    func discoverDevices() {
        print("Searching for devices")
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("Checking state")
        switch (central.state) {
        case .PoweredOff:
            print("CoreBluetooth BLE hardware is powered off")
            
        case .PoweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            bluetoothAvailable = true;
            
        case .Resetting:
            print("CoreBluetooth BLE hardware is resetting")
            
        case .Unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
            
        case .Unknown:
            print("CoreBluetooth BLE state is unknown");
            
        case .Unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform");
            
        }
        if bluetoothAvailable == true {
            discoverDevices()
        }
    }
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //        print(peripheral)
        let deviceName = "Bluno"
        let deviceName2 = "FredLohMac"
        if let nameOfDeviceFound = peripheral.name {
            if (nameOfDeviceFound == deviceName || nameOfDeviceFound == deviceName2) {
                print("Discovered \(nameOfDeviceFound)")
                print("")
                
                print(peripheral)
                // Stop scanning
//                self.centralManager.stopScan()
//                print("Stopped Scanning")
                // Set as the peripheral to use and establish connection
                self.peripheral = peripheral
                self.peripheral.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
            }
            else {
                print("Discovered non \(deviceName) device.")
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Did connect to peripheral.")
        print("")
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: "DFB0")])
        let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
        print("Connected:\(state)")
        greenRedView.backgroundColor = UIColor.greenColor()
        
    }
    
    //    // Check if the service discovered is a valid IR Temperature Service
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        
        for svc in peripheral.services! {
            print("Service \(svc)\n")
            print("Discovering Characteristics for Service : \(svc)")
            peripheral.discoverCharacteristics([CBUUID(string: "DFB1")], forService: svc as CBService)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        for characteristic in service.characteristics! {
            if characteristic.UUID == CBUUID(string: "DFB1") {
                self.terminalChar = (characteristic as CBCharacteristic)
                peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                
                // Send notification that Bluetooth is connected and all required characteristics are discovered
                print("Found characteristic we were looking for!")
                print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Failed to connect to peripheral.")
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CONNECTION WAS DISCONNECTED")
        greenRedView.backgroundColor = UIColor.redColor()
        startScanning()
    }
}
