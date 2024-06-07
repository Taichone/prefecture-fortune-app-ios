//
//  FortuneView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import SwiftUI

struct FortuneView: View {
    @StateObject var viewModel: FortuneViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Your Information") {
                    TextField("Enter your name", text: self.$viewModel.name)
                    DatePicker("Birthday", selection: self.$viewModel.birthday,
                               displayedComponents: .date)
                    Picker("Blood Type", selection: self.$viewModel.bloodType) {
                        ForEach(User.BloodType.allCases, id: \.self) { (type) in
                            Text(type.displayName).tag(type)
                        }
                    }
                }

                if !self.viewModel.name.isEmpty {
                    NavigationLink(
                        destination: FortuneResultView(viewModel: self.viewModel),
                        label: {
                            Text("Check Fortune!")
                                .bold()
                                .foregroundStyle(.blue)
                        }
                    )
                } else {
                    Text("Check Fortune!")
                        .bold()
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    FortuneView(viewModel: FortuneViewModel(fortuneTeller: FortuneAPIClient.shared))
}
