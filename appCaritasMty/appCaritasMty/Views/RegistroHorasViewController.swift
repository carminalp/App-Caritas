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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
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
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        tfStartDate.inputView = datePicker
        tfStartDate.inputAccessoryView = createToolBar1()
        tfEndDate.inputView = datePicker
        tfEndDate.inputAccessoryView = createToolBar2()
    }
    
    @objc func donePressed1(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfStartDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donePressed2(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfEndDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
 
    
}

extension UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
