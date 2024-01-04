import UIKit

class LimitTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let cellImageView = UIImageView()
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    var titleLabel: UILabel!
    var timeBudget: UILabel!
//    var timeBudget: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupLayout() {
        
        contentView.backgroundColor = .base50
        contentView.addSubview(cellBackgroundView)
        
        // titleLabel 설정
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // cellImageView 설정
        cellImageView.contentMode = .scaleAspectFit
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 350),
            cellImageView.heightAnchor.constraint(equalToConstant: 150),

    
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

    func configure(with imageName: String, title: String) {
        cellImageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
