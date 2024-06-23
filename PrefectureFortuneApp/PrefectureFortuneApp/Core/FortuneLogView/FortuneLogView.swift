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
                        label: { Text(prefecture.info.name).bold() }
                    )
                }
            }
            .navigationTitle("Fortune History")
            .alert(
                self.viewModel.currentAlertEntity.title,
                isPresented: self.$viewModel.isShowingAlert,
                presenting: self.viewModel.currentAlertEntity
            ) { entity in
                Button(entity.actionText) {
                    self.viewModel.isShowingAlert = false
                }
            } message: { entity in
                Text(entity.message)
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

#Preview {
    FortuneLogView(viewModel: FortuneLogViewModel())
}
