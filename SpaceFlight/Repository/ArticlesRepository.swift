//
//  getAllArticlesRepository.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation
import Combine

protocol ArticlesProtocol {
    func fetchArticles(itemLimit: Int) -> AnyPublisher<ArticlesResponseModel, Error>
    func getArticleDetail(articleId: Int) -> AnyPublisher<Article, Error>
}

class ArticlesRepository: ArticlesProtocol {
    
    func fetchArticles(itemLimit: Int) -> AnyPublisher<ArticlesResponseModel, Error> {
        let api = BaseAPI.getAllArticles(limit: itemLimit)
        return BaseRepository.callService(api, responseType: ArticlesResponseModel.self)
    }
    
    func getArticleDetail(articleId: Int) -> AnyPublisher<Article, Error> {
        let api = BaseAPI.getDetailArticle(id: articleId)
        return BaseRepository.callService(api, responseType: Article.self)
    }
}
