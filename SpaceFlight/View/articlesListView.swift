//
//  ContentView.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import SwiftUI

struct articlesListView: View {
    
    @StateObject private var articleViewModel = ArticlesViewModel()
    @State private var searcher: String = ""
    
    @State private var mostrarAlerta = false
    @State private var mensajeDeError = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                if articleViewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(articleViewModel.articles.filter {
                        searcher.isEmpty ? true : $0.title.lowercased().contains(searcher.lowercased())
                    }) { article in
                        ArticleView(article: article)
                            .background(
                                NavigationLink("", destination: ArticleDetailView(articleId: article.id))
                                    .opacity(0)
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .searchable(text: $searcher)
                }
            }
            .onAppear {
                articleViewModel.fetchArticles()
            }
            .onChange(of: articleViewModel.errorMessage) { newValue in
                if let error = newValue {
                    mensajeDeError = error
                    mostrarAlerta = true
                }
            }
            .navigationTitle("Articles")
            .alert("Error", isPresented: $mostrarAlerta) {
                Button("OK", role: .cancel) {
                    articleViewModel.fetchArticles()
                }
            } message: {
                Text(mensajeDeError)
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    articlesListView()
}

