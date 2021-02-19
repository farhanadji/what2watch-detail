//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Core
import Combine

public struct DetailFavoriteRepository<MovieLocalDataSource: LocaleDataSource, Transformer: Mapper> : Repository where
    MovieLocalDataSource.Request == Int,
    MovieLocalDataSource.Response == MovieEntity,
    Transformer.Domain == MovieDetail,
    Transformer.Entity == MovieEntity,
    Transformer.Response == MovieDetailResponse,
    Transformer.Request == Bool {
    
    public typealias Request = DetailFavoriteAction
    public typealias Response = Bool
    public typealias Payload = String
    
    private let _localeDataSource: MovieLocalDataSource
    private let _mapper: Transformer
    
    public init(localDataSource: MovieLocalDataSource, mapper: Transformer) {
        _localeDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: DetailFavoriteAction?) -> AnyPublisher<Bool, Error> {
        switch request {
        case .add(let movie):
            let transformed = _mapper.transformDomainToEntity(domain: movie)
            return _localeDataSource.add(entities: transformed)
                .eraseToAnyPublisher()
        case .remove(let id):
            return _localeDataSource.update(id: id)
                .eraseToAnyPublisher()
        case .find(let id):
            return _localeDataSource.find(id: id)
                .eraseToAnyPublisher()
        case .none:
            fatalError()
        }
    }
}


public enum DetailFavoriteAction {
    case add(movie: MovieDetail)
    case remove(id: Int)
    case find(id: Int)
}
