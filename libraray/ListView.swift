//
//  ListView.swift
//  Paylite HR
//
//  Created by Rajkumar Yadav on 05/08/20.
//  Copyright © 2020 sandipan. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "GothamBold", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        
    }

    func restore() {
        self.backgroundView = nil
       
    }
}


extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "GothamBold", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
       
    }

    func restore() {
        self.backgroundView = nil
       
    }
}
