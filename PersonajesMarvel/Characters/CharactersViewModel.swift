//
//  CharactersViewModel.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 16/1/21.
//

import Foundation

protocol CharactersViewModelCoordinatorDelegate: class {
    func didSelect(character: Character)
}

protocol CharactersViewModelViewDelegate: class {
    func charactersFetched()
    func errorFetchingCharacters()
}

class CharactersViewModel {

    weak var coordinatorDelegate: CharactersViewModelCoordinatorDelegate?
    weak var viewDelegate: CharactersViewModelViewDelegate?
    let charactersDataManager: CharactersDataManager
    var charactersViewModel = [CharacterCellViewModel]()
    
    init(charactersDataManager: CharactersDataManager) {
        self.charactersDataManager = charactersDataManager
    }
    
    func viewDidLoad() {
        fetchCharactersAndReloadUI()
    }
    
    func fetchCharactersAndReloadUI() {
        charactersDataManager.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                if let cellDataManager = self?.charactersDataManager {
                    //                self?.charactersViewModel = characters.map({ CharacterCellViewModel(character: $0) })
                    self?.charactersViewModel = characters.map({ CharacterCellViewModel(character: $0, cellDataManager: cellDataManager) })
                    self?.viewDelegate?.charactersFetched()
                }
            case .failure:
                self?.viewDelegate?.errorFetchingCharacters()
            }
        }
    }
    

    func numberOfRows(in section: Int) -> Int {
        return charactersViewModel.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CharacterCellViewModel? {
        return charactersViewModel[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinatorDelegate?.didSelect(character: charactersViewModel[indexPath.row].character)
    }
}







