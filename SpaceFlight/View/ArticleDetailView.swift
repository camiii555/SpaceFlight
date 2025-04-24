//
//  ArticleDetailView.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//


import SwiftUI
import Foundation

struct ArticleDetailView: View {
    
    @StateObject private var articleViewModel = ArticlesViewModel()
    
    @State private var mostrarAlerta = false
    @State private var mensajeDeError = ""
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    let articleId: Int
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center) {
                    if articleViewModel.isLoading {
                        VStack {
                            Spacer()
                            ProgressView("Loading...")
                                .padding()
                            Spacer()
                        }
                        .frame(minHeight: geometry.size.height)
                    } else {
                        AsyncImage(url: URL(string: articleViewModel.article?.imageURL ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width - 20, height: 400, alignment: .center)
                                .cornerRadius(10)
                        } placeholder: {
                            Color.black
                                .frame(width: screenWidth - 10, height: 500)
                                .cornerRadius(10)
                        }
                        
                        Text(articleViewModel.article?.title ?? "")
                            .font(.title)
                            .padding(.all, 20)
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        Text(articleViewModel.article?.summary ?? "")
                            .font(.title3)
                            .padding(.all, 20)
                        
                        Text("Author: \(articleViewModel.article?.authors.first?.name ?? "")")
                            .font(.caption)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        Text("Published at: \(articleViewModel.article?.publishedAt ?? "" )")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.caption)
                            .padding(.horizontal, 20)
                        
                        Text("Updated at: \(articleViewModel.article?.updatedAt ?? "" )")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.caption)
                            .padding(.horizontal, 20)
                        
                        Button {
                            guard let url = articleViewModel.article?.url else { return }
                            UIApplication.shared.open(URL(string: url)!)
                        } label: {
                            Label("Go to the website", systemImage: "network")
                                .labelStyle(.titleAndIcon)
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        .padding(.vertical, 30)
                    }
                }
                .frame(maxWidth: .infinity)
                .onAppear {
                    articleViewModel.getArticleDetail(articleId: articleId)
                }
                .onChange(of: articleViewModel.errorMessage) { newValue in
                    if let error = newValue {
                        mensajeDeError = error
                        mostrarAlerta = true
                    }
                }
                .alert("Error", isPresented: $mostrarAlerta) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(mensajeDeError)
                }
            }
        }
    }
}

#Preview {
    ArticleDetailView(articleId: 307300)
}


