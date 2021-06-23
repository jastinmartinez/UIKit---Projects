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
    
    func getAllInpectionOfDate(completion: @escaping () -> () ) {
        
        inspectionService.getAll { inspections in
            self.inspections = inspections.filter({$0.state})
            completion()
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
        
        inspectionService.rentExist(inspections[index]) { inspections in
            if inspections.count > 0 {
                self.inspectionViewDelagateProtocol?.didErrorOcurred(title: "Inspeccion", message: "Esta No puede ser eliminada ya que esta en uso por un proceso de renta")
            }
            else {
                self.inspectionService.remove(self.inspections[index])
                self.inspections.remove(at: index)
            }
        }
    }
    
    typealias aType = Inspection
    
    
    private var inspectionService = InspectionService()
    
    private(set) var inspections = [Inspection]() {
        didSet {
            inspectionViewDelagateProtocol?.didInspectionsChange()
        }
    }
    
}
