//
//  FeedListView.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI
import Combine

struct FeedListView: View {
    let reloadAndFilterByFavorite: CommandWith<Bool>
    let onLinkTapped: CommandWith<URL>
    let articles: [Article]

    @State var isFilteringByFaves: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                ScrollView {
                    Color
                        .clear
                        .padding(.top, 10)

                    LazyVStack(spacing: 10) {
                        ForEach(articles,
                                id: \.self) { row in
                            ArticleCard(article: row)
                                .onTapGesture {
                                    onLinkTapped(row.link)
                                }
                                .frame(height: geo.size.width)
                        }
                    }
                    .padding(.horizontal)
                    .animation(.default)

                    Color
                        .clear
                        .padding(.bottom,
                                 60)
                }

                HStack {
                    Spacer()

                    Button(action: {
                        withAnimation {
                            reloadAndFilterByFavorite(!isFilteringByFaves)
                            isFilteringByFaves = !isFilteringByFaves
                        }

                    }) {
                        Image(systemName: isFilteringByFaves ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .frame(width: 50,
                           height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(color: Color.surfaceColor.opacity(0.4),
                                    radius: 1,
                                    x: 0,
                                    y: 1)
                    )
                }
                .padding(25)
            }
        }
        .background(Color.backgroundColor)
        .padding(.top, 1)
        .onAppear(perform: {
            reloadAndFilterByFavorite(false)
        })
    }
}

struct FeedListViewConnector: Connector {
    @EnvironmentObject var store: AppStore

    func map() -> some View {
        var articles: [Article] = []
        switch store.state.feedFlowState {
        case let .feedFetched(fetchedArticles):
            articles = fetchedArticles
        default: break
        }

        return FeedListView(reloadAndFilterByFavorite: store.bind({ .feedListFlow(action: .reload(filterByFaves: $0)) }),
                            onLinkTapped: store.bind({ .feedListFlow(action: FeedListAction.openLink(url: $0)) }),
                            articles: articles)
    }
}
