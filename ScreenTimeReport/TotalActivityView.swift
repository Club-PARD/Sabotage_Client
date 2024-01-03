//
//  TotalActivityView.swift
//  ScreenTimeReport
//
//  Created by 김하람 on 12/28/23.
//

import SwiftUI
import FamilyControls
import UserNotifications

// MARK: - MonitoringView에서 보여줄 SwiftUI 뷰
struct TotalActivityView: View {
    var activityReport: ActivityReport
    var body: some View {
        VStack(spacing: 4) {
            Section {
                // 앱을 'duration'에 따라 내림차순으로 정렬하고 상위 3개 선택
                ForEach(activityReport.apps.sorted { $0.duration > $1.duration }.prefix(3).indices, id: \.self) { index in
                    let eachApp = activityReport.apps.sorted { $0.duration > $1.duration }[index]
                    ListRow(eachApp: eachApp, index: index + 1)
                }
            }
        }
    }
}

extension AppDeviceActivity: Hashable {
    static func == (lhs: AppDeviceActivity, rhs: AppDeviceActivity) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct ListRow: View {
    var eachApp: AppDeviceActivity
    var index: Int
    @State private var showAlert = false
    @EnvironmentObject var viewModel: AppActivityViewModel
    
    var body: some View {
        HStack{
            if let token = eachApp.token {
                Label(token)
                    .labelStyle(.iconOnly)
                    .frame(width: max(0, 30), height: 78)
            }
            VStack{
                HStack {
                    Text("\(index). \(eachApp.displayName)").frame(alignment: .leading)
                        .padding(.leading, 20)
                    Spacer()
                }
                HStack {
                    Text(formatDuration(Int(eachApp.duration)))
                        .font(.headline)
                        .bold()
                        .background(Color.red)
                        .frame(minWidth: 52, alignment: .trailing).onAppear {
                        }
                    Spacer()
                }.frame(alignment: .leading)
            }.frame(alignment: .leading)
        }
        .background(.clear)
    }
    func formatDuration(_ duration: Int) -> String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        if hours > 0 {
            return "    \(hours)시간 \(minutes)분"
        } else {
            return "\(minutes)분"
        }
    }
}

class AppActivityViewModel: ObservableObject {
    var eachApp: AppDeviceActivity
    var timer: Timer?

    init(eachApp: AppDeviceActivity) {
        self.eachApp = eachApp
        startMonitoring()
    }

    func startMonitoring() {
        print("monitoring start")
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkActivityDuration()
        }
    }

    func checkActivityDuration() {
        if eachApp.duration >= 600 { // 540초 == 9분
            print("600초 됐음")
            scheduleLocalNotification(appName: eachApp.displayName)
            timer?.invalidate()
        }
    }
}

func scheduleLocalNotification(appName: String) {
    let content = UNMutableNotificationContent()
    content.title = "시간 초과"
    content.body = "\(appName) 앱의 모니터링 시간이 10분을 초과했습니다."
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error adding notification: \(error)")
        }
    }
}
