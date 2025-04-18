//
//  NetworkManager.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import Foundation
import Alamofire
import Combine


final class NetworkManager  {
    
    private let session: Session
    static let shared = NetworkManager()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.session = Session(configuration: configuration)
    }
    
    
    func request<T: Codable>(
        _ api: URLRequestConvertible,
        responseType: T.Type
    ) -> AnyPublisher<T, Error> {

        print("-- Creating url request --")
        print("➡️REQUEST URL -> \(String(describing: api.urlRequest?.url?.absoluteString))")
        print("Method: \(String(describing: api.urlRequest?.httpMethod))")
        print("Headers: \(String(describing: api.urlRequest?.headers))")
        print("Body: \(String(decoding: api.urlRequest?.httpBody ?? Data(), as: UTF8.self))")

        let request = session.request(api)

        return Future<T, Error> { promise in
            request
                .validate()
                .responseData { response in
                    // Logueo el cuerpo del response
                    if let data = response.data {
                        print("📦 DATA RECEIVED: \(String(data: data, encoding: .utf8) ?? "No data")")
                    } else {
                        print("❌ No data received")
                    }
                }
                .responseDecodable(of: responseType) { response in
                    request.cURLDescription { curl in
                        print("➡️Curl -> \(curl)")
                    }

                    switch response.result {
                    case .success(let data):
                        print("✅Success -> \(data)")
                        promise(.success(data))
                    case .failure(let error):
                        let nsError = NSError(
                            domain: error.localizedDescription,
                            code: request.response?.statusCode ?? 0,
                            userInfo: ["message": "An error has occurred"]
                        )
                        print("❌ \(nsError)")
                        promise(.failure(nsError))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
