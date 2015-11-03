//
//  ViewController.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 26/Oct/15.
//  Copyright © 2015 JeongGroup. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    var titleLabel: UILabel!
    var statusLabel: UILabel!
    var tempLabel: UILabel!
    // BLE
    var centralManager: CBCentralManager!
    var sensorTagPeripheral: CBPeripheral!
    // IR Temp UUIDs
    let IRTemperatureServiceUUID = CBUUID(string: "F000AA00-0451-4000-B000-000000000000")
    let IRTemperatureDataUUID   = CBUUID(string: "F000AA01-0451-4000-B000-000000000000")
    let IRTemperatureConfigUUID = CBUUID(string: "F000AA02-0451-4000-B000-000000000000")
    
    
    override func viewDidLoad() {
        // Set up title label
        titleLabel = UILabel()
        titleLabel.text = "My SensorTag"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.midX, y: self.titleLabel.bounds.midY+28)
        self.view.addSubview(titleLabel)
        
        // Set up status label
        statusLabel = UILabel()
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.text = "Loading..."
        statusLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        statusLabel.sizeToFit()
        statusLabel.frame = CGRect(x: self.view.frame.origin.x, y: self.titleLabel.frame.maxY, width: self.view.frame.width, height: self.statusLabel.bounds.height)
        self.view.addSubview(statusLabel)
        
        // Set up temperature label
        tempLabel = UILabel()
        tempLabel.text = "00.00"
        tempLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 72)
        tempLabel.sizeToFit()
        tempLabel.center = self.view.center
        self.view.addSubview(tempLabel)
        
        // Initialize central manager on load
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    // Check status of BLE hardware
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripheralsWithServices(nil, options: nil)
            self.statusLabel.text = "Searching for BLE Devices"
        } else if central.state == CBCentralManagerState.Resetting {
            print("RESETTING")
        } else if central.state == CBCentralManagerState.Unauthorized {
            print("Not Authorized")
        } else {
            // Can have different conditions for all states if needed - print generic message for now
            print("Bluetooth switched off or not initialized")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        let deviceName = "FredLohMac"
        print(peripheral.name)
        if let nameOfDeviceFound = peripheral.name {
            
            print(nameOfDeviceFound)
            
            print(advertisementData["CBAdvertisementDataLocalNameKey"])
            if (nameOfDeviceFound == deviceName) {

                // Update Status Label
                self.statusLabel.text = "Sensor Tag Found"
                
                // Stop scanning
                self.centralManager.stopScan()
                // Set as the peripheral to use and establish connection
                self.sensorTagPeripheral = peripheral
                self.sensorTagPeripheral.delegate = self
                self.centralManager.connectPeripheral(peripheral, options: nil)
            }
            else {
                self.statusLabel.text = "Sensor Tag NOT Found"
            }
        }
    }
    // Check if the service discovered is a valid IR Temperature Service
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        self.statusLabel.text = "Looking at peripheral services"
        for service in peripheral.services! {
            let thisService = service as CBService
            if service.UUID == IRTemperatureServiceUUID {
                // Discover characteristics of IR Temperature Service
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
            // Uncomment to print list of UUIDs
            print(thisService.UUID)

        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Connected")
        self.statusLabel.text = "Discovering peripheral services"
        peripheral.discoverServices(nil)
        
    }
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CONNECTION FAILED")
    }
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CONNECTION WAS DISCONNECTED")
    }
    
}
