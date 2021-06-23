//
//  DevolutionPresenter.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

class DevolutionPresenter: PresenterProtocol,PresenterTypeProtocol {
    
    private var devolutionService = DevolutionService()
    
    var devolutionViewDelegateProtocol: DevolutionViewDelegateProtocol?
    
    private(set) var devolutions = [Devolution]() {
        didSet {
            
            self.devolutionViewDelegateProtocol?.didDevolutionload()
        }
    }
    func create(_ vm: Devolution) {
        
        devolutionService.create(vm) { devolution in
            
            self.devolutions.append(devolution)
        }
    }
    
    func getAll() {
        
        devolutionService.getAll { devolutions in
            self.devolutions = devolutions
        }
    }
    
    func update(_ vm: Devolution) {
        
    }
    
    func remove(for index: Int) {
        
    }
    
    typealias aType = Devolution
    
    
    
    
}
