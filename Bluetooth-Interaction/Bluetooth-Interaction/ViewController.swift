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

struct bothConnected {
    var firstOne = false
    var secondOne = false
    var thirdOne = false
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    let backgroundView = UIView()
    let greenRedView1 = UIView()
    let greenRedView2 = UIView()
    let greenRedView3 = UIView()
    let scanButton =  UIButton()
    let send5aButton = UIButton()
    let send7cButton = UIButton()
    
    let chartView = LineChartView()
    var months: [String]!
    var unitsSold: [Double]!
    var bothAreConnected = bothConnected()
    
    let RFDuino1 = NSUUID(UUIDString: "DBBD02C8-765D-4340-95DC-35A7C69F420A")
    let RFDuino2 = NSUUID(UUIDString: "83429FD9-33CA-A46C-E698-E55A11F638E7")
//    let RFDuino1 = NSUUID(UUIDString: "119B0B6A-1D9E-9079-34AA-2E81AED90D4C")
//    let RFDuino2 = NSUUID(UUIDString: "87FC4435-943F-9D4E-0D1D-135FDB41E724")
    let RFDuino3 = NSUUID(UUIDString: "26BEB8B3-2499-0418-1B7F-42209C63B40B")
    
    let serviceUUIDString = "FE84"
    let serviceUUIDString2 = "FE85"

    let characteristicUUIDString = "2D30C083-F39F-4CE6-923F-3484EA480596"

    // BLE
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var peripheral2: CBPeripheral!
    var peripheral3: CBPeripheral!
    //    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
    var terminalChar2:CBCharacteristic!
    var terminalChar3:CBCharacteristic!
    
    var bluetoothAvailable = false
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        scanButton.setTitle("Scan", forState: UIControlState.Normal)
        scanButton.addTarget(self, action: "startScanning", forControlEvents: UIControlEvents.TouchUpInside)
        scanButton.backgroundColor = UIColor.blackColor()
        
        send5aButton.setTitle("1/a/1", forState: UIControlState.Normal)
        send5aButton.addTarget(self, action: "send5aMessage", forControlEvents: UIControlEvents.TouchUpInside)
        send5aButton.backgroundColor = UIColor.blackColor()
        
        
        send7cButton.setTitle("3/c/3", forState: UIControlState.Normal)
        send7cButton.addTarget(self, action: "send7cMessage", forControlEvents: UIControlEvents.TouchUpInside)
        send7cButton.backgroundColor = UIColor.blackColor()
        
        greenRedView1.backgroundColor = UIColor.redColor()
        greenRedView2.backgroundColor = UIColor.redColor()
        greenRedView3.backgroundColor = UIColor.redColor()
        
        
        
