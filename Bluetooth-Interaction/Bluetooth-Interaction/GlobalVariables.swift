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


var lightRed = UIColor.redColor().colorWithAlphaComponent(0.30)
var lightGreen = UIColor.greenColor().colorWithAlphaComponent(0.30)

var arrayOfCharacteristics = [CBCharacteristic]()

var supercentralManager = CBCentralManager()

struct periphChar {
    var periph: CBPeripheral?
    var char: CBCharacteristic?
}

var periphCharArray = [periphChar]()