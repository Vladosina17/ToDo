//
//  UILabel.swift
//  ToDo
//
//  Created by Влад Барченков on 02.11.2020.
//

import UIKit

extension UILabel {
    
    convenience init (text: String, font: UIFont? = .systemFont(ofSize: 17, weight: .regular),  textColor: UIColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1607843137, alpha: 1)) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
