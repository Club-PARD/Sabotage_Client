import UIKit

class SaveActionItemController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // "명상" 텍스트를 보여줄 레이블 생성
        let meditationLabel = UILabel()
        meditationLabel.text = "명상"
        meditationLabel.textAlignment = .center
        meditationLabel.font = UIFont.systemFont(ofSize: 40)
        meditationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(meditationLabel)
        
        // Auto Layout을 사용하여 레이블을 페이지 중앙에 위치시킴
        NSLayoutConstraint.activate([
            meditationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            meditationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        // "알겠습니다" 텍스트를 보여줄 레이블 생성
        let understandLabel = UILabel()
        understandLabel.text = "해당 카테고리를 실행하기 위해 가장 작게 실천할 행동을 적어주세요."
        understandLabel.textAlignment = .center
        understandLabel.font = UIFont.systemFont(ofSize: 23)
        understandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(understandLabel)
        
        // Auto Layout을 사용하여 레이블을 "명상" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            understandLabel.topAnchor.constraint(equalTo: meditationLabel.bottomAnchor, constant: 20),
            understandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // 사용자가 입력할 수 있는 텍스트 필드 생성
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드를 뷰에 추가
        view.addSubview(textField)
        
        // Auto Layout을 사용하여 텍스트 필드를 "알겠습니다" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: understandLabel.bottomAnchor, constant: 50),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
