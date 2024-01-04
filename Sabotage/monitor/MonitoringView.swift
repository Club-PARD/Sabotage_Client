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
//        VStack {
//            DeviceActivityReport(context, filter: filter)
//                .frame(width: 150, height: 150)
//                .background(Color.green)
//                .onAppear {
//                    filter = DeviceActivityFilter(
//                        segment: .daily(
//                            during: Calendar.current.dateInterval(
//                                of: .day, for: .now
//                            ) ?? DateInterval()
//                        ),
//                        users: .all,
//                        devices: .init([.iPhone]),
//                        applications: scheduleVM.selection.applicationTokens,
//                        categories: scheduleVM.selection.categoryTokens
//                    )
//                    
//                    // Console에 값을 출력합니다.
//                    print("🐥 Current Filter: \(filter)")
//                    print("🍀Current Context: \(context)")
//                }.background(.red)
//        }.background(Color.yellow)
        DeviceActivityReport(context, filter: filter)
            .frame(width: 150, height: 150)
            .background(Color.green)
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
            }.background(.red)
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView()
    }
}
