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
//import Charts

struct bothConnected {
    var firstOne = false
    var secondOne = false
    var thirdOne = false
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource {
    let backgroundView = UIView()
    let tableView = UITableView()
    var bothAreConnected = bothConnected()
    var periphArray = [CBPeripheral]()
    var usefulPeriphArray = [CBPeripheral]()
    var connectionArray = [Bool]()
    let nextButton = UIButton()
    let RFDuino1 = NSUUID(UUIDString: "DBBD02C8-765D-4340-95DC-35A7C69F420A")
    let RFDuino2 = NSUUID(UUIDString: "83429FD9-33CA-A46C-E698-E55A11F638E7")
    let RFDuino3 = NSUUID(UUIDString: "26BEB8B3-2499-0418-1B7F-42209C63B40B")
    
    let serviceUUIDString = "FE84"
    
    let characteristicUUIDString = "2D30C083-F39F-4CE6-923F-3484EA480596"
    
    // BLE
    var centralManager: CBCentralManager!
    
    //    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
    var terminalChar2:CBCharacteristic!
    var terminalChar3:CBCharacteristic!
    
    var bluetoothAvailable = false
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periphArray.count
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        if connectionArray[indexPath.row] == false {
            connectionArray[indexPath.row] = true
        } else {
            connectionArray[indexPath.row] = false
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let name = periphArray[indexPath.row].name {
            if let identifier: NSUUID = periphArray[indexPath.row].identifier {
                let string = identifier.UUIDString
                let color = connectionArray[indexPath.row]
                return generatePeripheralCell(name, identifier: string, color: color)
            }
        }
        return generatePeripheralCell("Error", identifier: "0000-0000-0000-0000", color: false)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func nextView() {
        for(var i = 0; i < connectionArray.count; i++) {
            if connectionArray[i].boolValue == true {
                periphArray[i].delegate = self
                self.centralManager.connectPeripheral(periphArray[i], options: nil)
            }
        }
        bothAreConnected.firstOne = true
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Peripheral List"
        navigationController?.navigationBar.addSubview(nextButton)
        nextButton.setBackgroundImage(UIImage(named: "next"), forState: UIControlState.Normal)
        nextButton.addTarget(self, action: "nextView", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo((navigationController?.navigationBar)!)
            make.right.equalTo((navigationController?.navigationBar)!).offset(-5)
            make.height.width.equalTo(30)
        }
        centralManager = CBCentralManager(delegate: self, queue: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.top.equalTo(backgroundView)
        }
        
        
    }
    func startScanning() {
        print("Started Scanning!")
        bothAreConnected.firstOne = false
        bothAreConnected.secondOne = false
        bothAreConnected.thirdOne = false
        //Could add service UUID here to scan for only relevant services
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    //    func send8dMessage() {
    //        let message = "k"
    //        let message2 = "k"
    //        let message3 = "j"
    //
    //        let data = message.dataUsingEncoding(NSUTF8StringEncoding)
    //        let data2 = message2.dataUsingEncoding(NSUTF8StringEncoding)
    //        let data3 = message3.dataUsingEncoding(NSUTF8StringEncoding)
    //        if terminalChar != nil && terminalChar2 != nil {
    //            peripheral!.writeValue(data!, forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
    //            peripheral2!.writeValue(data2!,  forCharacteristic: terminalChar2, type: CBCharacteristicWriteType.WithoutResponse)
    //        } else if terminalChar != nil && terminalChar2 == nil {
    //            peripheral!.writeValue(data!, forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
    //        } else if terminalChar == nil && terminalChar2 != nil {
    //            peripheral2!.writeValue(data2!,  forCharacteristic: terminalChar2, type: CBCharacteristicWriteType.WithoutResponse)
    //        }
    //    }
    
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
            bluetoothAvailable = true
            
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
        periphArray.append(peripheral)
        connectionArray.append(false)
        tableView.reloadData()
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Did connect to peripheral.", separator: "")
        peripheral.discoverServices([CBUUID(string: serviceUUIDString)])
        let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
        print("Connected: \(state)")
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
                    
                    print("Found characteristic we were looking for RFDUINO2!")
                } else if peripheral.identifier == RFDuino3 {
                    self.terminalChar3 = (characteristic as CBCharacteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
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
            bothAreConnected.firstOne = false
        } else if (peripheral.identifier == RFDuino2) {
            bothAreConnected.secondOne = false
        } else if (peripheral.identifier == RFDuino3) {
            bothAreConnected.thirdOne = false
        }
        startScanning()
    }
}
