////ContentView

import SwiftUI
import UIKit

//struct ContentView: View {
//    var body: some View {
//
//        // SwiftUI NavigationView 안에 UIKit 기반의 MainVC를 호스팅
//        NavigationView {
//            MainVCRepresentable()
//                .edgesIgnoringSafeArea(.all)
//                .navigationBarHidden(true) // 네비게이션 바 숨김
//
//        }
//    }
//}
//
////struct ContentView: View {
////    var body: some View {
////        NavigationView {
////            // MainVCRepresentable을 NavigationLink로 감싸기
////            NavigationLink(destination: MainVCRepresentable()) {
////                EmptyView()
////            }
////            .navigationBarHidden(true)
////        }
////    }
////}
//
//
//struct MainVCRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UITabBarController {
//        // UITabBarController 생성
//        let tabBarController = UITabBarController()
//        
//        // 탭 바에 표시할 뷰 컨트롤러들 생성
//        let mainVC = MainVC()
//        let analysisVC = AnalysisVC()
//        let profileVC = ProfileVC()
//        
//        // 각 뷰 컨트롤러에 탭 바 아이템 설정
//        mainVC.tabBarItem = UITabBarItem(title: "Main", image: nil, tag: 0)
//        analysisVC.tabBarItem = UITabBarItem(title: "Analysis", image: nil, tag: 1)
//        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
//        
//        // 탭 바 색상 설정
//        tabBarController.tabBar.backgroundColor = .systemGray6
//        tabBarController.tabBar.tintColor = .label
//        
//        // 탭 바에 뷰 컨트롤러들 추가
//        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]
//        
//        return tabBarController
//    }
//
//    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
//        // 필요 시 ViewController를 업데이트하는 로직을 추가
//    }
//}

////
////import SwiftUI
////
////struct ContentView: View {
////    var body: some View {
////        NavigationView {
////            MainVCRepresentable()
////                .edgesIgnoringSafeArea(.all)
////                .navigationBarHidden(true)
////        }
////    }
////}
////
////struct MainVCRepresentable: UIViewControllerRepresentable {
////    @StateObject var mainVC = MainVC() // MainVC를 @StateObject로 선언하여 유지
////    @State private var selectedTab = 0 // 선택된 탭을 저장하는 State 변수
////
////    func makeUIViewController(context: Context) -> UITabBarController {
////        let tabBarController = UITabBarController()
////
////        let analysisVC = AnalysisVC()
////        let profileVC = ProfileVC()
////
////        mainVC.tabBarItem = UITabBarItem(title: "Main", image: nil, tag: 0)
////        analysisVC.tabBarItem = UITabBarItem(title: "Analysis", image: nil, tag: 1)
////        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
////
////        tabBarController.tabBar.backgroundColor = .systemGray6
////        tabBarController.tabBar.tintColor = .label
////
////        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]
////
////        tabBarController.selectedIndex = selectedTab
////
////        return tabBarController
////    }
////
////    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
////        uiViewController.selectedIndex = selectedTab
////    }
////}
//

import SwiftUI

class MainViewModel: ObservableObject {
    // MainVC의 데이터와 상태를 관리하는 뷰모델
    // 필요한 데이터 및 상태 변수를 여기에 추가해주세요
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainVCRepresentable(viewModel: MainViewModel())
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        }
    }
}

//public struct MainVCRepresentable: UIViewControllerRepresentable {
//    @ObservedObject var viewModel: MainViewModel
//    private var mainVC = MainVC() // MainVC 인스턴스를 유지하기 위한 변수
//    @State private var selectedTab = 0 // 선택된 탭을 저장하는 State 변수
public struct MainVCRepresentable: UIViewControllerRepresentable {
    @ObservedObject var viewModel: MainViewModel
    var mainVC = MainVC() // MainVC 인스턴스를 유지하기 위한 변수
    @State private var selectedTab = 0 // 선택된 탭을 저장하는 State 변수
    
    class CustomTabBar: UITabBar {
            override func sizeThatFits(_ size: CGSize) -> CGSize {
                var sizeThatFits = super.sizeThatFits(size)
                sizeThatFits.height = 100 // 탭 바의 높이 조절
                return sizeThatFits
            }
        }

    public func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()

        let mainVC = MainVC()
        let analysisVC = AnalysisVC()
        let profileVC = ProfileVC()
        
        let mainTag = 0
        let analysisTag = 1
        let profileTag = 2
        
        
        mainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: selectedTab == 1 ? "mainicon" : "mainlogo")?.withRenderingMode(.alwaysOriginal), tag: mainTag)
        analysisVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: selectedTab == 1 ? "analysisicon" : "analysislogo")?.withRenderingMode(.alwaysOriginal), tag: analysisTag)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: selectedTab == 1 ? "profileicon" : "profilelogo")?.withRenderingMode(.alwaysOriginal), tag: profileTag)
        

        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .label

        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]

        tabBarController.selectedIndex = selectedTab

        let customTabBar = CustomTabBar()
        tabBarController.setValue(customTabBar, forKey: "tabBar")
        
        return tabBarController
    }

    public func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        uiViewController.selectedIndex = selectedTab
    }
}

        
 
