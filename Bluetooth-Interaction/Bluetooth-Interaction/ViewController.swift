//
//  ViewController.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 26/Oct/15.
//  Copyright © 2015 JeongGroup. All rights reserved.
//

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}


import UIKit
import CoreBluetooth
import SnapKit
import ChameleonFramework


struct bothConnected {
    var firstOne = false
    var secondOne = false
    var thirdOne = false
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource {
    let backgroundView = UIView()
    let topBar = UIView()
    let connectButton = UIButton()
    let disconnectButton = UIButton()
    var hasChangedView = false
    let tableView = UITableView()
    var bothAreConnected = bothConnected()
    var periphArray = [CBPeripheral]()
    var usefulPeriphArray = [CBPeripheral]()
    var connectionArray = [Bool]()
    let nextButton = UIButton()
    let optionsButton = UIButton()
    
    var serviceUUIDString = "2220"
    var serviceUUIDString2 = "FE84"
    
    var characteristicUUIDString = "2222"
    var characteristicUUIDString2 = "2D30C083-F39F-4CE6-923F-3484EA480596"
    
    
    //    var characteristics: CBCharacteristic!
    
    
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
        counter = 0
        tableView.reloadData()
    }
    var counter = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let name = periphArray[indexPath.row].name {
            if let identifier: NSUUID = periphArray[indexPath.row].identifier {
                let string = identifier.UUIDString
                let color = connectionArray[indexPath.row]
                counter++
                return generatePeripheralCell("Mouse \(counter)", identifier: string, color: color)
            }
        }
        //        return
        return generatePeripheralCell("Error", identifier: "0000-0000-0000-0000", color: false)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func nextView() {
        periphCharArray.removeAll()
        usefulPeriphArray.removeAll()
        arrayOfConsoles.removeAll()
        arrayOfButtons.removeAll()
        for connections in connectionArray {
            if connections == true {
                for(var i = 0; i < connectionArray.count; i++) {
                    if connectionArray[i].boolValue == true {
                        periphArray[i].delegate = self
                        supercentralManager.connectPeripheral(periphArray[i], options: nil)
                        usefulPeriphArray.append(periphArray[i])
                    }
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("InfoSendingView") as! InfoSendingView
                
                controller.periphArray = self.usefulPeriphArray
                hasChangedView = true
                self.performSegueWithIdentifier("InfoSegue", sender: self)
                //                self.presentViewController(controller, animated: true, completion: nil)
                break
            }
        }
    }
    
    func disconnect() {
        for periph in usefulPeriphArray {
            supercentralManager.cancelPeripheralConnection(periph)
        }
        
        for (var i=0;i<connectionArray.count;i++) {
            connectionArray[i] = false
        }
        tableView.reloadData()
        periphCharArray.removeAll()
        usefulPeriphArray.removeAll()
        arrayOfConsoles.removeAll()
        arrayOfButtons.removeAll()
        counter = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Connections"
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.hidden = false
        navigationItem.title = "Connections"
        
        nextButton.setBackgroundImage(UIImage(named: "next"), forState: UIControlState.Normal)
        optionsButton.setBackgroundImage(UIImage(named: "Cog"), forState: UIControlState.Normal)
        
        connectButton.addTarget(self, action: "nextView", forControlEvents: UIControlEvents.TouchUpInside)
        disconnectButton.addTarget(self, action: "disconnect", forControlEvents: UIControlEvents.TouchUpInside)
        optionsButton.addTarget(self, action: "openOptionsMenu", forControlEvents: UIControlEvents.TouchUpInside)
        topBar.addSubview(nextButton)
        topBar.addSubview(optionsButton)
        backgroundView.addSubview(topBar)
        topBar.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(backgroundView)
            make.top.equalTo(backgroundView).offset(20)
            make.height.equalTo(40)
        }
        nextButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(topBar)
            make.right.equalTo(topBar).offset(-5)
            make.height.width.equalTo(30)
        }
        optionsButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(topBar)
            make.left.equalTo(topBar).offset(5)
            make.height.width.equalTo(30)
        }
        
        supercentralManager = CBCentralManager(delegate: self, queue: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        self.view.addSubview(backgroundView)
        self.view.addSubview(connectButton)
        self.view.addSubview(disconnectButton)
        backgroundView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(connectButton.snp_top)
            make.centerX.equalTo(self.view)
        }
        disconnectButton.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(self.view)
            make.height.equalTo(75)
        }
        connectButton.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(disconnectButton.snp_top)
            make.height.equalTo(75)
        }
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(backgroundView)
            make.top.equalTo(topBar.snp_bottom)
        }
        
        connectButton.backgroundColor = FlatGreenDark()
        let connectLabel = UILabel()
        connectButton.addSubview(connectLabel)
        connectLabel.text = "Connect"
        connectLabel.font = UIFont.boldSystemFontOfSize(30)
        connectLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:FlatGreenDark(), isFlat:true)
        connectLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(connectButton)
        }
        disconnectButton.backgroundColor = FlatRedDark()
        let disconnectLabel = UILabel()
        disconnectButton.addSubview(disconnectLabel)
        disconnectLabel.text = "Disconnect"
        disconnectLabel.font = UIFont.boldSystemFontOfSize(30)
        disconnectLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:FlatRedDark(), isFlat:true)
        disconnectLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(disconnectButton)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value was sent")
    }
    
    func discoverDevices() {
        //        print("Searching for devices")
        supercentralManager.scanForPeripheralsWithServices(nil, options: nil)
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
            print("CoreBluetooth BLE state is unknown")
            
        case .Unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform")
        }
        if bluetoothAvailable == true {
            discoverDevices()
        }
    }
    
    func isUnique(newValue: CBPeripheral) -> Bool {
        for value in periphArray {
            if value == newValue {
                return false
            }
        }
        return true
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if isUnique(peripheral) == true && peripheral.name != nil && hasChangedView == false {
            periphArray.append(peripheral)
            var test = false
            connectionArray.append(test)
            counter = 0
            tableView.reloadData()
        } else if peripheral.name != nil {
            for periph in usefulPeriphArray {
                supercentralManager.connectPeripheral(periph, options: nil)
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        //        print("Did connect to peripheral.", separator: "")
        //        print(peripheral)
        if peripheral.name == "RFduino" {
            peripheral.discoverServices([CBUUID(string: serviceUUIDString)])
            let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
            //            print("Connected: \(state)")
        } else if peripheral.name == "Simblee" {
            peripheral.discoverServices([CBUUID(string: serviceUUIDString2)])
            let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
            //            print("Connected: \(state)")
            infoSendButton.backgroundColor = FlatForestGreen()
            infoSendButton.enabled = true
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        for service in peripheral.services! {
            if peripheral.name == "RFduino" {
                //                print("Service \(service)\n")
                //                print("Discovering Characteristics for Service : \(service.UUID)")
                //                print(service.characteristics)
                peripheral.discoverCharacteristics([CBUUID(string: characteristicUUIDString)], forService: service as CBService)
            } else if peripheral.name == "Simblee" {
                //                print("Service \(service)\n")
                //                print("Discovering Characteristics for Service : \(service.UUID)")
                //                print(service.characteristics)
                peripheral.discoverCharacteristics([CBUUID(string: characteristicUUIDString2)], forService: service as CBService)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        for characteristic in service.characteristics! {
            if peripheral.name == "RFduino" {
                if characteristic.UUID == CBUUID(string: characteristicUUIDString) {
                    
                    let newPeriphChar = periphChar(periph: peripheral, char: characteristic)
                    periphCharArray.append(newPeriphChar)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    //                    print("Found characteristic we were looking for!")
                    //                    print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                }
            } else if peripheral.name == "Simblee" {
                if characteristic.UUID == CBUUID(string: characteristicUUIDString2) {
                    
                    let newPeriphChar = periphChar(periph: peripheral, char: characteristic)
                    periphCharArray.append(newPeriphChar)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
                    //                    print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                }
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print(error)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("\(peripheral.name) was disconnected.")
        infoSendButton.backgroundColor = FlatRedDark()
        infoSendButton.enabled = false
        usefulPeriphArray.removeAll()
        periphCharArray.removeAll()
        for(var i = 0; i < connectionArray.count; i++) {
            if connectionArray[i].boolValue == true {
                periphArray[i].delegate = self
                supercentralManager.connectPeripheral(periphArray[i], options: nil)
                usefulPeriphArray.append(periphArray[i])
            }
        }
        infoSendButton.enabled = true
        
    }
    
    func openOptionsMenu() {
        let alert = UIAlertController(title: "Options Menu", message: "Please insert correct service and charactersitc UUID string.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Current service: \(self.serviceUUIDString)"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Current characteristic: \(self.characteristicUUIDString)"
        })
        let sendAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            if alert.textFields![0].text != "" {
                self.serviceUUIDString = alert.textFields![0].text!
            }
            if alert.textFields![1].text != "" {
                self.characteristicUUIDString = alert.textFields![1].text!
            }
        }
        alert.addAction(sendAction)
        //        self.navigationController?.pushViewController(InfoSendingView(), animated: true)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = ""
        if (segue.identifier == "InfoSegue") {
            let svc = segue.destinationViewController as! InfoSendingView
            svc.periphArray = self.usefulPeriphArray
        }
    }
}
