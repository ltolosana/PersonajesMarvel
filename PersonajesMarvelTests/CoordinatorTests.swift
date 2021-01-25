//
//  CoordinatorTests.swift
//  PersonajesMarvelTests
//
//  Created by Luis Maria Tolosana Simon on 25/1/21.
//

import XCTest
@testable import PersonajesMarvel

class CoordinatorTests: XCTestCase {
   
    func testCoordinatorIdentity() {
        let coordinator = Coordinator()
        XCTAssertEqual(coordinator, coordinator)
    }
    
    func testCoordinatorEquality() {
        let coordinator1 = Coordinator()
        let coordinator2 = coordinator1
        
        XCTAssertEqual(coordinator1, coordinator2)
    }

    func testCoordinatorInequality() {
        let coordinator1 = Coordinator()
        let coordinator2 = Coordinator()
        
        XCTAssertNotEqual(coordinator1, coordinator2)
    }
    
    func testGiverCoordinatorWhenAddChildThenNumberOfChildsIncrease() {
        let coordinator1 = Coordinator()
        let childCoordinator = Coordinator()
        
        let coordinator1NumberOfChildsBefore = coordinator1.numberOfChilds()
        coordinator1.addChildCoordinator(childCoordinator)
        let coordinator1NumberOfChildsAfter = coordinator1.numberOfChilds()
        
        XCTAssertEqual(coordinator1NumberOfChildsBefore + 1, coordinator1NumberOfChildsAfter)
    }
    
    func testGiverCoordinatorWhenRemoveChildThenNumberOfChildsDecrease() {
        let coordinator1 = Coordinator()
        let childCoordinator = Coordinator()
        
        coordinator1.addChildCoordinator(childCoordinator)
        let coordinator1NumberOfChildsBefore = coordinator1.numberOfChilds()
        coordinator1.removeChildCoordinator(childCoordinator)
        let coordinator1NumberOfChildsAfter = coordinator1.numberOfChilds()
        
        XCTAssertEqual(coordinator1NumberOfChildsBefore - 1, coordinator1NumberOfChildsAfter)
    }
    
    func testGiverCoordinatorWhenTryToRemoveCoordinatorNotChildThenSameNumberOfChilds() {
        let coordinator1 = Coordinator()
        let childCoordinator = Coordinator()
        let notChildCoordinator = Coordinator()
        
        coordinator1.addChildCoordinator(childCoordinator)
        let coordinator1NumberOfChildsBefore = coordinator1.numberOfChilds()
        coordinator1.removeChildCoordinator(notChildCoordinator)
        let coordinator1NumberOfChildsAfter = coordinator1.numberOfChilds()
        
        XCTAssertEqual(coordinator1NumberOfChildsBefore, coordinator1NumberOfChildsAfter)
    }
}
