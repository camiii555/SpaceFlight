//
//  ArticleView.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import SwiftUI


struct ArticleView: View {
    
    let article: Article

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let imageWidth = geometry.size.width - 40
            let imageHeight = isLandscape ? geometry.size.height * 0.65 : imageWidth * 9 / 16

            VStack(spacing: 10) {
                AsyncImage(url: URL(string: article.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageWidth, height: imageHeight)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    Color.gray
                        .frame(width: imageWidth, height: imageHeight)
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text(article.publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
        }
        .frame(height: 400)
    }
}

#Preview {
    ArticleView(article: .init(id: 1, title: "Nasa", authors: [], url: "", imageURL: "https://www.hancockhealth.org/wp-content/uploads/2023/02/NASAlandscape-e1676046879582.jpg", newsSite: "", summary: "", publishedAt: "\(Date())", updatedAt: "", featured: false, launches: [], events: []))
}
