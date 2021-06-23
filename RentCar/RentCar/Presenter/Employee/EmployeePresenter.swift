//
//  EmployeePresenter.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation

class EmployeePresenter : PresenterTypeProtocol {
    
    private var employeeService: EmployeeService = EmployeeService()

    var employeeViewDelegate: EmployeeViewDelegateProtocol?
    
    private(set) var _employees = [Employee]()
    
    private(set) var employees = [Employee]() {
        didSet {
            self.employeeViewDelegate?.didEmployeesChange()
        }
    }
    
    private func errorMesssage(title:String,message:String ) -> Bool {
        self.employeeViewDelegate?.didErrorOcurred(title: title, message: message)
        return true
    }
    
    fileprivate func employeeDataValidation(_ vm: Employee,iDFilters: @escaping (Employee) -> (Bool),isValidation: @escaping (Bool) -> ()) {
        
        employeeService.verifyEmployeeID(vm) { existEmployee in
            
            if !existEmployee.isEmpty {
                if existEmployee.filter(iDFilters).count > 0 {
                    isValidation(self.errorMesssage(title: "Empleado", message: "La Cedula \(vm.employeeID) se encuentra registrada"))
                }
            }
            isValidation(false)
        }
    }
    
    
    func create(_ vm: Employee, notifyViewValidationStatus: @escaping (Bool) -> ()) {
        
        employeeDataValidation(vm,iDFilters: {$0.employeeID == vm.employeeID}) { isValidationTriggered in
            
            if !isValidationTriggered {
                self.employeeService.create(vm) { employee in
                    self.employees.append(employee)
                }
            }
            notifyViewValidationStatus(isValidationTriggered)
        }
    }
    
    func update(_ vm: Employee,notifyViewValidationStatus: @escaping (Bool) -> ()) {
        
        employeeDataValidation(vm,iDFilters: {$0.employeeID == vm.employeeID && $0.id != vm.id}) { isValidationTriggered in
            
            if !isValidationTriggered {
                
                self.employees[self.employees.firstIndex(where: {$0.id == vm.id})!] = vm
                self.employeeService.update(vm)
            }
            notifyViewValidationStatus(isValidationTriggered)
        }
    }
    
    func getAllWithActiveStatus() {
        employeeService.getAll { employees in
            self._employees = employees
            self.employees = employees.filter({$0.state})
        }
    }
    
    func remove(_ index: Int) {
        employeeService.remove(employees[index])
        employees.remove(at: index)
    }
    
    func getAll() {
        employeeService.getAll { employees in
            self.employees = employees
        }
    }
}
