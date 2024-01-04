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
            
            // 선택한 셀의 정보 가져오기
            let selectedActionItem = actionItems[indexPath.row]
            
            // 전환될 뷰 컨트롤러 생성
            let saveActionItemController = SaveActionItemController()
            
            // 전달할 데이터 설정
            saveActionItemController.selectedActionItem = selectedActionItem
            
            // 뷰 컨트롤러 전환
            navigationController?.pushViewController(saveActionItemController, animated: true)
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == actionTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as? ActionTableViewCell else {
                return UITableViewCell()
            }

            // actionItems 배열에서 해당 indexPath의 데이터를 가져옴
            let actionItem = actionItems[indexPath.row]
            // Assuming actionItem.category is a String representation of category number
            if let categoryInt = Int(actionItem.category) {
                cell.categoryType.text = getCategoryTypeString(for: categoryInt)
                cell.categoryImage.image = UIImage(named: "category\(categoryInt).png")
            } else {
                cell.categoryType.text = "Unknown"
                cell.categoryImage.image = nil
            }

            cell.contentLabel.text = actionItem.content

            return cell
        }
        
        if tableView == limitTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath) as? LimitTableViewCell else {
                return UITableViewCell()
            }

            // limitItems 배열에서 해당 indexPath의 데이터를 가져옴
            let limitItem = limitItems[indexPath.row]
            // limitItem의 데이터를 셀에 구성

            cell.titleLabel.text = limitItem.title
            cell.timeBudget.text = String(limitItem.timeBudget)

//            cell.configure(with: limitItem.description, title: limitItem.title) // 'configure' 메서드는 적절히 수정 필요

            return cell
        }
        
        // 다른 테이블 뷰 구성이 필요한 경우
        return UITableViewCell()
    }

    
    func getCategoryTypeString(for category: Int) -> String {
        switch category {
        case 1:
            return "운동"
        case 2:
            return "셀프케어"
        case 3:
            return "생활"
        case 4:
            return "생산성"
        case 5:
            return "성장"
        case 6:
            return "수면"
        default:
            return "기타"
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == actionTableView {
            // Set the desired height for the actionTableView cells
            return 120 // Adjust this value to the height you prefer
        }
        if tableView == limitTableView {
            // Set the desired height for the actionTableView cells

            return 100 // Adjust this value to the height you prefer

        }
        
        // Return a default height for other table views if needed
        return UITableView.automaticDimension
    }
}

