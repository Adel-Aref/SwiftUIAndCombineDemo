//
//  APIService.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine


public protocol APIContract {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType, responseModel: T.Type) -> AnyPublisher<T, Error>
}

//extension APIContract {
//    public func request<T: Decodable>(_ endpoint: EndpointType, responseModel: T.Type) -> AnyPublisher<T, Error> {
//        session.dataTaskPublisher(for: endpoint.request)
//            .map(\.data)
//            .decode(type: T.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//}

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}


class URLSessionAPIClient<EndpointType: APIEndpoint>: APIContract {
    private var session: URLSessionProtocol

    // MARK: - Init

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: - Request

    func request<T: Decodable>(_ endpoint: EndpointType, responseModel: T.Type) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed
                }

                guard (200 ... 299).contains(httpResponse.statusCode) else {
                    throw APIError.customError(statusCode: httpResponse.statusCode)
                }

                return data
            }
            .decode(type: responseModel, decoder: JSONDecoder())
            .mapError({ error -> APIError in
                guard let error = error as? APIError else {
                    return APIError.decodingFailed
                }
                return error
            })
            .eraseToAnyPublisher()
    }
}


