//
//  LimitItemApi.swift
//  Sabotage
//
//  Created by 김하람 on 1/4/24.
//

import Foundation
import SwiftUI

extension Notification.Name {
    static let addLimitNotification = Notification.Name("addLimitNotification")
}

// MARK: - [Create] ActionItem
func limitPostRequest(with category: String, content: String) {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)actionItem/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    print("✅ Valid URL = \(url)")
    print("🥹 userId = \(userId)")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body:[String: AnyHashable] = [
        "category": category,
        "content": content
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
            return
        }
        
        guard let data = data, !data.isEmpty else {
            print("✅ [actionPostRequest] No data returned from the server")
            return
        }
        do {
            // 데이터를 성공적으로 받은 경우, 해당 데이터를 JSON으로 파싱하기
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: .prettyPrinted),
               let convertString = String(data: jsonData, encoding: .utf8) {
                print("✅ Success: \(convertString)")
            } else {
                print("✅ Success with JSON response: \(jsonResponse)")
            }
            // 메인 스레드에서 알림 전송
            DispatchQueue.main.async {
                 NotificationCenter.default.post(name: .addNotification, object: nil)
                
                print("✅ [actionPostRequest] Notification posted in actionPostRequest")
            }
        } catch {
            print("🚨 Error parsing JSON: ", error)
        }

    }
    task.resume()
}

// MARK: - [Update] ActionItem (ui 필요)
func limitPatchRequest(with category: String, content: String) {
    guard let url = URL(string: "\(urlLink)actionItem/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "category": category,
        "content": content
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ Success: \(jsonResponse)")

            DispatchQueue.main.async {
                // 필요한 경우 NotificationCenter를 사용하여 알림 보내기
                // NotificationCenter.default.post(name: .addNotification, object: nil)
            }
        } catch {
            print("🚨 Error parsing JSON: ", error)
        }

    }
    task.resume()
}

// MARK: - 아직 구현 중
func showLimitPatchRequest(with category: String, content: String) {
    guard let url = URL(string: "\(urlLink)actionItem/expose/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "category": category,
        "content": content
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .addNotification, object: nil)
                }
            }
        } catch {
            print("🚨 ", error)
        }
    }
    task.resume()
}
