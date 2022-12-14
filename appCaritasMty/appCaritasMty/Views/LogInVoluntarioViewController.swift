//
//  LogInVoluntarioViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 18/09/22.
//

import UIKit
import CryptoKit

class LogInVoluntarioViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbEmailError: UILabel!
    @IBOutlet weak var lbPasswordError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
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
    
    
    /**
    Esta función checa el text field del correo, para desplegar un mensaje de error o esconderlo.
    
    :condiciones: Si el correo es inválido:
                * El borde se sombrea en rojo
                * Aparece el mensaje de error
              Si no:
                * Desaparece el mensaje de error
     
    :author: Carmina López
    */
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
            return "Correo inválido. Por favor, ingresa un correo válido."
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
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    func activityIndicator(_ title: String) {
           strLabel.removeFromSuperview()
           activityIndicator.removeFromSuperview()
           effectView.removeFromSuperview()
           strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
           strLabel.text = title
           strLabel.font = .systemFont(ofSize: 14, weight: .medium)
           strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
           effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
           effectView.layer.cornerRadius = 15
           effectView.layer.masksToBounds = true
        activityIndicator = UIActivityIndicatorView(style: .white)
           activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
           activityIndicator.startAnimating()
           effectView.contentView.addSubview(activityIndicator)
           effectView.contentView.addSubview(strLabel)
           view.addSubview(effectView)
       }
    
    @IBAction func login(_ sender: UIButton) {
        activityIndicator("Logging...")
        let ans = API()
        if ans == "valid"{
            let idVol = defaults.integer(forKey: "idVol")
            let nombre = defaults.string(forKey: "nombreVol")
        }else{
            activityIndicator.stopAnimating()
            self.effectView.removeFromSuperview()
            
            let alerta = UIAlertController(title: "Usuario inválido", message: "Verifica que tu correo y contraseña estén correctos.", preferredStyle: .alert);
                       let botonCancel = UIAlertAction(title: "Volver a intentar", style: .cancel, handler: nil)
                       alerta.addAction(botonCancel)
                       present(alerta, animated: true)
        }
    }
    
    /**
    Esta función hashea la contraseña del voluntario.

    :param: String la contraseña que se va a hashear
    :returns: String devuelve la contraseña cifrada
    :author: Carmina López
    */
    func hashing(password : String) -> String{
            let inputdata = Data(password.utf8)
            let hashed = SHA512.hash(data: inputdata)
            let hashPassword = hashed.compactMap { String(format: "%02x", $0) }.joined()
            return (hashPassword)
    }
    
    /**
    Esta función permite llamar a la API, para consultar el correo y contraseña del voluntario y hacer la validación.

    :returns: String devuelve si el usuario es válido o inválido
    :author: Carmina López
    */
    let defaults = UserDefaults.standard
    func API() -> String{
        var searchEmail = "dummy"
        var searchPassword = "dummy"
        var apiAnswer = ""
        
        if (tfEmail != nil && tfPassword.text != ""){
            searchEmail = tfEmail.text!
            searchPassword = hashing(password:  tfPassword.text!)
        }
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/vol?Correo=\(searchEmail)&Contrasenia=\(searchPassword)") else{
                return apiAnswer
            }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                
                let decoder = JSONDecoder()
                        if let data = data{
                            do{
                                let tasks = try decoder.decode([Voluntario].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        self.defaults.setValue(i.Apellido, forKey: "apellidoVol")
                                        apiAnswer = "valid"
                                        self.defaults.setValue(i.Nombre, forKey: "nombreVol")
                                        self.defaults.setValue(i.idVol, forKey: "idVol")
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
        return apiAnswer
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
