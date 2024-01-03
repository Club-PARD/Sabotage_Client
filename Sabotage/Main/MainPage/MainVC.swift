//Main

//MainVC.swift - 메인 페이지

import UIKit
import SwiftUI
import SnapKit
import Then

struct ActionData {
    let category: String
    let content: String
}


protocol LimitItemDelegate: AnyObject {
    func addNewLimitItem(_ itemName: String)
}

class MainVC: UIViewController, LimitItemDelegate{
    //    var actionss: ActionTop?
    var segmentedControl = UISegmentedControl()
    
    // MARK: - ".custom"으로 설정해야 이미지를 가진 버튼 만들기 가능
    var actionButton = UIButton(type: .custom)
    var limitButton = UIButton(type: .custom)
    
    var addButton = UIButton(type: .system)
    var tabBar = UITabBar()
    
    var pieChartViewController: PieChart!
    //    var firstButton = UIButton(type: .system)
    //    var secondButton = UIButton(type: .system)
    //    var thirdButton = UIButton(type: .system)
    
    var limitTableView: UITableView!
    var actionTableView: UITableView!
    
    let logoImageView = UIImageView(image: UIImage(named: "main_logo.png"))
    let logoText = UIImageView(image: UIImage(named: "main_logoText.png"))
    let pieChartBG = UIImageView(image: UIImage(named: "main_pieChartBG.png"))
    let today = UILabel()
    let ranking1App = UIImageView(image: UIImage(named: "main_ranking1App.png"))
    let ranking2App = UIImageView(image: UIImage(named: "main_ranking2App.png"))
    let ranking3App = UIImageView(image: UIImage(named: "main_ranking3App.png"))
    let forMoreAnalysis = UIImageView(image: UIImage(named: "main_forMoreAnalysis.png"))
    
    
    let actionTogglebuttonTapped = UIImageView(image: UIImage(named: "main_actionToggleButtonTapped.png"))
    let limitTogglebuttonTapped = UIImageView(image: UIImage(named: "main_limitToggleButtonTapped.png"))
    
