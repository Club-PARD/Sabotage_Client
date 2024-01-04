import DeviceActivity
import SwiftUI

struct MonitoringView: View {
    @EnvironmentObject var scheduleVM: ScheduleVM
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day,
                for: .now
            ) ?? DateInterval()
        )
    )

    @State private var selectedDate: Date = Date() // Added this line
    
    var body: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)
                .frame(width: 150, height: 200)
                .background(Color.gray) // Changed to Color.gray (assuming .base200 is a custom color)
                .onAppear {
                    filter = DeviceActivityFilter(
                        segment: .daily(
                            during: Calendar.current.dateInterval(
                                of: .day, for: .now
                            ) ?? DateInterval()
                        ),
                        users: .all,
                        devices: .init([.iPhone]),
                        applications: scheduleVM.selection.applicationTokens,
                        categories: scheduleVM.selection.categoryTokens
                    )
                    
                    // Console에 값을 출력합니다.
                    print("🐥 Current Filter: \(filter)")
                    print("🍀Current Context: \(context)")
                }
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
                .onChange(of: selectedDate) { newValue in
                    print("🦢Selected Date: \(newValue)")
                    // You can perform actions or notify Main.swift here
                }
        }
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView()
    }
}
