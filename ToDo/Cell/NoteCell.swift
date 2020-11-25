//
//  NoteCell.swift
//  ToDo
//
//  Created by Влад Барченков on 02.11.2020.
//

import UIKit

class NoteCell: UITableViewCell {
    
    static var reuseId: String = "UserCell"
    
    var containerView: UIView = {
        
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    var headlineLabel = UILabel(text: "Заметка", font: .systemFont(ofSize: 23, weight: .bold))
    let mainTextLabel = UILabel(text: "Купить три килограмма картошки, одну мковку, четыре огурца и свеклу", font: .systemFont(ofSize: 17, weight: .regular), textColor: #colorLiteral(red: 0.4235294118, green: 0.4196078431, blue: 0.4549019608, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupCell()
    }
    
    private func setupCell() {
        
        mainTextLabel.numberOfLines = 7
        mainTextLabel.layer.cornerRadius = 8
        mainTextLabel.clipsToBounds = true
        mainTextLabel.lineBreakMode = .byWordWrapping

        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(headlineLabel)
        containerView.addSubview(mainTextLabel)

        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            headlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            headlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            headlineLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            mainTextLabel.topAnchor.constraint(equalTo: headlineLabel.topAnchor, constant: 30),
            mainTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            //mainTextLabel.heightAnchor.constraint(equalToConstant: 50),
            mainTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
