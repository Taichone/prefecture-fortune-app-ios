//
//  FortuneLogView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct FortuneLogView: View {
    @State var viewModel: FortuneLogViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.prefectures, id: \.id) { prefecture in
                    NavigationLink(
                        destination: PrefectureView(prefecture: prefecture),
                        label: { Text(prefecture.name).bold() }
                    )
                }
            }
            .navigationTitle("Fortune History")
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

#Preview {
    FortuneLogView(viewModel: FortuneLogViewModel())
}
