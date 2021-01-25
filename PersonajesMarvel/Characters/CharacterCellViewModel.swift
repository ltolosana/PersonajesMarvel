//
//  CharacterCellViewModel.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 16/1/21.
//

import UIKit

protocol CharacterCellViewModelViewDelegate: class {
    func characterImageFetched()
}

class CharacterCellViewModel {
    weak var viewDelegate: CharacterCellViewModelViewDelegate?
    let cellDataManager: CharactersDataManager
    let character: Character
    var characterName: String?
    var characterImage: UIImage?
    
    init(character: Character, cellDataManager: CharactersDataManager) {

        self.character = character
        characterName = character.name
        self.cellDataManager = cellDataManager

        cellDataManager.fetchThumbnail (for: character) { [weak self] result in
            switch result {
            case .success(let thumbnail):
                self?.characterImage = thumbnail
                self?.viewDelegate?.characterImageFetched()

            case .failure(_):
                self?.characterImage = UIImage(systemName: "person")
                self?.viewDelegate?.characterImageFetched()
            }
        }
    }
}
