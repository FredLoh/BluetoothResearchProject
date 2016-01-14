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

var periph: CBPeripheral?
var peripheral2: CBPeripheral?
var peripheral3: CBPeripheral?

var lightRed = UIColor.redColor().colorWithAlphaComponent(0.30)
var lightGreen = UIColor.greenColor().colorWithAlphaComponent(0.30)

var arrayOfCharacteristics = [CBCharacteristic]()
var terminalChar:CBCharacteristic!
var terminalChar2:CBCharacteristic!
var terminalChar3:CBCharacteristic!

struct periphChar {
    var periph: CBPeripheral?
    var char: CBCharacteristic?
}

var periphCharArray = [periphChar]()