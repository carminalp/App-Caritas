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
    @IBOutlet weak var lbNombre: UILabel!
    
    let datePicker = UIDatePicker()
    let projectPicker = UIPickerView()
    var projects = [String] ()
    var idP = [String: Int] ()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nombre = defaults.string(forKey: "nombreVol")
        lbNombre.text = "Hola, " + nombre!
        
        projectPicker.delegate = self
        projectPicker.dataSource = self
        
        API01()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        projects = [String] ()
        idP = [String: Int] ()
        API01()
    }
    
    func API01() -> String{
        let id = defaults.integer(forKey: "idVol")
        var apiAnswer = ""
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/proyectoRegistro?idVol=\(id)") else{
                return apiAnswer
        }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                        if let data = data{
                            do{
                                let decoder = JSONDecoder()
                                let tasks = try decoder.decode([Proyecto].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        self.projects.append(i.Proyecto)
                                        self.idP[i.Proyecto]=(i.idProyecto)
                        
                                        // Agregar segue a la vista de voluntario
                                        apiAnswer = "valid"
                                    }
                                }else{
                                    // Ventana emergente usuario inválido
                                    apiAnswer = "invalid"
                                }
                            }catch{
                                print(error)
                            }
                        }
                group.leave()
            }
            task.resume()

        group.wait()
        createsPickers()
        return apiAnswer
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
    
    /**
    Esta función crea los pickers para las fechas y los proyectos, genera los toolbar para cada picker y define el estilo del picker.
                            
    :author: Eduardo Hernández
    */
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
        let dateFormatter2 = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfStartDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let f1 = dateFormatter2.string(from: datePicker.date)
        let feIn = defaults.set(f1, forKey: "FechaIn")
    }
    
    @objc func donePressed2(){
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.tfEndDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let f2 = dateFormatter2.string(from: datePicker.date)
        let feFin = defaults.set(f2, forKey: "FechaFin")
    }
    
    
    @objc func donePressed3(){
        if(!projects.isEmpty){
            let selectedProject = projects[projectPicker.selectedRow(inComponent: 0)]
            tfProject.text = selectedProject
        }
        self.view.endEditing(true)
    }
    
    func API(){
        let idVol = defaults.integer(forKey: "idVol")
        let idCat = Int(idP[tfProject.text!]!)
        var fechaIn = defaults.string(forKey: "FechaIn")
        var fechaFi = defaults.string(forKey: "FechaFin")
        
        if(fechaIn?.count == 23){
            fechaIn = fechaIn!.substring(with: 0..<18)
        }else if(fechaIn?.count == 24){
            fechaIn = fechaIn!.substring(with: 0..<19)
        }
        
        if(fechaFi?.count == 23){
            fechaFi = fechaFi!.substring(with: 0..<18)
        }else if(fechaFi?.count == 24){
            fechaFi = fechaFi!.substring(with: 0..<19)
        }
        
        
        // 2 0 2 2 - 1 0 - 1 8    9  :  2  3  :  0  5      p .  m  .
        // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
        
        let validar = 0
        let h = calculaHoras()
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/registro/horas") else{
                return
            }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: AnyHashable] = [
            "idVol": idVol,
            "idProyecto": idCat,
            "horaFechaEntrada": String(fechaIn!),
            "horaFechaSalida": String(fechaFi!),
            "validacion": validar,
            "horas": h
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    /**
    Esta función valida las fechas de inicio y de fin, con el fin de verificar que la resta de horas sea positiva.
    
    :condiciones: Si alguna fecha o proyecto está vacía:
                * Se invalida la fecha
              Si no:
                * Calcula la diferencia de horas
                * Verifica si la diferencia es mayor a 0
                * Verifica si el día, mes y año es el mismo en ambas fechas
                            
    :returns: Booleano que indica si la fecha es válida
    :author: Eduardo Hernández
    */
    
    func validaFecha()->Bool{
        
        if(tfStartDate.text == "" || tfEndDate.text == "" || tfProject.text == ""){ return false}
        var horasTotal = 0, horasIni = 0,horasFin = 0
        let dateIni = tfStartDate.text
        let dateFin = tfEndDate.text
        let diaIni = Int(dateIni!.substring(with: 0..<2))
        let diaFin = Int(dateFin!.substring(with: 0..<2))
        let mesIni = Int(dateIni!.substring(with: 3..<5))
        let mesFin = Int(dateFin!.substring(with: 3..<5))
        let anioIni = Int(dateIni!.substring(with: 6..<8))
        let anioFin = Int(dateFin!.substring(with: 6..<8))
        
        print(dateIni!.substring(with: 8..<9))
        if(dateIni!.substring(with: 8..<9) == ","){
            if(dateIni?.count == 15){
                horasIni = Int(dateIni!.substring(with: 10..<12))!
            }else{
                horasIni = Int(dateIni!.substring(with: 10..<11))!
            }
            if(dateFin?.count == 15){
                horasFin = Int(dateFin!.substring(with: 10..<12))!
            }else{
                horasFin = Int(dateFin!.substring(with: 10..<11))!
            }
        }else {
            if(dateIni?.count == 14){
                horasIni = Int(dateIni!.substring(with: 9..<11))!
            }else{
                horasIni = Int(dateIni!.substring(with: 9..<10))!
            }
            if(dateFin?.count == 14){
                horasFin = Int(dateFin!.substring(with: 9..<11))!
            }else{
                horasFin = Int(dateFin!.substring(with: 9..<10))!
            }
        }
        

        
        horasTotal = horasFin - horasIni
        
        if (diaIni == diaFin && mesIni == mesFin && anioIni == anioFin &&  horasTotal > 0){
            return true
        }else{
            return false
        }
                
    }
    
    func calculaHoras()->Int{
        var horas = 0, horasIni = 0, horasFin = 0
        let dateIni = tfStartDate.text
        let dateFin = tfEndDate.text
        if(dateIni!.substring(with: 8..<9) == ","){
            if(dateIni?.count == 15){
                horasIni = Int(dateIni!.substring(with: 10..<12))!
            }else{
                horasIni = Int(dateIni!.substring(with: 10..<11))!
            }
            if(dateFin?.count == 15){
                horasFin = Int(dateFin!.substring(with: 10..<12))!
            }else{
                horasFin = Int(dateFin!.substring(with: 10..<11))!
            }
        }else {
            if(dateIni?.count == 14){
                horasIni = Int(dateIni!.substring(with: 9..<11))!
            }else{
                horasIni = Int(dateIni!.substring(with: 9..<10))!
            }
            if(dateFin?.count == 14){
                horasFin = Int(dateFin!.substring(with: 9..<11))!
            }else{
                horasFin = Int(dateFin!.substring(with: 9..<10))!
            }
        }
        horas = horasFin - horasIni
        return horas
    }
    
    
    
    @IBAction func BtnRegistrarHoras(_ sender: UIButton) {
        
        if validaFecha(){
            let alerta = UIAlertController(title: "✅\nHoras Registradas", message: "Tus horas han sido correctamente registradas en el sistema", preferredStyle: .alert);
                       let botonAceptar = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                       alerta.addAction(botonAceptar)
                       present(alerta, animated: true)
            API()
            tfProject.text = ""
            tfEndDate.text = ""
            tfStartDate.text = ""

        }else{
            let alerta = UIAlertController(title: "❌\nDatos inválidos", message: "Verifica los datos introducidos", preferredStyle: .alert);
                       let botonAceptar = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                       alerta.addAction(botonAceptar)
                       present(alerta, animated: true)
            tfEndDate.text = ""
            tfStartDate.text = ""
        }

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
    
}

extension String {
    func index(from: Int) -> Index {
         return self.index(startIndex, offsetBy: from)
     }

     func substring(from: Int) -> String {
         let fromIndex = index(from: from)
         return String(self[fromIndex...])
     }

     func substring(to: Int) -> String {
         let toIndex = index(from: to)
         return String(self[..<toIndex])
     }

     func substring(with r: Range<Int>) -> String {
         let startIndex = index(from: r.lowerBound)
         let endIndex = index(from: r.upperBound)
         return String(self[startIndex..<endIndex])
     }
}
