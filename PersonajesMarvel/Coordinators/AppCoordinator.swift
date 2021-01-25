//
//  AppCoordinator.swift
//  PersonajesMarvel
//
//  Created by Luis Maria Tolosana Simon on 22/1/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    let marvelAPI = MarvelAPI()
    

    lazy var dataManager: MarvelDataManager = {
        let dataManager = MarvelDataManager(marvelAPI: marvelAPI)
        return dataManager
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        
        let charactersCoordinator = CharactersCoordinator(presenter: navigationController, charactersDataManager: dataManager, characterDetailDataManager: dataManager)
        addChildCoordinator(charactersCoordinator)
        charactersCoordinator.start()
        
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    override func finish() {
    }
}
