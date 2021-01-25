//
//  CharactersDataManager.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 23/1/21.
//

import UIKit

protocol CharactersDataManager {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> ())
    func fetchThumbnail(for character: Character, completion: @escaping (Result<UIImage, Error>) -> ())
}
