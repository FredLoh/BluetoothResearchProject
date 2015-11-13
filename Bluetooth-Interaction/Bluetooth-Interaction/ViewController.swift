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

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    let backgroundView = UIView()
    let scanButton =  UIButton()
    let sendButton = UIButton()
    
    // BLE
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    //    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
    var bluetoothAvailable = false
    
    override func viewDidLoad() {
        scanButton.setTitle("Scan", forState: UIControlState.Normal)
        scanButton.addTarget(self, action: "startScanning", forControlEvents: UIControlEvents.TouchUpInside)
        scanButton.backgroundColor = UIColor.blackColor()
        
        sendButton.setTitle("Send", forState: UIControlState.Normal)
        sendButton.addTarget(self, action: "sendMessage", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton.backgroundColor = UIColor.blackColor()
        
        backgroundView.addSubview(scanButton)
        backgroundView.addSubview(sendButton)
        self.view.addSubview(backgroundView)
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self.view)
        }
        scanButton.snp_makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(backgroundView)
            make.width.height.equalTo(60)
        }
        sendButton.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(backgroundView)
            make.width.height.equalTo(60)
        }
    }
    
    func startScanning() {
        print("Started Scanning!")
        //Could add service UUID here to scan for only relevant services
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func sendMessage() {
        let message = "5"
        let data = message.dataUsingEncoding(NSUTF8StringEncoding)
        if terminalChar != nil {
            peripheral!.writeValue(data!,  forCharacteristic: terminalChar, type: CBCharacteristicWriteType.WithoutResponse)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value was sent")
    }
    
    func discoverDevices() {
        print("discovering devices")
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
        if let nameOfDeviceFound = peripheral.name {
            if (nameOfDeviceFound == deviceName) {
                print("Discovered \(deviceName)")
                print("")
                
                print(peripheral)
                // Stop scanning
                self.centralManager.stopScan()
                print("Stopped Scanning")
                // Set as the peripheral to use and establish connection
                self.peripheral = peripheral
                self.peripheral.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
            }
            else {
                print("NOPE.EXE")
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
    }
}
