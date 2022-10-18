//
//  DetalleProyectoViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 03/10/22.
//

import UIKit

class DetalleProyectoViewController: UIViewController {
    
    @IBOutlet weak var lbDescripcion: UILabel!
    @IBOutlet weak var lbDescripciontext: UILabel!
    
    @IBOutlet weak var lbActividades: UILabel!
    @IBOutlet weak var lbActividadestext: UILabel!
    
    @IBOutlet weak var degradadoImagen: UIView!
    @IBOutlet weak var imageViewAlimentos: UIView!
    //@IBOutlet weak var postularseV: UIView!

    @IBOutlet weak var lbNombreProyecto: UILabel!
    @IBOutlet weak var tlFecha: UILabel!

    @IBOutlet weak var imgProyecto: UIImageView!
    @IBOutlet weak var btnInscribirme: UIButton!
    
    @IBOutlet weak var viewButton: UIView!
    
    var projectReceived = projectList(projectName: "oli", projectDesc: "",projectActivities: "", projectImage: UIImage(named: "imgAlimentos")!)

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        API01()
        let V = defaults.integer(forKey: "idVol")
        let P = defaults.integer(forKey: "idProyecto")
        let V1 = defaults.integer(forKey: "idVolCheck")
        let P1 = defaults.integer(forKey: "idProyectoCheck")
        
        if(V==V1 && P==P1){
            btnInscribirme.isEnabled = false
            btnInscribirme.setTitle("Inscrito", for: .normal)
        }
            
        lbActividadestext.numberOfLines = 0
        lbDescripciontext.numberOfLines = 0
        lbDescripciontext.sizeToFit()
        lbActividadestext.sizeToFit()
        
        imageViewAlimentos.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        
        degradadoImagen.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        
        
        degradadoImagen.setTwoGradient(colorOne: UIColor.white.withAlphaComponent(0.1), colorTwo: UIColor(red: 0.56, green: 0.76, blue: 0.62, alpha: 1.00))
        
        lbNombreProyecto.font = lbNombreProyecto.font.withSize(self.view.frame.height * 0.03)
        tlFecha.font = tlFecha.font.withSize(self.view.frame.height * 0.023)
        lbDescripcion.font = lbDescripcion.font.withSize(self.view.frame.height * 0.027)
        lbActividades.font = lbActividades.font.withSize(self.view.frame.height * 0.027)
        lbDescripciontext.font = lbDescripciontext.font.withSize(self.view.frame.height * 0.021)
        lbActividadestext.font = lbActividadestext.font.withSize(self.view.frame.height * 0.021)
        
        // FECHA
        tlFecha.text = "06 octubre"
        
        
        lbNombreProyecto.text = projectReceived.projectName
        lbDescripciontext.text = projectReceived.projectDesc
        lbActividadestext.text = projectReceived.projectActivities
        imgProyecto.image = projectReceived.projectImage
        
    }
    
    func API(){
        let idVol = defaults.integer(forKey: "idVol")
        let idProyecto = defaults.integer(forKey: "idProyecto")
        let fechaInscripcion = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let f1 = dateFormatter.string(from: fechaInscripcion)

        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/vol/proyecto") else{
                return
            }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: AnyHashable] = [
            "idVol": idVol,
            "idProyecto": idProyecto,
            "fechaInscripcion": f1
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("No murio:  \(response)")
            }
            catch{
                print(error)
            }
        }
        task.resume()
        return
    }
    
    @IBAction func inscribirme(_ sender: UIButton) {
        showAlert(title: "Confirmación", message: "¿Estás seguro que deseas inscribirte?", handlerAceptar: { action in
            self.btnInscribirme.isEnabled = false
            self.btnInscribirme.setTitle("Inscrito", for: .normal)
            print(self.defaults.integer(forKey: "idVol"))
            self.API()
        }, handlerCancelar: {actionCanel in
            print("Action cancel called")
        })

    }
    
    func API01(){
        let id = defaults.integer(forKey: "idVol")
        let idProyecto = defaults.integer(forKey: "idProyecto")
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/inscripcionPasada?idVol=\(id)&idProyecto=\(idProyecto)") else{
                return
        }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                        if let data = data{
                            do{
                                let decoder = JSONDecoder()
                                let tasks = try decoder.decode([Inscripcion].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        print("-------- Jaló ---------")
                                        self.defaults.setValue(i.idVol, forKey: "idVolCheck")
                                        self.defaults.setValue(i.idProyecto, forKey: "idProyectoCheck")
                                    }
                                }else{
                                  
                                    print("----- NO INSCRITO -----")
                                }
                            }catch{
                                print(error)
                                print("----- ERROR2 -----")
                            }
                        }
                group.leave()
            }
            task.resume()

        group.wait()
        return
    }
}


extension UIViewController {
    
    func showAlert(title: String, message: String, handlerAceptar:((UIAlertAction) -> Void)?, handlerCancelar: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .cancel, handler: handlerAceptar)
        let actionCanel = UIAlertAction(title: "Cancelar", style: .destructive, handler: handlerCancelar)
        alert.addAction(action)
        alert.addAction(actionCanel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
