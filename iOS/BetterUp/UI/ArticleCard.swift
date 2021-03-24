//
//  ArticleCard.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI

struct ArticleCard: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading,
               spacing: 15) {
            HStack {
                VStack(alignment: .leading,
                       spacing: 10) {
                    Text(article.title)
                        .font(Font.headline.weight(.bold))
                        .fixedSize(horizontal: false,
                                   vertical: true)

                    Text(article.description)
                        .font(.body)
                        .frame(minHeight: 45)
                        .foregroundColor(Color.gray.opacity(0.75))
                }
            }
            .padding(.top, 15)

            AsyncImage(
                url: article.heroImage,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            )
            .cornerRadius(15)

            ZStack {
                HStack() {
                    Text(article.source)
                        .font(.callout)

                    Spacer()

                    Image(systemName: article.favorite ? "heart.fill" : "heart")
                        .foregroundColor(Color.red)
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.surfaceColor.opacity(0.4),
                        radius: 1,
                        x: 0,
                        y: 1)
        )
    }
}
