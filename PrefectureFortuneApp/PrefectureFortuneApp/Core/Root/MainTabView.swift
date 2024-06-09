//
//  MainTabView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: self.$selectedIndex) {
            FortuneView(viewModel: FortuneViewModel(fortuneTeller: FortuneAPIClient.shared))
                .onAppear {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                }.tag(0)

            FortuneLogView()
                .onAppear {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                }.tag(1)
        }
    }
}

#Preview {
    MainTabView()
}
