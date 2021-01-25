//
//  MarvelDataManager.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 23/1/21.
//

import UIKit

class MarvelDataManager {
    let marvelAPI: MarvelAPI
    
    init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }
}

extension MarvelDataManager: CharactersDataManager {

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        marvelAPI.fetchCharacters(completion: completion)
    }
    
    func fetchThumbnail(for character: Character, completion: @escaping (Result<UIImage, Error>) -> ()) {
        marvelAPI.fetchImage(for: character, completion: completion)
    }
}

extension MarvelDataManager: CharacterDetailDataManager {
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, Error>) -> ()) {
        marvelAPI.fetchCharacter(characterId: characterId, completion: completion)
    }
    
    func fetchCharacterImage(for character: Character, completion: @escaping (Result<UIImage, Error>) -> ()) {
        marvelAPI.fetchImage(for: character, completion: completion)
    }
}

