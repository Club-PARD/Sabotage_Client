import UIKit

class ActionItemController: UIViewController {
    
    // MARK: 변수
    var selectedCard = UILabel()
    var selectedCardTag: Int?
    
    let Title = UIImageView(image: UIImage(named: "action_title.png"))
    let tracker1 = UIImageView(image: UIImage(named: "action_tracker1.png"))
    let subtitle = UIImageView(image: UIImage(named: "action_subtitle.png"))
    
    let actionCardImages: [UIImage] = [
        UIImage(named: "action_card1.png")!,
        UIImage(named: "action_card2.png")!,
        UIImage(named: "action_card3.png")!,
        UIImage(named: "action_card4.png")!,
        UIImage(named: "action_card5.png")!,
        UIImage(named: "action_card6.png")!
    ]
    var actionCardImageViews: [UIImageView] = []
    
    let backButton = UIImageView(image: UIImage(named: "action_backbutton.png"))
    let nextButton = UIImageView(image: UIImage(named: "action_nextbutton.png"))


    // MARK: UI
    func setUI() {
        Title.contentMode = .center
        Title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Title)


class ActionItemController: UIViewController{
    
//    weak var delegate: ActionItemDelegate?
    
    let titleLabel = UILabel()
    let backButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    let aButton = UIButton(type: .system)
    let bButton = UIButton(type: .system)
    let cButton = UIButton(type: .system)
    let dButton = UIButton(type: .system)
    let eButton = UIButton(type: .system)
    let fButton = UIButton(type: .system)
    
    var actionItemData: ActionItemData?
    
    var selectedRadioButton: UIButton?
    var selectedButtonName: String = "" // 선택된 버튼의 이름을 저장하는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tracker1.contentMode = .scaleAspectFit
        tracker1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tracker1)
        
        subtitle.contentMode = .scaleAspectFit
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitle)
        
        for image in actionCardImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            actionCardImageViews.append(imageView)
            view.addSubview(imageView)
        }
        
        backButton.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        nextButton.contentMode = .scaleAspectFit
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        for (index, imageView) in actionCardImageViews.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCardTapped(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index + 1
        }
    }
    
    @objc func actionCardTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            let tappedTag = imageView.tag
            
            // 탭된 이미지가 이미 선택된거면 되돌리기.
            if selectedCardTag == tappedTag {
                imageView.image = UIImage(named: "action_card\(tappedTag).png")
                selectedCardTag = nil
            } else {
                // 이전에 선택된 카드를 되돌림.
                if let prevSelectedTag = selectedCardTag,
                   let prevSelectedImageView = actionCardImageViews.first(where: { $0.tag == prevSelectedTag }) {
                    prevSelectedImageView.image = UIImage(named: "action_card\(prevSelectedTag).png")
                }
                // 탭된 이미지 선택.
                imageView.image = UIImage(named: "action_card\(tappedTag)selected.png")
                selectedCardTag = tappedTag
            }
        }
    }

    // MARK: constraint
    func setConstraint() {
        NSLayoutConstraint.activate([
            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            Title.widthAnchor.constraint(equalToConstant: 80),
            Title.heightAnchor.constraint(equalToConstant: 25),
            
            tracker1.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            tracker1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tracker1.widthAnchor.constraint(equalToConstant: 415),
            tracker1.heightAnchor.constraint(equalToConstant: 50),
            
            subtitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitle.widthAnchor.constraint(equalToConstant: 280),
            subtitle.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        var previousCardImageView: UIImageView?
        for imageView in actionCardImageViews {
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 370),
                imageView.heightAnchor.constraint(equalToConstant: 70),
            ])
            
            // Set aspect ratio constraint
            let aspectConstraint = NSLayoutConstraint(item: imageView,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: imageView,
                                                     attribute: .width,
                                                     multiplier: imageView.image!.size.height / imageView.image!.size.width,
                                                     constant: 0)
            aspectConstraint.isActive = true
            
            if let previous = previousCardImageView {
                imageView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 20).isActive = true
            } else {
                imageView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 25).isActive = true
            }
            
            previousCardImageView = imageView
        }
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 180),
            backButton.heightAnchor.constraint(equalToConstant: 80),
            
            // Next button constraints
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 180),
            nextButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonTapped))
            nextButton.isUserInteractionEnabled = true
            nextButton.addGestureRecognizer(tapGesture)
    }
        
    @objc func nextButtonTapped() {

        let addActionItemController = AddActionItemController()
        
        // Pass selectedCard value to AddActionItemController
        if let selectedCardValue = Int(selectedCard.text ?? "") {
            addActionItemController.selectedCard = selectedCardValue

        if selectedRadioButton != nil {
            selectedButtonName = (selectedRadioButton?.titleLabel?.text)! // 선택된 버튼의 이름을 변수에 저장

            let addActionItemController = AddActionItemController()
            addActionItemController.selectedButtonName = selectedButtonName // 선택된 버튼의 이름을 전달
//            addActionItemController.delegate = self // Set ActionItemController as the delegate

            navigationController?.pushViewController(addActionItemController, animated: true)

        }
        
        navigationController?.pushViewController(addActionItemController, animated: true)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setUI()
        setConstraint()
    }
}
