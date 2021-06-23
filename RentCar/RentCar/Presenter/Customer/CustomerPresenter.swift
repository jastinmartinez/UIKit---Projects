//
//  CustomerPresenter.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation
class CustomerPresenter: PresenterTypeProtocol {
    
    var customerViewDelegateProtocol: CustomerViewDelegateProtocol!
    
    private var customerService = CustomerService()
    
    private(set) var _customers = [Customer]()
    
    private(set) var customers = [Customer]() {
        didSet {
            
            self.customerViewDelegateProtocol?.didCustomersChange()
        }
    }
    
    private func errorMesssage(title:String,message:String ) -> Bool {
        self.customerViewDelegateProtocol.didErrorOcurred(title: title, message: message)
        return true
    }
    
    fileprivate func customerDataValidation(vm:Customer,iDFilters: @escaping (Customer) -> (Bool), creditCardFilters: @escaping (Customer)->(Bool),isValidation: @escaping (Bool) -> ()) {
        
        customerService.verifyCustomerID(vm) { existCustomer in
            
            if !existCustomer.isEmpty {
                
                if existCustomer.filter(iDFilters).count > 0 {
                    isValidation(self.errorMesssage(title: "Cliente", message: "La Cedula \(vm.customerID) se encuentra registrada"))
                }
                
                else if existCustomer.filter(creditCardFilters).count > 0 {
                    isValidation(self.errorMesssage(title: "Cliente", message: "La Tarjeta \(vm.creditCard) se encuentra registrada"))
                }
            }
            isValidation(false)
        }
    }
    
    
    func create(_ vm: Customer, notifyViewValidationStatus: @escaping (Bool) -> ()) {
        
        customerDataValidation( vm: vm,iDFilters: {$0.customerID == vm.customerID},creditCardFilters: {$0.creditCard == vm.creditCard}) { isValidationTriggered in
            
            if !isValidationTriggered {
                
                self.customerService.create(vm) { customer in
                    self.customers.append(customer)
                }
            }
            notifyViewValidationStatus(isValidationTriggered)
        }
    }
    
    func update(_ vm: Customer,notifyViewValidationStatus: @escaping (Bool) -> ()) {
        
        customerDataValidation( vm: vm,iDFilters: {$0.customerID == vm.customerID && $0.id != vm.id},creditCardFilters: {$0.creditCard == vm.creditCard && $0.id != vm.id}) { isValidationTriggered in
            
            if !isValidationTriggered {
                
                self.customers[self.customers.firstIndex(where: {$0.id == vm.id})!] = vm
                self.customerService.update(vm)
                
            }
            notifyViewValidationStatus(isValidationTriggered)
        }
    }
    
    func remove(_ index: Int) {
        customerService.remove(customers[index])
        customers.remove(at: index)
    }
    
    func getAllWithActiveStatus(completion: @escaping () ->()) {
        customerService.getAll { customers in
            self._customers = customers
            self.customers = customers.filter({$0.state})
            completion()
        }
    }
    
    func getAll(completion: @escaping () -> ()) {
        customerService.getAll { _customers in
            self.customers = _customers
            completion()
        }
    }
}

