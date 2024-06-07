//
//  FortuneResultView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import SwiftUI

struct FortuneResultView: View {
    @ObservedObject var viewModel: FortuneViewModel

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
        }
        .onAppear {
            self.viewModel.onFortuneResultViewAppear()
        }
    }
}

#Preview {
    FortuneResultView(viewModel: FortuneViewModel())
}
