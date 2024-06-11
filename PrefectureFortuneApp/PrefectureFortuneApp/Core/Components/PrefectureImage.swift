//
//  PrefectureImage.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct PrefectureImage: View {
    let imageUrl: String
    @State private var imagePhase: AsyncImagePhase = .empty

    var body: some View {
        VStack {
            switch self.imagePhase {
            case .empty:
                ProgressView()
                    .onAppear { self.loadImage() }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                EmptyImage()
                    .onAppear { self.loadImage() }
            @unknown default:
                EmptyImage()
                    .onAppear { self.loadImage() }
            }
        }
    }

    private func loadImage() {
        Task {
            guard let url = URL(string: self.imageUrl) else {
                self.imagePhase = .failure(URLError(.badURL))
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    self.imagePhase = .success(Image(uiImage: uiImage))
                } else {
                    self.imagePhase = .failure(URLError(.cannotDecodeContentData))
                }
            } catch {
                self.imagePhase = .failure(error)
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
