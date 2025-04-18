//
//  Mocks.swift
//  SpaceFlightTests
//
//  Created by Juan Camilo  Mejia Soto on 23/04/25.
//

import Foundation
@testable import SpaceFlight
import Combine

var mockArticles: [Article] = [
    Article(
        id: 1,
        title: "Mock Article",
        authors: [
            Author(name: "Test Author", socials: nil)
        ],
        url: "https://example.com/article",
        imageURL: "https://example.com/image.jpg",
        newsSite: "Mock News",
        summary: "This is a mock article used for testing.",
        publishedAt: "2025-04-18T12:00:00Z",
        updatedAt: "2025-04-18T12:00:00Z",
        featured: false,
        launches: [],
        events: []
    )
]


struct ArticlesRepositoryMock: ArticlesProtocol {
    func fetchArticles(itemLimit: Int) -> AnyPublisher<SpaceFlight.ArticlesResponseModel, any Error> {
        let response = ArticlesResponseModel(
            count: mockArticles.count,
            next: nil,
            previous: nil,
            results: mockArticles
        )
        
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getArticleDetail(articleId: Int) -> AnyPublisher<SpaceFlight.Article, any Error> {
        if let article = mockArticles.first(where: { $0.id == articleId }) {
            return Just(article)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
}


