//
//  BaseRepository.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation
import Alamofire
import Combine

class BaseRepository {

    static func callService<T: Codable>(_ api: URLRequestConvertible, responseType: T.Type) -> AnyPublisher<T, Error> {
        return NetworkManager.shared.request(api, responseType: responseType)
    }
}
