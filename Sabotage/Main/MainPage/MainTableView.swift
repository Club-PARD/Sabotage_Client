//
//  MainTableView.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import Foundation
import UIKit
import SnapKit
import Then

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == actionTableView {
            return actionItems.count
        }
        else if tableView == limitTableView {
            return limitItems.count
        }
        return 0
    }
    
    
    func addNewItem(item: LimitDummyDataType) {
        // 데이터 소스 업데이트
        limitItems.append(item)

        // 테이블 뷰에 새로운 셀 추가
        let newIndexPath1 = IndexPath(row: limitItems.count - 1, section: 0)
        limitTableView.insertRows(at: [newIndexPath1], with: .automatic)
        
        print("제한 서비스 추가함.")
    }
    
    func addNewActionItem(item: ActionDummyDataType) { // 'limit' -> 'action'
        // 데이터 소스 업데이트
        actionItems.append(item) // 'limit' -> 'action'

        // 테이블 뷰에 새로운 셀 추가
        let newIndexPath2 = IndexPath(row: actionItems.count - 1, section: 0) // 'limit' -> 'action'
        actionTableView.insertRows(at: [newIndexPath2], with: .automatic) // 'limit' -> 'action'
        
        print("액션 아이템 추가함.")
    }

    // 셀을 선택했을 때의 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == actionTableView {
            // ActionTableView에서 셀을 선택한 경우 동작 정의
            print("ActionTableView의 \(indexPath.row) 번째 셀 선택됨")
        } else if tableView == limitTableView {
            // LimitTableView에서 셀을 선택한 경우 동작 정의
            print("LimitTableView의 \(indexPath.row) 번째 셀 선택됨")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == actionTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as? ActionTableViewCell else {
                return UITableViewCell()
            }

            let imageName = "main_actiontableview.png"
            cell.configure(with: imageName)
            return cell
        }
        
        if tableView == limitTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath) as? LimitTableViewCell else {
                return UITableViewCell()
            }

            let imageName = "main_limittableview.png" // Provide the image name from your data source
            let title = "" // Provide the title from your data source
            cell.configure(with: imageName, title: title) // Pass both imageName and title
            return cell
        }
        
        // Other table view configurations
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == actionTableView {
            // Set the desired height for the actionTableView cells
            return 100 // Adjust this value to the height you prefer
        }
        if tableView == limitTableView {
            // Set the desired height for the actionTableView cells
            return 150 // Adjust this value to the height you prefer
        }

        // Return a default height for other table views if needed
        return UITableView.automaticDimension
    }

        // MARK: - 데이터 전달 후 셀 추가를 위한 함수.
    @objc func addCellButtonTapped() {
        // 버튼 탭 시 실행될 액션
        // 예: 새로운 데이터 항목 추가 등
    }
}
