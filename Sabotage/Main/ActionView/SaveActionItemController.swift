////
////  SaveActionItemController.swift
////  Sabotage
////
////  Created by 오성진 on 12/27/23.
////
//  AddActionItemController.swift


import UIKit
import SnapKit

class SaveActionItemController: UIViewController, UITextFieldDelegate {

    var textField: UITextField = UITextField()
    var selectedButtonName: String = "" // 선택된 버튼의 이름을 저장하는 변수
    var selectedCard: Int = 0

    // MARK: 변수
    //    let backButton = UIButton(type: .system)
    let closeButton = UIImageView(image: UIImage(named: "closeButton.png"))
    let Title = UIImageView(image: UIImage(named: "action_title.png"))
    let category1 = UIImageView(image: UIImage(named: "addaction_category1.png"))
    let inputItem = UIImageView(image: UIImage(named: "addaction_inputitem.png"))
    var content: String = "" // MARK: 외부에서 받을 content
    
    let saveButton = UIImageView(image: UIImage(named: "saveButton.png"))
    let deleteButton = UIImageView(image: UIImage(named: "deleteButton.png"))
    
    let inputField: UITextField = {
        let textField = UITextField()
//        textField.placeholder = "예) 자리에 앉기"
        textField.backgroundColor = .clear // Set the background color to clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    // 외부에서 텍스트를 전달받아 content에 할당하는 함수
    func receiveTextFromExternalSource(text: String) {
        content = text // 외부에서 받은 텍스트를 content에 할당
        inputField.text = content // content를 textField의 placeholder로 설정
    }
    
    // MARK: UI
    func setUI() {

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        
        Title.contentMode = .center
        Title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Title)
        
        // category 이미지 설정
        let categoryImageName = "addaction_category\(selectedCard).png"
        if let categoryImage = UIImage(named: categoryImageName) {
            category1.image = categoryImage
        } else {
            // 선택된 카드에 맞는 이미지가 없을 경우에 대한 처리
            print("해당하는 이미지가 없습니다.")
        }
        category1.contentMode = .scaleAspectFit
        category1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(category1)
        
        inputItem.contentMode = .scaleAspectFit
        inputItem.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputItem)
        
        view.addSubview(inputField)
        
        saveButton.contentMode = .scaleAspectFit
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        deleteButton.contentMode = .scaleAspectFit
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        
    }
    
    // MARK: constraint
    func setConstraint() {
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            Title.widthAnchor.constraint(equalToConstant: 80),
            
            category1.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            category1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            category1.widthAnchor.constraint(equalToConstant: 370),
            category1.heightAnchor.constraint(equalToConstant: 90),
            
            inputItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputItem.widthAnchor.constraint(equalToConstant: 370),
            inputItem.heightAnchor.constraint(equalToConstant: 120),
            
            inputField.topAnchor.constraint(equalTo: inputItem.topAnchor, constant: 10),
            inputField.leadingAnchor.constraint(equalTo: inputItem.leadingAnchor, constant: 10),
            inputField.trailingAnchor.constraint(equalTo: inputItem.trailingAnchor, constant: -10),
            inputField.bottomAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: -10),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            saveButton.heightAnchor.constraint(equalToConstant: 70),
            
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
//            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteButton.widthAnchor.constraint(equalToConstant: 60),
            deleteButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
        
        inputField.text = content
        
        print("Selected card: \(selectedCard)")
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture1.cancelsTouchesInView = false // Allow touch events to pass through the view hierarchy
        view.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGesture2)
        closeButton.isUserInteractionEnabled = true
        
//        inputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func closeButtonTapped() {
        if let mainVC = navigationController?.viewControllers.first(where: { $0 is MainVC }) {
            navigationController?.popToViewController(mainVC, animated: true)
        } else {
            let mainVC = MainVC() // Instantiate your MainVC if not in the navigation stack
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        // Check if both selectedCard and inputField have valid values
        guard let text = inputField.text, !text.isEmpty else {
            print("Text is missing")
            return
        }
        
        // Call actionPostRequest to send data
        //        actionPostRequest(with: "\(selectedCardValue)", content: text)
        actionPostRequest(with: "\(selectedCard)", content: text)
        // MARK: - [Create] Post ActionItem
        // actionPostRequest(with: '여기 카테고리 변수', content: '내용 변수')

        let mainVC = MainVC() // Create a new instance of MainVC
        navigationController?.pushViewController(mainVC, animated: true) // Present MainVC
    }

    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "정말 삭제하시겠어요?", message: "삭제하면 다시 불러올 수 없어요", preferredStyle: .alert)

        // 취소 버튼
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        // 삭제 버튼
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            // 삭제 작업 수행
        }))
        present(alert, animated: true, completion: nil)
    }
    // 저장하기 
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if let text = textField.text, !text.isEmpty {
//            completeButton.image = UIImage(named: "addaction_completebutton.png")
//        } else {
//            completeButton.image = UIImage(named: "addaction_completebuttonUntapped.png")
//        }
//    }
}
