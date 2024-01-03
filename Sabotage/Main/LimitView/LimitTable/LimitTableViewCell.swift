import UIKit

class LimitTableViewCell: UITableViewCell {
   
    var titleLabel: UILabel!
    var timeBudget: UILabel!
//    var timeBudget: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .blue
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeBudget = UILabel()
        timeBudget.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        timeBudget.textColor = .blue
        
        contentView.addSubview(timeBudget)
        timeBudget.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            timeBudget.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeBudget.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30)
        ])
        func configure(with title: String, timeBudgets: Int) {
            // Configure cell with data
            titleLabel.text = title
            timeBudget.text = String(timeBudgets)
            
        }
    }
}
