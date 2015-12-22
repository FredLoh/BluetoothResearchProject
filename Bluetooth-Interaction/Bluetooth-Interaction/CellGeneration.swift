//
//  CellGeneration.swift
//  Bluetooth-Interaction
//
//  Created by Frederik Lohner on 22/Dec/15.
//  Copyright © 2015 JeongGroup. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
func generatePeripheralCell(name: String, identifier: String, color: Bool) -> UITableViewCell {
    let periphCell = UITableViewCell()
    let nameLabel = UILabel()
    let identifierLabel = UILabel()
    let separatorBar = UIView()
    
    periphCell.addSubview(nameLabel)
    periphCell.addSubview(identifierLabel)
    periphCell.addSubview(separatorBar)
    
    nameLabel.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(periphCell).offset(10)
        make.left.equalTo(periphCell).offset(5)
        make.right.equalTo(periphCell).offset(-5)
    }
    identifierLabel.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel.snp_bottom).offset(5)
        make.left.equalTo(periphCell).offset(5)
        make.right.equalTo(periphCell).offset(-5)
    }
    separatorBar.snp_makeConstraints { (make) -> Void in
        make.left.right.bottom.equalTo(periphCell)
        make.height.equalTo(0.5)
    }
    nameLabel.text = name
    identifierLabel.text = identifier
    
    nameLabel.adjustsFontSizeToFitWidth = true
    identifierLabel.adjustsFontSizeToFitWidth = true
    separatorBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
    
    periphCell.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.30)
    if color == true {
        periphCell.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.30)
    }
    
    return periphCell
}