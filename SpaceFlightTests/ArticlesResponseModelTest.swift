//
//  ArticlesResponseModelTest.swift
//  SpaceFlightTests
//
//  Created by Juan Camilo  Mejia Soto on 23/04/25.
//

import XCTest
@testable import SpaceFlight

final class ArticlesResponseModelTest: XCTestCase {

    func testArticlesResponseModelInitialization() {
        let socials = Socials(
            x: "https://x.com/example",
            youtube: "https://youtube.com/example",
            instagram: "https://instagram.com/example",
            linkedin: "https://linkedin.com/in/example",
            mastodon: nil,
            bluesky: nil
        )
        
        let author = Author(name: "Juan Camilo", socials: socials)
        
        let article = Article(
            id: 1,
            title: "Test Article",
            authors: [author],
            url: "https://example.com/article",
            imageURL: "https://example.com/image.jpg",
            newsSite: "Example News",
            summary: "This is a test article summary.",
            publishedAt: "2025-04-18T12:00:00Z",
            updatedAt: "2025-04-18T14:00:00Z",
            featured: true,
            launches: [],
            events: []
        )
        
        let model = ArticlesResponseModel(
            count: 1,
            next: "https://example.com/page/2",
            previous: nil,
            results: [article]
        )
        
        XCTAssertEqual(model.count, 1)
        XCTAssertEqual(model.next, "https://example.com/page/2")
        XCTAssertNil(model.previous)
        XCTAssertEqual(model.results.count, 1)
        XCTAssertEqual(model.results.first?.title, "Test Article")
        XCTAssertEqual(model.results.first?.authors.first?.name, "Juan Camilo")
        XCTAssertEqual(model.results.first?.authors.first?.socials?.x, "https://x.com/example")
    }
}
