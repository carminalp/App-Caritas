//
//  LogInAdministradorViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 19/09/22.
//

import UIKit
import CryptoKit

class LogInAdministradorViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbEmailError: UILabel!
    @IBOutlet weak var lbPasswordError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    let defaults = UserDefaults.standard
    
    var backButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.title = "Back"
        backButton.isEnabled = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tfEmail.layer.cornerRadius = 5
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.borderWidth = 1
        tfEmail.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
        tfEmail.backgroundColor = UIColor(rgb: 0x4397A7).withAlphaComponent(0.08)
        tfEmail.setLeftPaddingPoints(10)
        tfEmail.setRightPaddingPoints(10)
        tfPassword.layer.cornerRadius = 5
        tfPassword.layer.masksToBounds = true
        tfPassword.layer.borderWidth = 1
        tfPassword.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
        tfPassword.backgroundColor = UIColor(rgb: 0x4397A7).withAlphaComponent(0.08)
        tfPassword.setLeftPaddingPoints(10)
        tfPassword.setRightPaddingPoints(10)

        resetForm()
    }
    
    func resetForm(){
        btnLogin.isEnabled = false
        
        lbEmailError.isHidden = false
        lbPasswordError.isHidden = false
        
        lbEmailError.text = ""
        lbPasswordError.text = ""
        
        tfEmail.text = ""
        tfPassword.text = ""
    }
    

    @IBAction func emailChanged(_ sender: Any) {
        if let email = tfEmail.text{
            if let errorMessage = invalidEmail(email){
                tfEmail.layer.borderColor = UIColor(red:255/255, green: 59/255,blue: 48/255, alpha: 1).cgColor
                lbEmailError.text = errorMessage
                lbEmailError.isHidden = false
            }
            else {
                tfEmail.layer.borderColor = UIColor(rgb: 0x0099A9).cgColor
                lbEmailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidEmail(_ email: String) -> String?{
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if predicate.evaluate(with: email) == false{
            return "Correo inv??lido. Por favor, ingresa un correo v??lido."
        }
        return nil
    }
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if ((tfPassword.text?.isEmpty) != nil) {
            lbPasswordError.isHidden = true
        }
        checkForValidForm()
    }
    
    func checkForValidForm(){
        if lbEmailError.isHidden && lbPasswordError.isHidden{
            btnLogin.isEnabled = true
        }
        else{
            btnLogin.isEnabled = false
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        if API() == "invalid"{
            let alerta = UIAlertController(title: "Usuario inv??lido", message: "Verifica que tu correo y contrase??a est??n correctos.", preferredStyle: .alert);
                       let botonCancel = UIAlertAction(title: "Volver a intentar", style: .cancel, handler: nil)
                       alerta.addAction(botonCancel)
                       present(alerta, animated: true)
        }
    }
    
    func hashing(password : String) -> String{
            let inputdata = Data(password.utf8)
            let hashed = SHA512.hash(data: inputdata)
            let hashPassword = hashed.compactMap { String(format: "%02x", $0) }.joined()
            return (hashPassword)
    }
    
    /**
    Esta funci??n llama a la API, para consultar el correo y contrase??a del administrador y hacer la validaci??n.

    :returns: Confirma si el usuario es valido o invalido

    :author: Cristina Hernandez
    */
    
    func API() -> String{
        var searchEmail = "dummy"
        var searchPassword = "dummy"
        var apiAnswer = ""
        
        if (tfEmail != nil && tfPassword.text != ""){
            searchEmail = tfEmail.text!
            searchPassword = hashing(password:  tfPassword.text!)
        }
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin?Correo=\(searchEmail)&Contrasenia=\(searchPassword)") else{
                return apiAnswer
            }
        
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                
                let decoder = JSONDecoder()
                        if let data = data{
                            do{
                                let tasks = try decoder.decode([Administrador].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        self.defaults.setValue(i.nombreAdmin, forKey: "nombreAd")
                                        self.defaults.setValue(i.idAdmin, forKey: "idAdmin")
                                        // Agregar segue a la vista de voluntario
                                        apiAnswer = "valid"
                                    }
                                }else{
                                    // Ventana emergente usuario inv??lido
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
        return apiAnswer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
