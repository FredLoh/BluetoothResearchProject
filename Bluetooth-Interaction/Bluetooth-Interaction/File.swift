//
//  File.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 11/Jan/16.
//  Copyright © 2016 JeongGroup. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

func generateBottomSelectionBar(leftButton: UIButton, rightButton: UIButton) -> UIView  {
    let bottomBar = UIView()
    bottomBar.addSubview(leftButton)
    bottomBar.addSubview(rightButton)

    leftButton.setBackgroundImage(UIImage(named: "next"), forState: UIControlState.Normal)
    rightButton.setBackgroundImage(UIImage(named: "next"), forState: UIControlState.Normal)
    
    leftButton.snp_makeConstraints { (make) -> Void in
        make.centerY.equalTo(bottomBar)
        make.left.equalTo(bottomBar).offset(5)
        make.height.width.equalTo(50)
    }
    rightButton.snp_makeConstraints { (make) -> Void in
        make.centerY.equalTo(bottomBar)
        make.right.equalTo(bottomBar).offset(-5)
        make.height.width.equalTo(50)
    }
    return bottomBar
}

func generateMessageButton(button: UIButton, label: String) {
    let buttonLabel = UILabel()
    button.addSubview(buttonLabel)
    button.backgroundColor = lightRed
    buttonLabel.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(button)
    }
    buttonLabel.text = label
    buttonLabel.font = UIFont.systemFontOfSize(40, weight: UIFontWeightRegular)
}