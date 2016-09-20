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
import ChameleonFramework

struct button {
    var selected: Bool?
    var character: String?
    var button: UIButton?
    var sent = false
}
struct individualConsole {
    var periph: CBPeripheral?
    var arrayOfButtons = [button]()
}

class InfoSendingView: UIViewController {
    var middleView = UIView()
    var scrollView = UIScrollView()
    
    var periphArray = [CBPeripheral]()
    var leftButton = UIButton()
    var rightButton = UIButton()
    var middleCounter = UILabel()
    var activePeripheral = 1
    
    //Buttons
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var button6 = UIButton()
    var button7 = UIButton()
    var button8 = UIButton()
    var button9 = UIButton()
    var button10 = UIButton()
    var button11 = UIButton()
    var button12 = UIButton()
    var button13 = UIButton()
    var button14 = UIButton()
    var button15 = UIButton()
    var button16 = UIButton()
    var button17 = UIButton()
    var button18 = UIButton()
    var button19 = UIButton()
    var button20 = UIButton()
    var button21 = UIButton()
    
    func upOnePeriph() {
        leftButton.hidden = false
        activePeripheral++
        middleCounter.text = "Mouse \(activePeripheral) / \(periphArray.count)"
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
        middleCounter.text = "Mouse \(activePeripheral) / \(periphArray.count)"
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
    func button7Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[6].selected == false {
            button7.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[6].selected = true
        } else {
            button7.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[6].selected = false
        }
    }
    func button8Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[7].selected == false {
            button8.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[7].selected = true
        } else {
            button8.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[7].selected = false
        }
    }
    func button9Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[8].selected == false {
            button9.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[8].selected = true
        } else {
            button9.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[8].selected = false
        }
    }
    func button10Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[9].selected == false {
            button10.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[9].selected = true
        } else {
            button10.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[9].selected = false
        }
    }
    func button11Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[10].selected == false {
            button11.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[10].selected = true
        } else {
            button11.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[10].selected = false
        }
    }
    func button12Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[11].selected == false {
            button12.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[11].selected = true
        } else {
            button12.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[11].selected = false
        }
    }
    func button13Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[12].selected == false {
            button13.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[12].selected = true
        } else {
            button13.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[12].selected = false
        }
    }
    func button14Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[13].selected == false {
            button14.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[13].selected = true
        } else {
            button14.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[13].selected = false
        }
    }
    func button15Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[14].selected == false {
            button15.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[14].selected = true
        } else {
            button15.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[14].selected = false
        }
    }
    func button16Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[15].selected == false {
            button16.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[15].selected = true
        } else {
            button16.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[15].selected = false
        }
    }
    func button17Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[16].selected == false {
            button17.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[16].selected = true
        } else {
            button17.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[16].selected = false
        }
    }
    func button18Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[17].selected == false {
            button18.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[17].selected = true
        } else {
            button18.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[17].selected = false
        }
    }
    func button19Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[18].selected == false {
            button19.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[18].selected = true
        } else {
            button19.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[18].selected = false
        }
    }
    func button20Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[19].selected == false {
            button20.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[19].selected = true
        } else {
            button20.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[19].selected = false
        }
    }
    func button21Clicked() {
        if arrayOfConsoles[activePeripheral-1].arrayOfButtons[20].selected == false {
            button21.backgroundColor = lightGreen
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[20].selected = true
        } else {
            button21.backgroundColor = lightRed
            arrayOfConsoles[activePeripheral-1].arrayOfButtons[20].selected = false
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.backgroundColor = FlatBlack()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationItem.title = "Send"
        
        self.view.addSubview(middleView)
        middleView.addSubview(scrollView)
        scrollView.backgroundColor = FlatBlack()
        self.view.addSubview(infoSendButton)
        infoSendButton.backgroundColor = FlatForestGreenDark()
        infoSendButton.enabled = true
        let connectLabel = UILabel()
        infoSendButton.addSubview(connectLabel)
        connectLabel.text = "Send"
        connectLabel.font = UIFont.boldSystemFontOfSize(30)
        connectLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:FlatForestGreenDark(), isFlat:true)
        connectLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(infoSendButton)
        }
        middleView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(infoSendButton.snp_top)
        }
        infoSendButton.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(60)
        }
        scrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(middleView)
        }
        
        let bottomCounterBar = generateBottomSelectionBar(leftButton, rightButton: rightButton)
        middleView.addSubview(bottomCounterBar)
        bottomCounterBar.backgroundColor = FlatWhite()
        bottomCounterBar.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(middleView)
            make.bottom.equalTo(infoSendButton.snp_top)
            make.height.equalTo(50)
        }
        bottomCounterBar.addSubview(middleCounter)
        middleCounter.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(bottomCounterBar)
        }
        bottomCounterBar.backgroundColor = FlatForestGreenDark()
        middleCounter.font = UIFont.boldSystemFontOfSize(20)
        middleCounter.textColor = UIColor(contrastingBlackOrWhiteColorOn:FlatForestGreenDark(), isFlat:true)
        middleCounter.text = "Mouse \(activePeripheral) / \(periphArray.count)"
        if periphArray.count == 1 {
            rightButton.hidden = true
            leftButton.hidden = true
        } else {
            leftButton.hidden = true
        }
        rightButton.addTarget(self, action: "upOnePeriph", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.addTarget(self, action: "downOnePeriph", forControlEvents: UIControlEvents.TouchUpInside)
        
        generateMessageButton(button1, label: "5 Hz", namelabel: arrayOfCharactersToBeSent[0])
        generateMessageButton(button2, label: "10 Hz", namelabel: arrayOfCharactersToBeSent[1])
        generateMessageButton(button3, label: "20 Hz", namelabel: arrayOfCharactersToBeSent[2])
        generateMessageButton(button4, label: "40 Hz", namelabel: arrayOfCharactersToBeSent[3])
        generateMessageButton(button5, label: "5 Hz", namelabel: arrayOfCharactersToBeSent[4])
        generateMessageButton(button6, label: "10 Hz", namelabel: arrayOfCharactersToBeSent[5])
        generateMessageButton(button7, label: "20 Hz", namelabel: arrayOfCharactersToBeSent[6])
        generateMessageButton(button8, label: "40 Hz", namelabel: arrayOfCharactersToBeSent[7])
        generateMessageButton(button9, label: "5 Hz", namelabel: arrayOfCharactersToBeSent[8])
        generateMessageButton(button10, label: "10 Hz", namelabel: arrayOfCharactersToBeSent[9])
        generateMessageButton(button11, label: "20 Hz", namelabel: arrayOfCharactersToBeSent[10])
        generateMessageButton(button12, label: "40 Hz", namelabel: arrayOfCharactersToBeSent[11])
        generateMessageButton(button13, label: "Heater 1", namelabel: arrayOfCharactersToBeSent[12])
        generateMessageButton(button14, label: "Heater 2", namelabel: arrayOfCharactersToBeSent[13])
        generateMessageButton(button15, label: "Heater 3", namelabel: arrayOfCharactersToBeSent[14])
        generateMessageButton(button16, label: "Heater 4", namelabel: arrayOfCharactersToBeSent[15])
        generateMessageButton(button17, label: "LEDS Off", namelabel: arrayOfCharactersToBeSent[16])
        generateMessageButton(button18, label: "Reset", namelabel: arrayOfCharactersToBeSent[17])
        generateMessageButton(button19, label: "Sleep", namelabel: arrayOfCharactersToBeSent[18])
        generateMessageButton(button20, label: "Wake Up", namelabel: arrayOfCharactersToBeSent[19])
        
        
        scrollView.addSubview(button1)
        scrollView.addSubview(button2)
        scrollView.addSubview(button3)
        scrollView.addSubview(button4)
        scrollView.addSubview(button5)
        scrollView.addSubview(button6)
        scrollView.addSubview(button7)
        scrollView.addSubview(button8)
        scrollView.addSubview(button9)
        scrollView.addSubview(button10)
        scrollView.addSubview(button11)
        scrollView.addSubview(button12)
        scrollView.addSubview(button13)
        scrollView.addSubview(button14)
        scrollView.addSubview(button15)
        scrollView.addSubview(button16)
        scrollView.addSubview(button17)
        scrollView.addSubview(button18)
        scrollView.addSubview(button19)
        scrollView.addSubview(button20)
        scrollView.addSubview(button21)
        
        let heightWidth = 80
        button1.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(button5.snp_left).offset(-10)
            make.top.equalTo(scrollView).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button1)
            make.top.equalTo(button1.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button3.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button1)
            make.top.equalTo(button2.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button4.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button1)
            make.top.equalTo(button3.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button5.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button6.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button5)
            make.top.equalTo(button5.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button7.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button5)
            make.top.equalTo(button6.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button8.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button5)
            make.top.equalTo(button7.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button9.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button5.snp_right).offset(10)
            make.top.equalTo(scrollView).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button10.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button9)
            make.top.equalTo(button9.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button11.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button9)
            make.top.equalTo(button10.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        button12.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(button9)
            make.top.equalTo(button11.snp_bottom).offset(10)
            make.width.height.equalTo(heightWidth)
        }
        
        //LED OFF
        button17.snp_makeConstraints { (make) in
            make.left.equalTo(button1)
            make.right.equalTo(button9)
            make.top.equalTo(button4.snp_bottom).offset(10)
            make.height.equalTo(80)
        }
        
        //Heaters 13-16
        button13.snp_makeConstraints { (make) in
            make.top.equalTo(button17.snp_bottom).offset(10)
            make.left.equalTo(button17)
            make.right.equalTo(button17.snp_centerX).offset(-5)
            make.height.equalTo(80)
        }
        button14.snp_makeConstraints { (make) in
            make.top.equalTo(button17.snp_bottom).offset(10)
            make.right.equalTo(button17)
            make.left.equalTo(button17.snp_centerX).offset(5)
            make.height.equalTo(80)
        }
        button15.snp_makeConstraints { (make) in
            make.top.equalTo(button13.snp_bottom).offset(10)
            make.left.equalTo(button17)
            make.right.equalTo(button17.snp_centerX).offset(-5)
            make.height.equalTo(80)
        }
        button16.snp_makeConstraints { (make) in
            make.top.equalTo(button13.snp_bottom).offset(10)
            make.right.equalTo(button17)
            make.left.equalTo(button17.snp_centerX).offset(5)
            make.height.equalTo(80)
        }
        
        //Commands
        button18.snp_makeConstraints { (make) in
            make.top.equalTo(button16.snp_bottom).offset(10)
            make.right.equalTo(button17)
            make.left.equalTo(button17.snp_centerX).offset(5)
            make.height.equalTo(80)
        }
        button19.snp_makeConstraints { (make) in
            make.top.equalTo(button16.snp_bottom).offset(10)
            make.left.equalTo(button17)
            make.right.equalTo(button17.snp_centerX).offset(-5)
            make.height.equalTo(80)
        }
        button20.snp_makeConstraints { (make) in
            make.top.equalTo(button18.snp_bottom).offset(10)
            make.right.equalTo(button17)
            make.left.equalTo(button17.snp_centerX).offset(5)
            make.height.equalTo(80)
        }
        
        
        
        scrollView.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(button20.snp_bottom).offset(60)
            //            make.left.equalTo(button1).offset(-60)
            //            make.right.equalTo(button12.snp_right).offset(10)
        }
        
        button1.addTarget(self, action: "button1Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button2.addTarget(self, action: "button2Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button3.addTarget(self, action: "button3Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button4.addTarget(self, action: "button4Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button5.addTarget(self, action: "button5Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button6.addTarget(self, action: "button6Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button7.addTarget(self, action: "button7Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button8.addTarget(self, action: "button8Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button9.addTarget(self, action: "button9Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button10.addTarget(self, action: "button10Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button11.addTarget(self, action: "button11Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button12.addTarget(self, action: "button12Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button13.addTarget(self, action: "button13Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button14.addTarget(self, action: "button14Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button15.addTarget(self, action: "button15Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button16.addTarget(self, action: "button16Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button17.addTarget(self, action: "button17Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button18.addTarget(self, action: "button18Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button19.addTarget(self, action: "button19Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        button20.addTarget(self, action: "button20Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        arrayOfConsoles.removeAll()
        for periph in periphArray {
            arrayOfButtons.removeAll()
            for index in 1...20 {
                if index == 1 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[0], button: button1, sent: false)
                    arrayOfButtons.append(newButton)
                }  else if index == 2 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[1], button: button2, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 3 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[2], button: button3, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 4 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[3], button: button4, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 5 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[4], button: button5, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 6 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[5], button: button6, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 7 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[6], button: button7, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 8 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[7], button: button8, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 9 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[8], button: button9, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 10 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[9], button: button10, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 11 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[10], button: button11, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 12 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[11], button: button12, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 13 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[12], button: button13, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 14 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[13], button: button14, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 15 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[14], button: button15, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 16 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[15], button: button16, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 17 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[16], button: button17, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 18 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[17], button: button18, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 19 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[18], button: button19, sent: false)
                    arrayOfButtons.append(newButton)
                } else if index == 20 {
                    let newButton = button(selected: false, character: arrayOfCharactersToBeSent[19], button: button12, sent: false)
                    arrayOfButtons.append(newButton)
                }
            }
            let newConsole = individualConsole(periph: periph, arrayOfButtons: arrayOfButtons)
            arrayOfConsoles.append(newConsole)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        infoSendButton.removeTarget(self, action: "sendCharacters", forControlEvents: UIControlEvents.TouchUpInside)
        infoSendButton.addTarget(self, action: "sendCharacters", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func sendCharacters() {
        print("BUTTON WAS SELECTED")
        print(periphArray)
        
        for index in 0..<periphArray.count {
            for index2 in 0..<arrayOfConsoles[index].arrayOfButtons.count {
                if arrayOfConsoles[index].arrayOfButtons[index2].selected == true {
                    for periphChar in periphCharArray {
                        if periphChar.periph == arrayOfConsoles[index].periph {
                            if arrayOfConsoles[index].arrayOfButtons[index2].sent == false {
                                let charString = arrayOfConsoles[index].arrayOfButtons[index2].character
                                print(charString)
                                let data = charString!.dataUsingEncoding(NSUTF8StringEncoding)
                                //                            print(currentTimeMillis())
                                periphChar.periph!.writeValue(data!, forCharacteristic: periphChar.char!, type: CBCharacteristicWriteType.WithResponse)
                                //                            print(currentTimeMillis())
                                arrayOfConsoles[index].arrayOfButtons[index2].sent = true
                            }
                        }
                    }
                }
            }
        }
        print("__________________________")
        for index in 0..<arrayOfConsoles.count {
            for index2 in 0..<arrayOfConsoles[index].arrayOfButtons.count {
                arrayOfConsoles[index].arrayOfButtons[index2].sent = false
            }
        }
    }
    
}
func currentTimeMillis() -> Int64{
    let nowDouble = NSDate().timeIntervalSince1970
    return Int64(nowDouble*1000*1000)
}