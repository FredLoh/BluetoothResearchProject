//
//  GlobalVariables.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 22/Dec/15.
//  Copyright © 2015 JeongGroup. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import ChameleonFramework

var lightRed = FlatRed()
var lightGreen = FlatGreen()

var arrayOfCharacteristics = [CBCharacteristic]()

var supercentralManager = CBCentralManager()

struct periphChar {
    var periph: CBPeripheral?
    var char: CBCharacteristic?
}
var disconnected = false
var periphCharArray = [periphChar]()
var arrayOfConsoles = [individualConsole]()
var arrayOfButtons = [button]()
var infoSendButton = UIButton()