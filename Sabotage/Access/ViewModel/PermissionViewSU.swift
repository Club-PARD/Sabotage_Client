//
//  PermissionView.swift
//  Sabotage
//
//  Created by 김하람 on 12/28/23.
//

import SwiftUI

struct PermissionView: View {
    @StateObject private var vm = PermissionVM()
    
    var body: some View {
        VStack(alignment: .center) {
            navigationHeaderLikeView()
            permissionButtonView()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .sheet(isPresented: $vm.isSheetActive) {
            sheetView()
        }
        .onAppear {
            vm.handleTranslationView()
        }
    }
}

// MARK: - Views
extension PermissionView {
    private func navigationHeaderLikeView() -> some View {
        HStack {
            Button {
                vm.showIsSheetActive()
            } label: {
                Image(systemName: vm.HEADER_ICON_LABEL)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary)
            }
            .frame(width: 40, height: 40)
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 42, alignment: .trailing)
        .opacity(vm.isViewLoaded ? 1 : 0)
    }
    
    private func permissionButtonView() -> some View {
        HStack {
            Button {
                vm.handleRequestAuthorization()
            } label: {
                Text(vm.PERMISSION_BUTTON_LABEL)
            }
            .buttonStyle(.borderless)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: 128)
        .opacity(vm.isViewLoaded ? 1 : 0)
    }
    
    private func sheetView() -> some View {
        VStack {
            Text(vm.SHEET_INFO_LIST[0])
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
                .font(.title2)
            Text(vm.SHEET_INFO_LIST[1])
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom, 24)
                .font(.body)
            Text(.init(vm.GIT_LINK_LABEL))
                .font(.title3)
        }
        .padding(24)
    }
}
