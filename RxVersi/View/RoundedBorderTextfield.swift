//
//  RoundedBorderTextfield.swift
//  RxVersi
//
//  Created by Marvin Böddeker on 07.11.17.
//  Copyright © 2017 Marvin Böddeker. All rights reserved.
//

import UIKit

class RoundedBorderTextfield: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2579534675, green: 0.4541416886, blue: 1, alpha: 1) ])
        attributedPlaceholder = placeHolder
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = frame.height / 2
        layer.borderColor = #colorLiteral(red: 0.2579534675, green: 0.4541416886, blue: 1, alpha: 1)
        layer.borderWidth = 3
    }

}
