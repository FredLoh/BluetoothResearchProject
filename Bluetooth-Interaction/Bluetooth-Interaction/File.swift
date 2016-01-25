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
import ChameleonFramework

func generateBottomSelectionBar(leftButton: UIButton, rightButton: UIButton) -> UIView  {
    let bottomBar = UIView()
    bottomBar.addSubview(leftButton)
    bottomBar.addSubview(rightButton)

    leftButton.setBackgroundImage(UIImage(named: "back"), forState: UIControlState.Normal)
    rightButton.setBackgroundImage(UIImage(named: "forward"), forState: UIControlState.Normal)
    
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

func generateMessageButton(button: UIButton, label: String, namelabel: String) {
    let buttonLabel = UILabel()
    let toplabel = UILabel()
    button.addSubview(buttonLabel)
    button.addSubview(toplabel)
    button.backgroundColor = lightRed
    buttonLabel.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(button)
    }
    toplabel.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(buttonLabel)
        make.bottom.equalTo(buttonLabel.snp_top).offset(-2)
    }
    buttonLabel.text = label
    buttonLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: FlatRed(), isFlat: true)
    buttonLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)
    toplabel.text = namelabel
    toplabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: FlatRed(), isFlat: true)
    toplabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)
    button.layer.cornerRadius = 8.0
    button.clipsToBounds = true
}