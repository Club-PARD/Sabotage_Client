import UIKit

let scrollView = UIScrollView()
let contentView = UIView()
let label1 = UILabel()
let label2 = UILabel()
let label3 = UILabel()
let label4 = UILabel()
let updateTime = UILabel()

let rankingTableView = RankingTableView()
let rankingBG = UIButton(type: .custom)



class AnalysisVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        scrollViewUI()
        contentViewUI()
        
        titleUI()
        
        rankingUI()
    }
    
    func scrollViewUI() {
        // MARK: - UIScrollView 생성
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        // MARK: ScrollView autolayout 설정
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func contentViewUI() {
        // MARK: - 스크롤뷰 content 추가
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)

        // MARK: - contentView의 오토레이아웃 설정 -> 이거 해야 스크롤 됨.
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

    }
    
    func titleUI() {
        // MARK: - contentView에 추가할 content 생성 및 설정
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "이번주"
        label1.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label1.textColor = .black
        label1.numberOfLines = 0
        // MARK: - 스크롤 방향 설정
        contentView.addSubview(label1)
        
        // MARK: - contentView에 추가할 content 생성 및 설정
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "사용자 순위"
        label2.font = UIFont.systemFont(ofSize: 28, weight: .regular) // "Title 1-Regular-28pt"
        label2.textColor = .black
        label2.numberOfLines = 0
        contentView.addSubview(label2)
        
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "변화량"
        label3.font = UIFont.systemFont(ofSize: 20, weight: .regular) // "Title 3-Regular-20pt"
        label3.textColor = .black
        label3.numberOfLines = 0
        contentView.addSubview(label3) // label3를 contentView에 추가
        
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "앱 별 사용량"
        label4.font = UIFont.systemFont(ofSize: 17, weight: .semibold) // "Headline-Semibold-17pt"
        label4.textColor = .black
        label4.numberOfLines = 0
        contentView.addSubview(label4)
        
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 50),
            label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 1000),
            label3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 50),
            label4.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
//            updateTime.topAnchor.constraint(equalTo: rankingTableView.bottomAnchor, constant: -200),
//            updateTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func rankingUI() {
        // 테이블 뷰를 먼저 contentView에 추가합니다.
        rankingTableView.translatesAutoresizingMaskIntoConstraints = false
        rankingTableView.backgroundColor = .brown
        contentView.addSubview(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 테이블 뷰 위치 설정
            rankingTableView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50)),
        ])
        
        // rankingBG를 contentView에 추가합니다.
        rankingBG.translatesAutoresizingMaskIntoConstraints = false
        rankingBG.contentMode = .scaleAspectFit
        rankingBG.backgroundColor = .base100
        rankingBG.setImage(UIImage(named: "RankingBG"), for: .normal)
        rankingBG.layer.cornerRadius = 20
        rankingBG.layer.masksToBounds = true
        contentView.addSubview(rankingBG)
        
        // rankingBG를 rankingTableView 위에 올리기 위해 순서를 조정합니다.
//        contentView.bringSubviewToFront(rankingBG)
        contentView.bringSubviewToFront(label2)
        contentView.bringSubviewToFront(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 배경 이미지 버튼 위치 설정
            rankingBG.topAnchor.constraint(equalTo: label2.topAnchor, constant: -20),
            rankingBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankingBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rankingBG.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50) + 180),
        ])
    }

}
