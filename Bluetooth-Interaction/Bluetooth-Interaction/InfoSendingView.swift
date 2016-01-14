//
//  InfoSendingView.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 11/Jan/16.
//  Copyright © 2016 JeongGroup. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import SnapKit


struct button {
    var selected: Bool?
    var character: String?
    var button: UIButton?
}
struct individualConsole {
    var periph: CBPeripheral?
    var arrayOfButtons = [button]()
}

class InfoSendingView: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    var serviceUUIDString = "2220"
    var serviceUUIDString2 = "FE84"
    
    var characteristicUUIDString = "2221"
    var characteristicUUIDString2 = "2D30C083-F39F-4CE6-923F-3484EA480596"
    
    var periphArray = [CBPeripheral]()
    var topBar = UIView()
    var leftButton = UIButton()
    var rightButton = UIButton()
    var middleCounter = UILabel()
    var sendButton = UIButton()
    var activePeripheral = 1
    
    //Buttons
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var button6 = UIButton()
    
    var arrayOfConsoles = [individualConsole]()
    var arrayOfButtons = [button]()
    
    func upOnePeriph() {
        leftButton.hidden = false
        activePeripheral++
        middleCounter.text = "\(activePeripheral)/\(periphArray.count)"
        if activePeripheral == periphArray.count {
            rightButton.hidden = true
        }
        for button in arrayOfConsoles[activePeripheral-1].arrayOfButtons {
            if button.selected == false {
                button.button?.backgroundColor = lightRed
            } else {
                button.button?.backgroundColor = lightGreen
            }
        }
    }
    func downOnePeriph() {
        rightButton.hidden = false
        activePeripheral--
        middleCounter.text = "\(activePeripheral)/\(periphArray.count)"
        if activePeripheral == 1 {
            leftButton.hidden = true
        }
        for button in arrayOfConsoles[activePeripheral-1].arrayOfButtons {
            if button.selected == false {
                button.button?.backgroundColor = lightRed
            } else {
                button.button?.backgroundColor = lightGreen
            }
        }
    }
    
    func button1Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[0].selected == false {
            button1.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[0].selected = true
        } else {
            button1.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[0].selected = false
        }
    }
    func button2Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[1].selected == false {
            button2.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[1].selected = true
        } else {
            button2.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[1].selected = false
        }
    }
    func button3Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[2].selected == false {
            button3.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[2].selected = true
        } else {
            button3.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[2].selected = false
        }
    }
    func button4Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[3].selected == false {
            button4.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[3].selected = true
        } else {
            button4.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[3].selected = false
        }
    }
    func button5Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[4].selected == false {
            button5.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[4].selected = true
        } else {
            button5.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[4].selected = false
        }
    }
    func button6Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[5].selected == false {
            button6.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[5].selected = true
        } else {
            button6.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[5].selected = false
        }
    }
    
    override func viewDidLoad() {
        self.view.addSubview(topBar)
        self.view.addSubview(sendButton)
        sendButton.backgroundColor = UIColor(red:0.17, green:0.66, blue:0.04, alpha:1.0)
        let sendLabel = UILabel()
        sendLabel.text = "Send"
        sendLabel.font = UIFont.systemFontOfSize(40, weight: UIFontWeightRegular)
        sendLabel.textColor = UIColor.whiteColor()
        sendButton.addSubview(sendLabel)
        sendLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(sendButton)
        }
        
        topBar.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(20)
            make.height.equalTo(40)
        }
        sendButton.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(60)
        }
        let bottomCounterBar = generateBottomSelectionBar(leftButton, rightButton: rightButton)
        self.view.addSubview(bottomCounterBar)
        bottomCounterBar.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(sendButton.snp_top)
            make.height.equalTo(50)
        }
        bottomCounterBar.addSubview(middleCounter)
        middleCounter.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(bottomCounterBar)
        }
        middleCounter.text = "\(activePeripheral)/\(periphArray.count)"
        if periphArray.count == 1 {
            rightButton.hidden = true
            leftButton.hidden = true
        } else {
            leftButton.hidden = true
        }
        rightButton.addTarget(self, action: "upOnePeriph", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.addTarget(self, action: "downOnePeriph", forControlEvents: UIControlEvents.TouchUpInside)
        
        generateMessageButton(button1, label: "a")
        generateMessageButton(button2, label: "b")
        generateMessageButton(button3, label: "c")
        generateMessageButton(button4, label: "d")
        generateMessageButton(button5, label: "e")
        generateMessageButton(button6, label: "f")
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        self.view.addSubview(button6)
        
        button1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(40)
            make.top.equalTo(self.view).offset(80)
            make.width.height.equalTo(100)
        }
        button2.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.view).offset(-40)
            make.top.equalTo(button1)
            make.width.height.equalTo(100)
        }
        button3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button1.snp_bottom).offset(20)
            make.width.height.equalTo(100)
            make.centerX.equalTo(button1)
        }
        button4.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button2.snp_bottom).offset(20)
            make.width.height.equalTo(100)
            make.centerX.equalTo(button2)
        }
        button5.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button3.snp_bottom).offset(20)
            make.width.height.equalTo(100)
            make.centerX.equalTo(button1)
        }
        button6.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button4.snp_bottom).offset(20)
            make.width.height.equalTo(100)
            make.centerX.equalTo(button4)
        }
        
        button1.addTarget(self, action: "button1Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button2.addTarget(self, action: "button2Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button3.addTarget(self, action: "button3Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button4.addTarget(self, action: "button4Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button5.addTarget(self, action: "button5Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button6.addTarget(self, action: "button6Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton.addTarget(self, action: "sendCharacters", forControlEvents: UIControlEvents.TouchUpInside)
        arrayOfConsoles.removeAll()
        for periph in periphArray {
            arrayOfButtons.removeAll()
            for index in 1...6 {
                if index == 1 {
                    let newButton = button(selected: false, character: "a", button: button1)
                    arrayOfButtons.append(newButton)
                } else if index == 2 {
                    let newButton = button(selected: false, character: "b", button: button2)
                    arrayOfButtons.append(newButton)
                } else if index == 3 {
                    let newButton = button(selected: false, character: "c", button: button3)
                    arrayOfButtons.append(newButton)
                } else if index == 4 {
                    let newButton = button(selected: false, character: "d", button: button4)
                    arrayOfButtons.append(newButton)
                } else if index == 5 {
                    let newButton = button(selected: false, character: "e", button: button5)
                    arrayOfButtons.append(newButton)
                } else if index == 6 {
                    let newButton = button(selected: false, character: "i", button: button6)
                    arrayOfButtons.append(newButton)
                }
            }
            let newConsole = individualConsole(periph: periph, arrayOfButtons: arrayOfButtons)
            arrayOfConsoles.append(newConsole)
        }
        print("PERIPH ARRAY")
        print(periphArray)
        for i in periphArray {
            supercentralManager.connectPeripheral(i, options: nil)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func sendCharacters() {
        for console in arrayOfConsoles {
            for button in console.arrayOfButtons {
                if button.selected == true {
                    let charString = String(button.character)
                    let data = charString.dataUsingEncoding(NSUTF8StringEncoding)
                    for periphChar in periphCharArray {
                        if periphChar.periph == console.periph {
                            let charString = button.character
                            let data = charString!.dataUsingEncoding(NSUTF8StringEncoding)
                            print("Start: \(currentTimeMillis())")
                            periphChar.periph!.writeValue(data!, forCharacteristic: periphChar.char!, type: CBCharacteristicWriteType.WithoutResponse)
                            print("End: \(currentTimeMillis())")
                        }
                    }
                }
            }
        }
    }
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value was sent")
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Did connect to peripheral.", separator: "")
        print(peripheral)
        if peripheral.name == "RFduino" {
            peripheral.discoverServices([CBUUID(string: serviceUUIDString)])
            let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
            print("Connected: \(state)")
        } else if peripheral.name == "Simblee" {
            peripheral.discoverServices([CBUUID(string: serviceUUIDString2)])
            let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
            print("Connected: \(state)")
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if(error != nil) {
            print(error?.description)
        }
        for service in peripheral.services! {
            if peripheral.name == "RFduino" {
                print("Service \(service)\n")
                print("Discovering Characteristics for Service : \(service.UUID)")
                print(service.characteristics)
                peripheral.discoverCharacteristics([CBUUID(string: characteristicUUIDString)], forService: service as CBService)
            } else if peripheral.name == "Simblee" {
                print("Service \(service)\n")
                print("Discovering Characteristics for Service : \(service.UUID)")
                print(service.characteristics)
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
                    
                    print("Found characteristic we were looking for!")
                    print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                    let charString = "a"
                    let data = charString.dataUsingEncoding(NSUTF8StringEncoding)
                    peripheral.writeValue(data!, forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithoutResponse)
                }
            } else if peripheral.name == "Simblee" {
                if characteristic.UUID == CBUUID(string: characteristicUUIDString2) {
                    
                    let newPeriphChar = periphChar(periph: peripheral, char: characteristic)
                    periphCharArray.append(newPeriphChar)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                    
                    print("Found characteristic we were looking for!")
                    print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                    let charString = "a"
                    let data = charString.dataUsingEncoding(NSUTF8StringEncoding)
                    peripheral.writeValue(data!, forCharacteristic: newPeriphChar.char!, type: CBCharacteristicWriteType.WithoutResponse)
                }
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print(error)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didDisconnectPeripheral")
    }
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case .PoweredOff:
            print("CoreBluetooth BLE hardware is powered off")
            
        case .PoweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            
        case .Resetting:
            print("CoreBluetooth BLE hardware is resetting")
            
        case .Unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
            
        case .Unknown:
            print("CoreBluetooth BLE state is unknown")
            
        case .Unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform")
        }
    }
}
func currentTimeMillis() -> Int64{
    let nowDouble = NSDate().timeIntervalSince1970
    return Int64(nowDouble*1000)
}