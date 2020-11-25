//
//  MainTextView.swift
//  ToDo
//
//  Created by Влад Барченков on 03.11.2020.
//

import UIKit

class MainTextView: UITextView {
    
    let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        font = .systemFont(ofSize: 17, weight: .regular)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        textContainerInset = padding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
