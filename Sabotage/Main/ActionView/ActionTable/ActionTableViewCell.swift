//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
   
    var categoryLabel: UILabel!
    var contentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        categoryLabel.textColor = .blue
        
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        contentLabel.textColor = .blue
        
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30)

        ])
        func configure(with category: String, content: String) {
            // Configure cell with data
            categoryLabel.text = category
            contentLabel.text = content
        }
    }
}
