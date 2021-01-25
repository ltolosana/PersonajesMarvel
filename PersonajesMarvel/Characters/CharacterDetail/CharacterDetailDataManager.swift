//
//  CharacterDetailDataManager.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 24/1/21.
//

import UIKit

protocol CharacterDetailDataManager {
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, Error>) -> ())
    func fetchCharacterImage(for character: Character, completion: @escaping (Result<UIImage, Error>) -> ())
}
