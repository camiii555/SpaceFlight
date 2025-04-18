//
//  ArticlesViewModel.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var articles: [Article] = []
    @Published var article: Article?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Private Properties
    private let articleRepository: ArticlesProtocol
    private var cancellables =  Set<AnyCancellable>()
    
    init(articleRepository: ArticlesProtocol = ArticlesRepository()) {
        self.articleRepository = articleRepository
    }
    
    
    // MARK: - Methods
    func fetchArticles() {
        isLoading = true
        errorMessage = nil
        
        articleRepository.fetchArticles(itemLimit: 50)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.articles = response.results
            }
            .store(in: &cancellables)
    }
    
    func getArticleDetail(articleId: Int) {
        isLoading = true
        errorMessage = nil
        articleRepository.getArticleDetail(articleId: articleId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                self.article = response
            }
            .store(in: &cancellables)

    }
}
