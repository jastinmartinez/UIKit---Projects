//
//  InspectionPresenter.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

class InspectionPresenter: PresenterProtocol, PresenterTypeProtocol{
    
    var inspectionViewDelagateProtocol: InspectionViewdelegateProtocol?
    
    func create(_ vm: Inspection) {
        inspectionService.create(vm) { inspection in
            self.inspections.append(inspection)
        }
    }
    
    func getAll() {
        inspectionService.getAll { inspections in
            self.inspections = inspections
        }
    }
    
    func update(_ vm: Inspection) {
        inspections[inspections.firstIndex(where: {$0.id == vm.id})!] = vm
        inspectionService.update(vm)
    }
    
    func remove(for index: Int) {
        inspectionService.remove(inspections[index])
        inspections.remove(at: index)
    }
    
    typealias aType = Inspection
    
    
    private var inspectionService = InspectionService()
    
    private(set) var inspections = [Inspection]() {
        didSet {
            inspectionViewDelagateProtocol?.didInspectionsChange()
        }
    }
    
}
