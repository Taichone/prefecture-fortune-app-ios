//
//  PrefectureView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct PrefectureView: View {
    let prefecture: Prefecture

    var body: some View {
        List {
            Text(self.prefecture.name)
            Text("Capital: " + self.prefecture.capital)
            Text(
                self.prefecture.hasCoastLine ?
                "With coastline" : "No coastline"
            )
            if let citizenDayString = self.prefecture.citizenDay?.convertToString() {
                Text("CitizenDay: " + citizenDayString)
            }
            Text(self.prefecture.brief)
            PrefectureImage(imageUrl: self.prefecture.logoUrl)
        }
    }
}

#Preview {
    PrefectureView(prefecture: Prefecture.aichi)
}

