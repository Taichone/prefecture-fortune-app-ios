//
//  PrefectureImage.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct PrefectureImage: View {
    let imageUrl: String

    var body: some View {
        VStack {
            if let url = URL(string: self.imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Self.EmptyImage()
                    @unknown default:
                        Self.EmptyImage()
                    }
                }
            } else {
                Self.EmptyImage()
            }
        }
    }
}

extension PrefectureImage {
    struct EmptyImage: View {
        var body: some View {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    PrefectureImage(imageUrl: Prefecture.aichi.logoUrl)
}
