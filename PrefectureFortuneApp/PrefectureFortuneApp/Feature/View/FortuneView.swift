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
        List {
            Section("Your Information") {
                TextField("Name", text: self.$viewModel.name)
                DatePicker("Birthday", selection: self.$viewModel.birthday,
                           displayedComponents: .date)
                Picker("Blood Type", selection: self.$viewModel.bloodType) {
                    ForEach(User.BloodType.allCases, id: \.self) { (type) in
                        Text(type.displayName).tag(type)
                    }
                }
            }

            // TODO: NavigationLink か Button にする
            Text("Check Fortune!")
                .bold()
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    FortuneView(viewModel: FortuneViewModel())
}
