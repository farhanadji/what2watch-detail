//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct DetailRemoteDataSource: DataSource {
    public typealias Request = Endpoints.Gets
    public typealias Response = MovieDetailResponse
    
    public init() {}
    
    public func execute(request: Endpoints.Gets?) -> AnyPublisher<MovieDetailResponse, Error> {
        return Future<MovieDetailResponse, Error> { completion in
            if let url = URL(string: request?.url ?? "") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
}
