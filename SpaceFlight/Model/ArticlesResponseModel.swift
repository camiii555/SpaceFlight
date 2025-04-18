//
//  ArticlesResponseModel.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation

struct ArticlesResponseModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Article]
    
    init(count: Int, next: String?, previous: String?, results: [Article]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

struct Article: Codable, Identifiable {
    let id: Int
    let title: String
    let authors: [Author]
    let url: String
    let imageURL: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String
    let featured: Bool
    let launches: [Launch]
    let events: [Event]

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured, launches, events
    }
    
    init(id: Int, title: String, authors: [Author], url: String, imageURL: String, newsSite: String, summary: String, publishedAt: String, updatedAt: String, featured: Bool, launches: [Launch], events: [Event]) {
        self.id = id
        self.title = title
        self.authors = authors
        self.url = url
        self.imageURL = imageURL
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
        self.featured = featured
        self.launches = launches
        self.events = events
    }
}

struct Author: Codable {
    let name: String
    let socials: Socials?
    
    init(name: String, socials: Socials?) {
        self.name = name
        self.socials = socials
    }
}

struct Socials: Codable {
    let x: String?
    let youtube: String?
    let instagram: String?
    let linkedin: String?
    let mastodon: String?
    let bluesky: String?
    
    init(x: String?, youtube: String?, instagram: String?, linkedin: String?, mastodon: String?, bluesky: String?) {
        self.x = x
        self.youtube = youtube
        self.instagram = instagram
        self.linkedin = linkedin
        self.mastodon = mastodon
        self.bluesky = bluesky
    }
}

struct Launch: Codable {} 
struct Event: Codable {}

