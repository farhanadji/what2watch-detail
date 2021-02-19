//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Foundation
import Core
import RealmSwift
import Combine

public struct DetailFavoriteLocaleDataSource: LocaleDataSource {
    public typealias Request = Int
    public typealias Response = MovieEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list() -> AnyPublisher<[MovieEntity], Error> {
        fatalError()
    }
    
    public func add(entities: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entities)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func find(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let _ = _realm.object(ofType: MovieEntity.self, forPrimaryKey: id) {
                completion(.success(true))
            }
            completion(.success(false))
        }
        .eraseToAnyPublisher()
    }
    
    public func update(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.delete(_realm.objects(MovieEntity.self).filter("id=%@", id))
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
