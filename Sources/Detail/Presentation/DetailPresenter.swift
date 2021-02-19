//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Foundation
import Combine
import Core

public class DetailPresenter<DetailUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject where DetailUseCase.Request == String, DetailUseCase.Response == MovieDetail, FavoriteUseCase.Request == DetailFavoriteAction, FavoriteUseCase.Response == Bool {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published public var movieDetail: MovieDetail?
    @Published public var errorMessage: String = ""
    @Published public var state: State = .idle
    @Published public var isFavorite: Bool = false
    
    private let _detailUseCase: DetailUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    
    
    public init(detailUseCase: DetailUseCase, favoriteUseCase: FavoriteUseCase) {
        _detailUseCase = detailUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getDetail(id: String) {
        state = .loading
        _detailUseCase.execute(request: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.state = .loaded
                }
            } receiveValue: { detail in
                self.movieDetail = detail
            }
            .store(in: &cancellables)
        
    }
    
    public func addToFavorite() {
        guard let detail = movieDetail else { return }
        _favoriteUseCase.execute(request: .add(movie: detail))
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("movie added to favorite") //FOR LOG PURPOSES
                }
            } receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            }
            .store(in: &cancellables)
    }
    
    public func removeFromFavorite(id: Int) {
        _favoriteUseCase.execute(request: .remove(id: id))
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("movie removed from favorite") //FOR LOG PURPOSES
                }
            } receiveValue: { isFavorite in
                self.isFavorite = !isFavorite
            }
            .store(in: &cancellables)
    }
    
    public func checkMovieFavorite(id: Int) {
        _favoriteUseCase.execute(request: .find(id: id))
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("finish to check favorite") //FOR LOG PURPOSES
                }
            } receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            }
            .store(in: &cancellables)
    }
}
