//
//  FortuneResultView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import SwiftUI

struct FortuneResultView: View {
    @State var viewModel: FortuneResultViewModel
    @State private var showDismissAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            if self.viewModel.fortuneResultViewIsLoading {
                HStack {
                    Text("Loading...")
                        .padding()
                    ProgressView()
                }
            } else {
                PrefectureView(prefecture: self.viewModel.resultPrefecture)
            }
#if DEBUG
            Button("Send backNavigationTrigger") {
                self.viewModel.backNavigationTrigger.send()
            }
#endif
        }
        .onAppear {
            self.viewModel.onFortuneResultViewAppear()
        }
        .onReceive(self.viewModel.backNavigationTrigger) { _ in
            self.showDismissAlert = true
        }
        .alert(isPresented: self.$showDismissAlert) {
            Alert(
                title: Text("Error"),
                message: Text("An error has occurred. Please try again."),
                dismissButton: .default(Text("OK")) {
                    self.dismiss.callAsFunction() // FortuneView に戻る
                }
            )
        }
    }
}

fileprivate struct FortuneResultViewPreviewWrapper: View {
    private class MockFortuneAPIClient: PrefectureFortuneTeller {
        func fetchFortuneResultPrefecture(from: User) async throws -> Prefecture {
            return Prefecture.aichi
        }
    }

    @State private var viewModel = FortuneResultViewModel(
        user: User(name: "name", birthday: YearMonthDay.today(), bloodType: .a),
        modelContext: .init(PrefectureFortuneApp.sharedModelContainer),
        fortuneTeller: MockFortuneAPIClient()
    )

    var body: some View {
        FortuneResultView(viewModel: self.viewModel)
    }
}

#Preview {
    FortuneResultViewPreviewWrapper()
}
