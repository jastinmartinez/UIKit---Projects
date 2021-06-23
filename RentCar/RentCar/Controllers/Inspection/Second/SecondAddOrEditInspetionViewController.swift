//
//  SecondAddOrEditInspetionViewController.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import UIKit

class SecondAddOrEditInspetionViewController: UIViewController {
    
    @IBOutlet weak var inspectionHydraulicJackSwitch: UISwitch!
    @IBOutlet weak var inspectionScratchSwitch: UISwitch!
    @IBOutlet weak var inspectionGlassBreakageSwitch: UISwitch!
    @IBOutlet weak var inspectionRubberBack: UISwitch!
    @IBOutlet weak var inspectionRubber1Switch: UISwitch!
    @IBOutlet weak var inspectionRubber2Switch: UISwitch!
    @IBOutlet weak var inspectionRubber3Switch: UISwitch!
    @IBOutlet weak var inspectionRubber4Switch: UISwitch!
    @IBOutlet weak var inspectionDateDatePicker: UIDatePicker!
    @IBOutlet weak var InspectionStateSwitch: UISwitch!
    @IBOutlet weak var inspectionEmployeePickerView: UIPickerView!
    
    var inspectionPresenter: InspectionPresenter?
    var employeePresenter: EmployeePresenter?
    
    var vehicleID: UUID?
    var customerID: UUID?
    var combustibleAmount: String?
    var employeeID: UUID?
    
    var inspection: Inspection?
    var isViewOnly: Bool?

    var inspectionDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    @IBAction func inspectionDateDatePickerValueChanged(_ sender: Any) {
        
        self.inspectionDate = inspectionDateDatePicker.date
    }
    
    @IBAction func inspectionSavedButtonPressed(_ sender: Any) {
        
        guard isViewOnly == false || isViewOnly == nil else { return }
        
        if vehicleID != nil, customerID != nil, combustibleAmount != nil,employeeID != nil   {
            
            if let inspection = inspection {
                self.inspectionPresenter?.update(Inspection(id: inspection.id, vehicle: ParentModel(id: vehicleID), customer: ParentModel(id: customerID), scratch: inspectionScratchSwitch.isOn, combustibleAmount: combustibleAmount!, rubberBack: inspectionRubberBack.isOn, hydraulicJack: inspectionHydraulicJackSwitch.isOn, glassBreakage: inspectionGlassBreakageSwitch.isOn, rubberState1: inspectionRubber1Switch.isOn, rubberState2: inspectionRubber2Switch.isOn, rubberState3: inspectionRubber3Switch.isOn, rubberState4: inspectionRubber4Switch.isOn, date: inspectionDate.toString(), employee: ParentModel(id: employeeID), state: true))
            }else {
            
            self.inspectionPresenter?.create(Inspection( vehicle: ParentModel(id: vehicleID), customer: ParentModel(id: customerID), scratch: inspectionScratchSwitch.isOn, combustibleAmount: combustibleAmount!, rubberBack: inspectionRubberBack.isOn, hydraulicJack: inspectionHydraulicJackSwitch.isOn, glassBreakage: inspectionGlassBreakageSwitch.isOn, rubberState1: inspectionRubber1Switch.isOn, rubberState2: inspectionRubber2Switch.isOn, rubberState3: inspectionRubber3Switch.isOn, rubberState4: inspectionRubber4Switch.isOn, date: inspectionDate.toString(), employee: ParentModel(id: employeeID), state: true))
            }
            
            self.navigationController?.popToViewController(navigationController!.viewControllers[navigationController!.viewControllers.count - 3], animated: true)
        }
    }
    
    fileprivate func initViewDidLoad() {
        
        if let inspection = inspection, let isViewOnly = isViewOnly {
            
            if isViewOnly {
                initViewOnly(inspection: inspection, isViewOnly: isViewOnly)
            }
            else {
                initEditOnly(inspection: inspection)
            }
        }
        else {
            initAddOnly()
        }
    }
    
    func inspectionModelToOutlet(_ inspection: Inspection) {
        DispatchQueue.main.async { [self] in
            
            inspectionEmployeePickerView.selectRow(employeePresenter!.employees.firstIndex(where: {$0.id == inspection.employee.id})!, inComponent: 0, animated: true)
            
            InspectionStateSwitch.isOn = inspection.state
            inspectionScratchSwitch.isOn = inspection.scratch
            inspectionRubber1Switch.isOn = inspection.rubberState1
            inspectionRubber2Switch.isOn = inspection.rubberState2
            inspectionRubber3Switch.isOn = inspection.rubberState3
            inspectionRubber4Switch.isOn = inspection.rubberState4
            inspectionHydraulicJackSwitch.isOn = inspection.hydraulicJack
            inspectionGlassBreakageSwitch.isOn = inspection.glassBreakage
            inspectionDateDatePicker.date = inspection.date.toDate()
            inspectionDate = inspection.date.toDate()
            employeeID = inspection.employee.id
        }
    }
}
