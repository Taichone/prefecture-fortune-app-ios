//
//  FortuneResultView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import SwiftUI

struct FortuneResultView: View {
    @ObservedObject var viewModel: FortuneViewModel
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
                // TODO: 結果に応じて都道府県情報を表示
                Text("FortuneResultView")
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

#Preview {
    FortuneResultView(viewModel: FortuneViewModel(fortuneTeller: FortuneAPIClient.shared))
}
