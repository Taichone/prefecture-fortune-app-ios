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
                List {
                    Text(self.viewModel.resultPrefecture.name)
                    Text("Capital: " + self.viewModel.resultPrefecture.capital)
                    Text(
                        self.viewModel.resultPrefecture.hasCoastLine ?
                        "With coastline" : "No coastline"
                    )
                    if let citizenDayString = self.viewModel.resultPrefecture.citizenDay?.convertToString() {
                        Text("CitizenDay: " + citizenDayString)
                    }
                    Text(self.viewModel.resultPrefecture.brief)
                    PrefectureImage(imageUrl: self.viewModel.resultPrefecture.logoUrl)
#if DEBUG
                    Button("Send backNavigationTrigger") {
                        self.viewModel.backNavigationTrigger.send()
                    }
#endif
                }
            }
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
            return Prefecture(
                name: "愛知県",
                capital: "名古屋市",
                citizenDay: MonthDay(month: 11, day: 27),
                hasCoastLine: true,
                logoUrl: "https://japan-map.com/wp-content/uploads/aichi.png",
                brief: "日本列島の中央部にあたり、人口約750万人は東京都、神奈川県、大阪府に次いで4番目に多い。県内総生産は東京都、大阪府に次いで3位である[1]。政令指定都市である名古屋市は、中部地方・東海地方（東海3県）最大の人口を擁し、同地方における中心都市となっている。同市を中心とした中京圏（名古屋都市圏）は首都圏（東京都市圏）・近畿圏（大阪都市圏）とともに三大都市圏の一角を占める。1人当たりの県民所得は、東京都に次ぐ全国2位、名目県内総生産(GDP)は、東京都、大阪府に次ぐ全国3位である。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』"
            )
        }
    }

    @StateObject private var viewModel = FortuneViewModel(
        fortuneTeller: MockFortuneAPIClient()
    )

    var body: some View {
        FortuneResultView(viewModel: self.viewModel)
    }
}

#Preview {
    FortuneResultViewPreviewWrapper()
}
