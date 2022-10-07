//
//  RegistroHorasViewController.swift
//  appCaritasMty
//
//  Created by Eduardo Jair Hernández Gómez on 06/10/22.
//

import UIKit

class RegistroHorasViewController: UIViewController {

    @IBOutlet weak var tfProject: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    let datePicker = UIDatePicker()
    let projectPicker = UIPickerView()
    let projects = ["Banco de Alimentos","Banco de Ropa y Artículos Varios","Banco de Medicamentos","Posada del Peregrino","Dignamente Vestido","Ducha-T","Reestructuración de Centros","Campañas de Emergencia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        projectPicker.delegate = self
        projectPicker.dataSource = self
        
        createsPickers()
        
        tfProject.tintColor = .clear
        tfStartDate.tintColor = .clear
        tfEndDate.tintColor = .clear
        tfProject.layer.cornerRadius = 5
        tfProject.layer.masksToBounds = true
        tfProject.layer.borderWidth = 1
        tfProject.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
        tfProject.backgroundColor = UIColor(rgb: 0x4397A7).withAlphaComponent(0.08)
        tfProject.setLeftPaddingPoints(10)
        tfProject.setRightPaddingPoints(10)
        
        tfStartDate.layer.cornerRadius = 5
        tfStartDate.layer.masksToBounds = true
        tfStartDate.layer.borderWidth = 1
        tfStartDate.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
        tfStartDate.backgroundColor = UIColor(rgb: 0x4397A7).withAlphaComponent(0.08)
        tfStartDate.setLeftPaddingPoints(10)
        tfStartDate.setRightPaddingPoints(10)
        
        tfEndDate.layer.cornerRadius = 5
        tfEndDate.layer.masksToBounds = true
        tfEndDate.layer.borderWidth = 1
        tfEndDate.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
        tfEndDate.backgroundColor = UIColor(rgb: 0x4397A7).withAlphaComponent(0.08)
        tfEndDate.setLeftPaddingPoints(10)
        tfEndDate.setRightPaddingPoints(10)
    }
    
    @IBAction func BtnRegistrarHoras(_ sender: UIButton) {
        let alerta = UIAlertController(title: "✅\nHoras Registradas", message: "Tus horas han sido correctamente registradas en el sistema", preferredStyle: .alert);
                   let botonAceptar = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                   alerta.addAction(botonAceptar)
                   present(alerta, animated: true)
        tfProject.text = ""
        tfEndDate.text = ""
        tfStartDate.text = ""
    }
    
        
    func createToolBar1()-> UIToolbar{
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createToolBar2()-> UIToolbar{
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createToolBar3()-> UIToolbar{
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed3))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createsPickers(){
        datePicker.preferredDatePickerStyle = .wheels
        tfStartDate.inputView = datePicker
        tfStartDate.inputAccessoryView = createToolBar1()
        tfEndDate.inputView = datePicker
        tfEndDate.inputAccessoryView = createToolBar2()
        tfProject.inputView = projectPicker
        tfProject.inputAccessoryView = createToolBar3()
    }
    
    @objc func donePressed1(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfStartDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donePressed2(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfEndDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donePressed3(){
        let selectedProject = projects[projectPicker.selectedRow(inComponent: 0)]
        tfProject.text = selectedProject
        self.view.endEditing(true)
    }
 
    
}

extension UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}


extension RegistroHorasViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        tfProject.text = projects[row]
//        tfProject.resignFirstResponder()
//    }
    
}
