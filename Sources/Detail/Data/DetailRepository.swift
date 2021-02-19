//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core
import Combine

public struct DetailRepository<RemoteDataSource: DataSource, Transformer: Mapper> : Repository
where
    RemoteDataSource.Request == Endpoints.Gets,
    RemoteDataSource.Response == MovieDetailResponse,
    Transformer.Domain == MovieDetail,
    Transformer.Entity == MovieEntity,
    Transformer.Response == MovieDetailResponse,
    Transformer.Request == Bool {
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(remoteDataSource: RemoteDataSource, mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public typealias Request = String
    
    public typealias Response = MovieDetail
    
    public func execute(request: String?) -> AnyPublisher<MovieDetail, Error> {
        return _remoteDataSource.execute(request: .detail(movieId: request ?? ""))
            .map {
                _mapper.transformResponsesToDomains(response: $0)
            }
            .eraseToAnyPublisher()
    }
}
