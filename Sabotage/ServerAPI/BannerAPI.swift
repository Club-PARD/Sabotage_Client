//
//  BannerAPI.swift
//  Sabotage
//
//  Created by 김하람 on 1/4/24.
//

import Foundation

func EjectionPostRequest() {
    // 서버 링크가 유요한지 확인
    guard let url = URL(string: "\(urlLink)ejection/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }
    print("✅ Valid URL = \(url)")
    print("🥹 userId = \(userId)")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    let body:[String: AnyHashable] = [
//        "category": category,
//        "content": content
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
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
//                 NotificationCenter.default.post(name: .addNotification, object: nil)
                
                print("✅ [actionPostRequest] Notification posted in actionPostRequest")
            }
        } catch {
            print("🚨 Error parsing JSON: ", error)
        }

    }
    task.resume()
}
