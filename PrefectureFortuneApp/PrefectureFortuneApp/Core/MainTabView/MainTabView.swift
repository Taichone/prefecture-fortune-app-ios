//
//  MainTabView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: self.$selectedIndex) {
            FortuneView(
                viewModel: FortuneViewModel(
                    modelContext: .init(PrefectureFortuneApp.sharedModelContainer),
                    prefectureInfoProvider: FortuneAPIClient.shared
                )
            )
            .modelContainer(PrefectureFortuneApp.sharedModelContainer)
            .onAppear {
                self.selectedIndex = 0
            }
            .tabItem {
                Image(systemName: "mappin.and.ellipse")
            }.tag(0)

            FortuneLogView(
                viewModel: FortuneLogViewModel(
                    modelContext: .init(PrefectureFortuneApp.sharedModelContainer)
                )
            )
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
