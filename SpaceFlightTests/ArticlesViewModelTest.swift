//
//  ArticlesViewModelTest.swift
//  SpaceFlightTests
//
//  Created by Juan Camilo  Mejia Soto on 23/04/25.
//

import XCTest
import Combine
@testable import SpaceFlight

final class ArticlesViewModelTests: XCTestCase {
    
    var viewModel: ArticlesViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticlesViewModel(articleRepository: ArticlesRepositoryMock())
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchArticlesPopulatesArticles() {
        let expectation = XCTestExpectation(description: "Fetch articles and update view model")
        
        viewModel.$articles
            .dropFirst()
            .sink { articles in
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.title, "Mock Article")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchArticles()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetArticleDetailPopulatesArticle() {
        let expectation = XCTestExpectation(description: "Fetch article detail and update view model")
        
        viewModel.$article
            .dropFirst()
            .sink { article in
                XCTAssertNotNil(article)
                XCTAssertEqual(article?.id, 1)
                XCTAssertEqual(article?.title, "Mock Article")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getArticleDetail(articleId: 1)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetArticleDetailWithInvalidIdSetsError() {
        let expectation = XCTestExpectation(description: "Handle error for invalid article ID")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let error = errorMessage {
                    XCTAssertFalse(error.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.getArticleDetail(articleId: 999)
        
        wait(for: [expectation], timeout: 2.0)
    }

}

