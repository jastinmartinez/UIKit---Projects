//
//  RentPresenter.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
class RentPresenter: PresenterProtocol,PresenterTypeProtocol {
    
    private var rentService = RentService()
    
    var rentViewDelegateProtocol: rentViewDelegateProtocol?
    
    private(set) var rents = [Rent]() {
    
        didSet {
        
            rentViewDelegateProtocol?.didArrayChange()
        }
    }
    
    func create(_ vm: Rent) {
        rentService.create(vm) { rent in
            self.rents.append(rent)
        }
    }
    
    func getAll() {
        rentService.getAll { rents in
            self.rents = rents
        }
    }
    
    func update(_ vm: Rent) {
        rents[rents.firstIndex(where: {$0.id == vm.id})!] = vm
        rentService.update(vm)
    }
    
    func remove(for index: Int) {
        rentService.remove(rents[index])
        rents.remove(at: index)
    }
    
    typealias aType = Rent

}
