//
//  BaseAPI.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation
import Alamofire

enum BaseAPI: URLRequestConvertible {
    case getAllArticles(limit: Int)
    case getDetailArticle(id: Int)
    
    var path: String {
        switch self {
        case .getAllArticles:
            return "articles/"
        case .getDetailArticle(let id):
            return "articles/\(id)/"
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .getAllArticles, .getDetailArticle:
            return  ["accept": "*/*",
                     "Content-Type": "application/json"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllArticles, .getDetailArticle:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAllArticles(let limit):
            return ["limit": limit]
        case .getDetailArticle:
            return [:]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getAllArticles:
            return URLEncoding.queryString
        case .getDetailArticle:
            return URLEncoding.queryString
        }
    }
    
    var absolutePath: String {
        switch self {
        case .getAllArticles, .getDetailArticle:
            return Constans.Request.baseURLString + "v4/" + path
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try absolutePath.asURL()
        var urlRequest = try URLRequest(url: url, method: method, headers: header)
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
}
