//
//  CharactersCoordinator.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 22/1/21.
//

import UIKit

class CharactersCoordinator: Coordinator {
    let presenter: UINavigationController
    let charactersDataManager: CharactersDataManager
    let characterDetailDataManager: CharacterDetailDataManager
    var charactersViewModel: CharactersViewModel?
    
    init(presenter: UINavigationController, charactersDataManager: CharactersDataManager, characterDetailDataManager: CharacterDetailDataManager) {
        self.presenter = presenter
        self.charactersDataManager = charactersDataManager
        self.characterDetailDataManager = characterDetailDataManager
    }
    
    override func start() {
        let charactersViewModel = CharactersViewModel(charactersDataManager: charactersDataManager)
        let charactersViewController = CharactersViewController(viewModel: charactersViewModel)
        charactersViewModel.viewDelegate = charactersViewController
        charactersViewModel.coordinatorDelegate = self
        self.charactersViewModel = charactersViewModel
        presenter.pushViewController(charactersViewController, animated: false)
    }
    
    override func finish() {
    }
}
    
extension CharactersCoordinator: CharactersViewModelCoordinatorDelegate {
    
        func didSelect(character: Character) {
            guard let characterId = character.id else { return }
            let characterDetailViewModel = CharacterDetailViewModel(characterId: characterId, characterDetailDataManager: characterDetailDataManager)
            let characterDetailViewController = CharacterDetailViewController(viewModel: characterDetailViewModel)
            characterDetailViewModel.viewDelegate = characterDetailViewController
            if let name = character.name {
                characterDetailViewController.title = NSLocalizedString(name, comment: "")
                characterDetailViewController.accessibilityLabel = NSLocalizedString(name, comment: "")
            }
            presenter.pushViewController(characterDetailViewController, animated: true)
        }
}
