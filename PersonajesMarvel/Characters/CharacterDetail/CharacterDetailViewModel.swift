//
//  CharacterDetailViewModel.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 24/1/21.
//

import UIKit

protocol CharacterDetailViewModelViewDelegate:class {
    func characterDetailFetched()
    func errorFetchingCharacterDetail()
}

class CharacterDetailViewModel {
    
    var characterName: String?
    var characterImage: UIImage?
    var characterDescription: String?
    var characterComics: String?
    var characterStories: String?
    var characterEvents: String?
    var characterSeries: String?

    weak var viewDelegate : CharacterDetailViewModelViewDelegate?
    let characterId: Int
    let characterDetailDataManager: CharacterDetailDataManager

    init(characterId: Int, characterDetailDataManager: CharacterDetailDataManager) {
        self.characterId = characterId
        self.characterDetailDataManager = characterDetailDataManager
    }
    
    func viewDidLoad() {
        fetchCharacterAndReloadUI()
    }
    
    func fetchCharacterAndReloadUI() {
        characterDetailDataManager.fetchCharacter(characterId: characterId) { [weak self] (result) in
            switch result {
            case .success(let character):
                self?.characterName = character.name
                self?.characterDescription = character.description
                self?.characterComics = character.comics?.items?.compactMap({ $0.name }).joined(separator: ", ")
                self?.characterStories = character.stories?.items?.compactMap({ $0.name }).joined(separator: ", ")
                self?.characterEvents = character.events?.items?.compactMap({ $0.name }).joined(separator: ", ")
                self?.characterSeries = character.series?.items?.compactMap({ $0.name }).joined(separator: ", ")
                self?.characterDetailDataManager.fetchCharacterImage (for: character) { [weak self] result in
                    switch result {
                    case .success(let thumbnail):
                        self?.characterImage = thumbnail
                        self?.viewDelegate?.characterDetailFetched()

                    case .failure(_):
                        self?.characterImage = UIImage(systemName: "person")
                        self?.viewDelegate?.characterDetailFetched()
                    }
                }
                                
            case .failure:
                self?.viewDelegate?.errorFetchingCharacterDetail()
            }
        }
    }
}
