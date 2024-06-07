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
        Text("FortuneResultView")
    }
}

#Preview {
    FortuneResultView(viewModel: FortuneViewModel())
}
