//
//  App.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/06.
//

import SwiftUI

@main
struct PrefectureFortuneApp: App {
    var body: some Scene {
        WindowGroup {
            FortuneView(viewModel: FortuneViewModel(fortuneTeller: FortuneAPIClient.shared))
        }
    }
}