        self.view.addSubview(backgroundView)
        
        
        backgroundView.addSubview(scanButton)
        backgroundView.addSubview(send5aButton)
        backgroundView.addSubview(send7cButton)
        backgroundView.addSubview(greenRedView1)
        backgroundView.addSubview(greenRedView2)
        backgroundView.addSubview(greenRedView3)
        backgroundView.addSubview(chartView)
        
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        scanButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(backgroundView)
            make.bottom.equalTo(send5aButton)
            make.width.height.equalTo(60)
        }
        send5aButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView).offset(50)
            make.height.equalTo(60)
            make.width.equalTo(140)
        }
        send7cButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(send5aButton)
            make.top.equalTo(send5aButton.snp_bottom).offset(10)
            make.height.equalTo(send5aButton)
            make.width.equalTo(send5aButton)
        }
        
        greenRedView1.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(20)
            make.bottom.equalTo(send5aButton.snp_top).offset(-20)
            make.centerX.equalTo(send5aButton)
        }
        greenRedView2.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(20)
            make.bottom.equalTo(send5aButton.snp_top).offset(-20)
            make.left.equalTo(greenRedView1.snp_right).offset(10)
        }
        greenRedView3.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(20)
            make.bottom.equalTo(send5aButton.snp_top).offset(-20)
            make.left.equalTo(greenRedView2.snp_right).offset(10)
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
        greenRedView1.backgroundColor = UIColor.redColor()
        greenRedView2.backgroundColor = UIColor.redColor()
        greenRedView3.backgroundColor = UIColor.redColor()
        bothAreConnected.firstOne = false
        bothAreConnected.secondOne = false
        bothAreConnected.thirdOne = false
        //Could add service UUID here to scan for only relevant services
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func send5aMessage() {
        let message = "1"
        let message2 = "1"
        let message3 = "1"
        
        let data = message.dataUsingEncoding(NSUTF8StringEncoding)
        let data2 = message2.dataUsingEncoding(NSUTF8StringEncoding)
        let data3 = message3.dataUsingEncoding(NSUTF8StringEncoding)
        
//        if terminalChar != nil && terminalChar2 != nil {
//            peripheral!.writeValue(data!,  forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
//            peripheral2!.writeValue(data2!, forCharacteristic: terminalChar2, type: CBCharacteristicWriteType.WithoutResponse)
//            peripheral3!.writeValue(data3!, forCharacteristic: terminalChar3, type: CBCharacteristicWriteType.WithResponse)
//        }
        peripheral!.writeValue(data2!, forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
    }
    func send7cMessage() {
        let message = "2"
        let message2 = "2"
        let message3 = "2"
        
        let data = message.dataUsingEncoding(NSUTF8StringEncoding)
        let data2 = message2.dataUsingEncoding(NSUTF8StringEncoding)
        let data3 = message3.dataUsingEncoding(NSUTF8StringEncoding)
//        if terminalChar != nil && terminalChar2 != nil && terminalChar3 != nil {
//            peripheral!.writeValue(data!,  forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
//            peripheral2!.writeValue(data2!, forCharacteristic: terminalChar2, type: CBCharacteristicWriteType.WithoutResponse)
//            peripheral3!.writeValue(data3!, forCharacteristic: terminalChar3, type: CBCharacteristicWriteType.WithoutResponse)
//            
//        }
        peripheral!.writeValue(data!,  forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
        
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value was sent")
    }
    
    func discoverDevices() {
        print("Searching for devices")
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
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
        if let nameOfDeviceFound: NSUUID = peripheral.identifier {
            if (nameOfDeviceFound == RFDuino1) {
                print("Discovered \(nameOfDeviceFound)")
                print("")
                
                print(peripheral)
                
                self.peripheral = peripheral
                self.peripheral.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
                bothAreConnected.firstOne = true
                if(bothAreConnected.firstOne == true && bothAreConnected.secondOne == true && bothAreConnected.thirdOne == true) {
                    self.centralManager.stopScan()
                }
            } else if (nameOfDeviceFound == RFDuino2) {
                print("Discovered \(nameOfDeviceFound)")
                print("")
                print(peripheral)
                
                self.peripheral2 = peripheral
                self.peripheral2.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
                bothAreConnected.secondOne = true
                if(bothAreConnected.firstOne == true && bothAreConnected.secondOne == true && bothAreConnected.thirdOne == true) {
                    print("Stopped Scanning")
                    self.centralManager.stopScan()
                }
                
            } else if (nameOfDeviceFound == RFDuino3) {
                print("Discovered \(nameOfDeviceFound)")
                print("")
                print(peripheral)
                
                self.peripheral3 = peripheral
                self.peripheral3.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
                bothAreConnected.thirdOne = true
                if(bothAreConnected.firstOne == true && bothAreConnected.secondOne == true && bothAreConnected.thirdOne == true) {
                    print("Stopped Scanning")
                    self.centralManager.stopScan()
                }
                
            }
            else {
                print("Discovered \(peripheral) device.")
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Did connect to peripheral.")
        print("")
        peripheral.delegate = self
        print(peripheral.services)
        
        peripheral.discoverServices([CBUUID(string: serviceUUIDString)])
        let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
        print("Connected:\(state)")
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        
        for svc in peripheral.services! {
            print("Service \(svc)\n")
            print("Discovering Characteristics for Service : \(svc.UUID)")
            print(svc.characteristics)
            peripheral.discoverCharacteristics([CBUUID(string: characteristicUUIDString)], forService: svc as CBService)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        for characteristic in service.characteristics! {
            if characteristic.UUID == CBUUID(string: characteristicUUIDString) {
                print("Found charactersitc")
                if peripheral.identifier == RFDuino1 {
                    self.terminalChar = (characteristic as CBCharacteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
                    print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                } else if peripheral.identifier == RFDuino2 {
                    self.terminalChar2 = (characteristic as CBCharacteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
                } else if peripheral.identifier == RFDuino3 {
                    self.terminalChar3 = (characteristic as CBCharacteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
                }
                if(peripheral.identifier == RFDuino1) {
                    greenRedView1.backgroundColor = UIColor.greenColor()
                } else if( peripheral.identifier == RFDuino2) {
                    greenRedView2.backgroundColor = UIColor.greenColor()
                } else if peripheral.identifier == RFDuino3 {
                    greenRedView3.backgroundColor = UIColor.greenColor()
                }
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print(error)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didDisconnectPeripheral")
        if(peripheral.identifier == RFDuino1) {
            greenRedView1.backgroundColor = UIColor.redColor()
            bothAreConnected.firstOne = false
        } else if (peripheral.identifier == RFDuino2) {
            greenRedView2.backgroundColor = UIColor.redColor()
            bothAreConnected.secondOne = false
        } else if (peripheral.identifier == RFDuino3) {
            greenRedView3.backgroundColor = UIColor.redColor()
            bothAreConnected.thirdOne = false
        }
        startScanning()
    }
}