    var limitButtonVisible = false // limitbuttonTapped 이미지의 보이기 여부를 추적하는 변수
    
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    
    func updateActionTableView(with actionData: [ActionData]) {
        // actionData를 받은 후 actionItems에 추가합니다.
        for data in actionData {
            let newActionItem = ActionDummyDataType(category: data.category, content: data.content)
            actionItems.append(newActionItem)
        }
        
        // TableView 업데이트
        actionTableView.reloadData()
    }
    
    
    func toggleUI() {
        
        actionTogglebuttonTapped.contentMode = .scaleAspectFit
        view.addSubview(actionTogglebuttonTapped)
        actionTogglebuttonTapped.isHidden = false
        
        limitTogglebuttonTapped.contentMode = .scaleAspectFit
        view.addSubview(limitTogglebuttonTapped)
        limitTogglebuttonTapped.isHidden = true
        //
        
        actionTogglebuttonTapped.translatesAutoresizingMaskIntoConstraints = false
        limitTogglebuttonTapped.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.setTitle("", for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftButton)
        
        rightButton.setTitle("", for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
    }
    
    func toggleConstraintUI() {
        NSLayoutConstraint.activate([ // 이거 위치 옮길 때 아래 버튼 위치도 같이 옮기기
            actionTogglebuttonTapped.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
            actionTogglebuttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            
            actionTogglebuttonTapped.widthAnchor.constraint(equalToConstant: view.frame.width + 0),
            actionTogglebuttonTapped.heightAnchor.constraint(equalToConstant: 60),
            
            limitTogglebuttonTapped.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
            limitTogglebuttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            
            limitTogglebuttonTapped.widthAnchor.constraint(equalToConstant: view.frame.width + 0),
            limitTogglebuttonTapped.heightAnchor.constraint(equalToConstant: 60),
                                    ])
        
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
            leftButton.leadingAnchor.constraint(equalTo: actionTogglebuttonTapped.leadingAnchor, constant: 0),
            leftButton.widthAnchor.constraint(equalToConstant: 200),
            leftButton.heightAnchor.constraint(equalToConstant: 60),
            
            rightButton.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
            rightButton.trailingAnchor.constraint(equalTo: actionTogglebuttonTapped.trailingAnchor, constant: 0),
            rightButton.widthAnchor.constraint(equalToConstant: 200),
            rightButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func toggleCondition() {
        if actionTogglebuttonTapped.isHidden {
            // actionTogglebuttonTapped is hidden: show actionButton and hide limitButton
            actionTogglebuttonTapped.isHidden = false
            limitTogglebuttonTapped.isHidden = true
            actionButton.isHidden = false
            limitButton.isHidden = true
            actionTableView.isHidden = false
            limitTableView.isHidden = true
        } else {
            // actionTogglebuttonTapped is visible: hide actionButton and show limitButton
            actionTogglebuttonTapped.isHidden = true
            limitTogglebuttonTapped.isHidden = false
            actionButton.isHidden = true
            limitButton.isHidden = false
            actionTableView.isHidden = true
            limitTableView.isHidden = false
        }
    }
    
    // limitTogglebuttonTapped 버튼을 눌렀을 때 실행되는 메서드
    @objc func leftButtonTapped() {
        if actionTogglebuttonTapped.isHidden {
            // actionTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
            toggleCondition()
        }
    }
    
    // actionTogglebuttonTapped 버튼을 눌렀을 때 실행되는 메서드
    @objc func rightButtonTapped() {
        if limitTogglebuttonTapped.isHidden {
            // limitTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
            toggleCondition()
        }
    }
    
    func piechartUI() {
        pieChartViewController = PieChart()
        addChild(pieChartViewController)
        view.addSubview(pieChartViewController.view)
        pieChartViewController.didMove(toParent: self)
        
        // Buttons
        //            firstButton.setTitle("First", for: .normal)
        //            secondButton.setTitle("Second", for: .normal)
        //            thirdButton.setTitle("Third", for: .normal)
        //
        //            firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        //            secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        //            thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
        //
        //            [firstButton, secondButton, thirdButton].forEach {
        //                view.addSubview($0)
        //                $0.translatesAutoresizingMaskIntoConstraints = false
        //            }
        
        // Set constraints for the PieChart view and buttons using SnapKit
        pieChartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartViewController.view.topAnchor.constraint(equalTo: today.bottomAnchor, constant: 15),
            pieChartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            
            // pieChartViewController.view의 높이에 대한 제약을 추가하려면 필요한 제약 조건을 설정해야 합니다.
            // 제약 조건이 필요한 경우 아래와 같이 해당 높이에 대한 제약을 추가하세요.
            // pieChartViewController.view.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        //            firstButton.snp.makeConstraints {
        //                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
        //                $0.leading.equalToSuperview().offset(80)
        //            }
        //
        //            secondButton.snp.makeConstraints {
        //                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
        //                $0.centerX.equalToSuperview()
        //            }
        //
        //            thirdButton.snp.makeConstraints {
        //                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
        //                $0.trailing.equalToSuperview().offset(-80)
        //            }
    }
    
    func pieChartViewUI() {
        logoImageView.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoImageView)
        
        logoText.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoText)
        
        pieChartBG.contentMode = .scaleAspectFit // 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(pieChartBG)
        
        today.text = "오늘 사용량"
        today.textAlignment = .center
        today.font = UIFont.Callout()
        today.textColor = .base200
        today.numberOfLines = 0 // 필요에 따라 텍스트가 여러 줄로 표시되도록 설정
        pieChartBG.addSubview(today)
        
        ranking1App.contentMode = .scaleAspectFit
        ranking1App.layer.cornerRadius = 10
        ranking1App.layer.masksToBounds = true
        pieChartBG.addSubview(ranking1App)
        
        ranking2App.contentMode = .scaleAspectFit
        ranking2App.layer.cornerRadius = 10
        ranking2App.layer.masksToBounds = true
        pieChartBG.addSubview(ranking2App)
        
        ranking3App.contentMode = .scaleAspectFit
        ranking3App.layer.cornerRadius = 10
        ranking3App.layer.masksToBounds = true
        pieChartBG.addSubview(ranking3App)
        
        forMoreAnalysis.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(forMoreAnalysis)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forMoreAnalysisTapped))
        forMoreAnalysis.isUserInteractionEnabled = true
        forMoreAnalysis.addGestureRecognizer(tapGesture)
        
    }
    
    func pieChartConstraintUI() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoText.translatesAutoresizingMaskIntoConstraints = false
        pieChartBG.translatesAutoresizingMaskIntoConstraints = false
        today.translatesAutoresizingMaskIntoConstraints = false
        ranking1App.translatesAutoresizingMaskIntoConstraints = false
        ranking2App.translatesAutoresizingMaskIntoConstraints = false
        ranking3App.translatesAutoresizingMaskIntoConstraints = false
        forMoreAnalysis.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.95), // 상단에 여백을 줄 수 있도록 조정
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.15), // 좌측에 여백을 줄 수 있도록 조정
            logoImageView.widthAnchor.constraint(equalToConstant: 39.304), // 이미지의 가로 크기 조정
            logoImageView.heightAnchor.constraint(equalToConstant: 39.6), // 이미지의 세로 크기 조정
            
            logoText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31), // 상단에 여백을 줄 수 있도록 조정
            logoText.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45), // 좌측에 여백을 줄 수 있도록 조정
            logoText.widthAnchor.constraint(equalToConstant: 63), // 이미지의 가로 크기 조정
            logoText.heightAnchor.constraint(equalToConstant: 20), // 이미지의 세로 크기 조정
            
            pieChartBG.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            pieChartBG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pieChartBG.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            pieChartBG.widthAnchor.constraint(equalToConstant: 400), // 우측에 여백을 줄 수 있도록 조정
            pieChartBG.heightAnchor.constraint(equalToConstant: 300), // 이미지의 세로 크기 조정
            
            today.topAnchor.constraint(equalTo: pieChartBG.topAnchor, constant: 34),
            today.trailingAnchor.constraint(equalTo: pieChartBG.leadingAnchor, constant: 140),
            today.widthAnchor.constraint(equalToConstant: 74),
            today.heightAnchor.constraint(equalToConstant: 22),
            
            ranking1App.topAnchor.constraint(equalTo: pieChartBG.topAnchor, constant: 34),
            ranking1App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
            ranking1App.widthAnchor.constraint(equalToConstant: 35), // 이미지의 가로 크기 조정
            ranking1App.heightAnchor.constraint(equalToConstant: 35), // 이미지의 세로 크기 조정
            
            ranking2App.topAnchor.constraint(equalTo: ranking1App.bottomAnchor, constant: 20),
            ranking2App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
            ranking2App.widthAnchor.constraint(equalToConstant: 35), // 이미지의 가로 크기 조정
            ranking2App.heightAnchor.constraint(equalToConstant: 35), // 이미지의 세로 크기 조정
            
            ranking3App.topAnchor.constraint(equalTo: ranking2App.bottomAnchor, constant: 20),
            ranking3App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
            ranking3App.widthAnchor.constraint(equalToConstant: 35),
            ranking3App.heightAnchor.constraint(equalToConstant: 35),
            
            forMoreAnalysis.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290), // 상단에 여백을 줄 수 있도록 조정
            forMoreAnalysis.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            forMoreAnalysis.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45),
            forMoreAnalysis.widthAnchor.constraint(equalToConstant: 80),
            forMoreAnalysis.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    @objc func forMoreAnalysisTapped() {
        // Navigate to AnalysisVC
        let analysisVC = AnalysisVC() // Assuming AnalysisVC is your destination view controller
        navigationController?.pushViewController(analysisVC, animated: true)
    }
    
    // MARK: tableView 관련 코드
    
    var actionItems: [ActionDummyDataType] = [
        ActionDummyDataType(category: "액션 1", content: "액션 1에 대한 설명입니다."),
        ActionDummyDataType(category: "액션 2", content: "액션 1에 대한 설명입니다.")
    ]
    var limitItems: [LimitDummyDataType] = [
        LimitDummyDataType(title: "제한그룹 1", description: "제한그룹 1임다"),
        LimitDummyDataType(title: "제한그룹 2", description: "제한그룹 2임다"),
        LimitDummyDataType(title: "제한그룹 3", description: "제한그룹 3임다")
    ]
    
    // tableview data
    // LimitItemDelegate 메서드 구현
    func addNewLimitItem(_ itemName: String) {
        // LimitItemDelegate 메서드 구현
        let newLimitItem = LimitDummyDataType(title: itemName, description: "새로운 항목 설명")
        limitItems.append(newLimitItem)
        
        // TableView 업데이트
        limitTableView.reloadData()
        
        // Calculate total height of all cells in the limitTableView
        let totalTableViewHeight = limitTableView.contentSize.height
        
        // Set the content inset to accommodate the limitButton
        let bottomInset = view.bounds.height - totalTableViewHeight
        limitTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .base50
        
        pieChartViewUI()
        pieChartConstraintUI()
        toggleUI()
        toggleConstraintUI()
        piechartUI()
        
        // MARK: - getActionData
        getActionData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .addNotification, object: nil)
       
        
        // MARK: tableView 관련 코드
        actionTableView = UITableView(frame: .zero, style: .plain)
        limitTableView = UITableView(frame: .zero, style: .plain)
        
        actionTableView.backgroundColor = UIColor.green // 색을 원하는 대로 변경해주세요.
        limitTableView.backgroundColor = UIColor.blue
        
        // MARK: tableView 관련 코드
        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: "ActionCustomCell")
        limitTableView.register(LimitTableViewCell.self, forCellReuseIdentifier: "LimitCustomCell")
        
        // MARK: tableView 관련 코드
        // 뷰에 테이블뷰 추가
        view.addSubview(actionTableView)
        view.addSubview(limitTableView)
        
        actionTableView.separatorStyle = .none
        limitTableView.separatorStyle = .none
        
        // Auto Layout을 위한 설정
        actionTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -400), // UITableview 영역
            actionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Auto Layout을 위한 설정
        limitTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            limitTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -500), // UITableview 영역 (가장 최신으로 반영)
            limitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            limitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            limitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        configureTableView(actionTableView, cellClass: ActionTableViewCell.self, identifier: "ActionCustomCell")
        configureTableView(limitTableView, cellClass: LimitTableViewCell.self, identifier: "LimitCustomCell")
        
        // 초기에는 actionTableView만 보이도록 설정
        actionTableView.isHidden = false
        limitTableView.isHidden = true
        
        // 이전 화면으로 돌아가는 "< Back" 버튼 숨기기
        navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // MARK: - 디자인때 필요할 것 같아서 남겨뒀움
        
        
        //        var actionButton = UIButton(type: .system)
        actionButton.setImage(UIImage(named: "main_actionButton.png"), for: .normal)
        actionButton.contentMode = .scaleAspectFit
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.isHidden = false
        
        // actionTableView의 푸터 뷰로 actionButton을 설정
        // MARK: - 이거 안 되면 푸터 뷰 대신에 UITableViewCell 안에 버튼을 추가하는 방식 사용 -> UITableViewCell을 커스텀하여 버튼을 셀 안에 추가해야 함.
        //        actionTableView.tableFooterView = actionButton
        //
        //        NSLayoutConstraint.activate([
        //            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            actionButton.topAnchor.constraint(equalTo: actionTableView.bottomAnchor, constant: 180),
        //            actionButton.widthAnchor.constraint(equalToConstant: 390), // 이미지 크기에 맞게 조절
        //            actionButton.heightAnchor.constraint(equalToConstant: 120) // 이미지 크기에 맞게 조절]
        //        ])
        
        // actionTableView의 푸터 뷰로 actionButton을 설정
        actionTableView.tableFooterView = actionButton
        
        // 버튼을 마지막 셀 아래에 위치하도록 Auto Layout을 사용하여 조정
        NSLayoutConstraint.activate([
//            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: actionTableView.bottomAnchor, constant: 250),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            actionButton.widthAnchor.constraint(equalToConstant: 370), // 버튼의 너비 조정
            actionButton.heightAnchor.constraint(equalToConstant: 80) // 버튼의 높이 조정
            
        ])
        
        let actiontotalTableViewHeight = actionTableView.contentSize.height + actionButton.bounds.height
        
        // Set the content inset to accommodate the `limitButton`
        //        let bottomInset = view.bounds.height - totalTableViewHeight
        //        print("bottomInset = ", bottomInset)
        actionTableView.contentInset = UIEdgeInsets(top: 00, left: 0, bottom: actiontotalTableViewHeight, right: 0)
        
        limitButton.setImage(UIImage(named: "main_limitButton.png"), for: .normal)
        limitButton.contentMode = .scaleAspectFit
        limitButton.addTarget(self, action: #selector(limitButtonTapped), for: .touchUpInside)
        view.addSubview(limitButton)
        limitButton.translatesAutoresizingMaskIntoConstraints = false
        limitButton.isHidden = true
        NSLayoutConstraint.activate([
            limitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            limitButton.topAnchor.constraint(equalTo: limitTableView.bottomAnchor, constant: 450),
            limitButton.widthAnchor.constraint(equalToConstant: 350), // Adjust the width and height based on your image size
            limitButton.heightAnchor.constraint(equalToConstant: 100) // Adjust the width and height based on your image size
        ])
        
        limitTableView.tableFooterView = limitButton
        
        let totalTableViewHeight = limitTableView.contentSize.height + limitButton.bounds.height
        
        // Set the content inset to accommodate the `limitButton`
        //        let bottomInset = view.bounds.height - totalTableViewHeight
        //        print("bottomInset = ", bottomInset)
        limitTableView.contentInset = UIEdgeInsets(top: 00, left: 0, bottom: totalTableViewHeight, right: 0)
    }
    
    
    private func configureTableView(_ tableView: UITableView, cellClass: UITableViewCell.Type, identifier: String) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450), // cell이 시작되는 tableview
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.backgroundColor = UIColor.red // 원하는 색상으로 변경
        
        if tableView == actionTableView {

// //            tableView.backgroundColor = UIColor.orange // ActionTableView의 배경색을 orange로 변경
//             tableView.backgroundColor = UIColor.red

            //            tableView.backgroundColor = UIColor.orange // ActionTableView의 배경색을 orange로 변경
            tableView.backgroundColor = .base50

        } else if tableView == limitTableView {
            tableView.backgroundColor = .base50
            //            tableView.backgroundColor = UIColor.brown // LimitTableView의 배경색을 brown으로 변경
        }
        
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    //    @objc func firstButtonTapped() {
    //        pieChartViewController.firstAppUI()
    //    }
    //
    //    @objc func secondButtonTapped() {
    //        pieChartViewController.secondAppUI()
    //    }
    //
    //    @objc func thirdButtonTapped() {
    //        pieChartViewController.thirdAppUI()
    //    }
    
    func getActionData() {  // MARK: - "completion: @escaping ActionDataCompletion" 파라미터 추가
        if let url = URL(string: "\(urlLink)actionItem/\(userId)/all") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("🚨 Error: \(error.localizedDescription)")
                    return
                }
                // JSON data를 가져온다. optional 풀어줘야 함
                if let JSONdata = data {
                    let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
                    print(dataString!)
                    // JSONDecoder 사용하기
                    let decoder = JSONDecoder() // initialize
                    do {
                        let decodeData = try decoder.decode(ActionItemData.self, from: JSONdata)
                        
                        DispatchQueue.main.async {
                            self.actionItems = decodeData.data.map {
                                ActionDummyDataType(category: $0.category, content: $0.content)
                            }
                            self.actionTableView.reloadData()
                            // self.ActionItemData = decodeData
                            // self.collectionView.reloadData()
                            //                        completion(decodeData) // MARK: - // 성공 시 가져온 데이터 전달
                            print("🤢 decodeData", decodeData)
                            let categories = decodeData.data.map { $0.category }
                            print("🎃", categories)
                            let contents = decodeData.data.map { $0.content }
                            print("🎃", contents)
                            print(ActionItemData.self)
                        }
                        
                    } catch {
                        print("🚨 JSON decoding error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    
    @objc func actionButtonTapped() {

        let actionItemController = ActionItemController() // 잠깐 test
        navigationController?.pushViewController(actionItemController, animated: true)
        
        // MARK: ram - test code
        //        let monitoringView = MonitoringView()
        //        let hostingController = UIHostingController(rootView: monitoringView)
        //        navigationController?.pushViewController(hostingController, animated: true)
        
        //        //MARK: 서윤 - saveactionitem 확인
        //        let saveActionItemController = BeforeAnalysisVC()
        //        navigationController?.pushViewController(saveActionItemController, animated: true)
    }
    
    @objc func limitButtonTapped() {
        // MARK: ram - test code
        print("addButtonTapped")
        let scheduleView = ScheduleView()
        let hostingController = UIHostingController(rootView: scheduleView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    @objc func reloadCollectionView() {
        DispatchQueue.main.async {
            self.getActionData()
            self.actionTableView.reloadData()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
