//
//  APIClient.swift
//  MealMenu
//
//  Created by Luis Ignacio Vinas Petriz on 14/09/23.
//

import Foundation
import Combine

open class APIClient {
  private let urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default,
                                                  delegate: nil,
                                                  delegateQueue: nil)
  public var statusCode: Int?
  private var basePath: String {
    return "https://www.themealdb.com/api/json/v1/1"
  }

  // MARK: - Closure API Client Functions
  open func perform<T, APIServiceError>(
    service: ServiceParameters,
    completion: @escaping (APIServiceResult<T, APIServiceError>) -> Void) {
      let urlRequest: URLRequest = generateURLRequest(service: service)
      let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
        if let error: Error = error {
          DispatchQueue.main.async {
            completion(.failure(.generic(error)))
          }
        } else if let data: Data = data {
          if let object: T = try? JSONDecoder().decode(T.self, from: data) {
            DispatchQueue.main.async {
              completion(.success(object))
            }
          } else {
            DispatchQueue.main.async {
              completion(.failure(.parserError))
            }
          }
        } else {
          DispatchQueue.main.async {
            completion(.failure(.unknown))
          }
        }
      }
      task.resume()
    }

  open func directDownload(
    downloadPath: String,
    completion: @escaping (Data?) -> Void)
  {
    let serviceURL: URL = URL(string: downloadPath) ?? URL(fileURLWithPath: "")
    let urlRequest = URLRequest(url: serviceURL,
                                cachePolicy: .reloadIgnoringLocalCacheData,
                                timeoutInterval: 60.0)
    let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
      DispatchQueue.main.async {
        completion(data)
      }
    }
    task.resume()
  }

  // MARK: - Combine API Client Functions
  public func perform<T: Decodable>(service: ServiceParameters) -> AnyPublisher<Response<T>, APIServiceError> {
    let urlRequest: URLRequest = generateURLRequest(service: service)
    
    let cancellable: AnyPublisher<Response<T>, APIServiceError>
    cancellable = urlSession.dataTaskPublisher(for: urlRequest).tryMap({ (data: Data, response: URLResponse) in
      let value = try JSONDecoder().decode(T.self, from: data)
      return Response(value: value, response: response)
    }).mapError({ error in
      return .unknown
    })
    .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    
    return cancellable
  }

  public func directDownload(downloadPath: String) -> AnyPublisher<Data, APIServiceError> {
    let serviceURL: URL = URL(string: downloadPath) ?? URL(fileURLWithPath: "")
    let urlRequest = URLRequest(url: serviceURL,
                                cachePolicy: .reloadIgnoringLocalCacheData,
                                timeoutInterval: 60.0)
    let cancellable: AnyPublisher<Data, APIServiceError>
    cancellable = urlSession.dataTaskPublisher(for: urlRequest).tryMap({ (data: Data, response: URLResponse) in
      return data
    }).mapError({ error in
      return .unknown
    })
    .receive(on: DispatchQueue.main).eraseToAnyPublisher()

    return cancellable
  }

  public func generateURLRequest(service: ServiceParameters) -> URLRequest {
    var serviceURL: URL = URL(string: service.servicePath) ?? URL(fileURLWithPath: "")
    if let queryParameters: [URLQueryItem] = service.queryParameters {
      serviceURL = serviceURL.appending(queryParameters) ?? URL(fileURLWithPath: "")
    }
    var urlRequest = URLRequest(url: serviceURL,
                                cachePolicy: .reloadIgnoringLocalCacheData,
                                timeoutInterval: service.timeoutInterval)
    urlRequest.allHTTPHeaderFields = service.headers
    urlRequest.httpMethod = service.httpMethod.rawValue
    
    return urlRequest
  }

}

public struct Response<T> {
  public let value: T
  public let response: URLResponse
  
  // MARK: - Initializer
  public init(value: T, response: URLResponse) {
    self.value = value
    self.response = response
  }
}
