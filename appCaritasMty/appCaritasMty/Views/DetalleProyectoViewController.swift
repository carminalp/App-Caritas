//
//  DetalleProyectoViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 03/10/22.
//

import UIKit

class DetalleProyectoViewController: UIViewController {
    
    //@IBOutlet weak var tituloHeight: NSLayoutConstraint!
    @IBOutlet weak var lbDescripcion: UILabel!
    //    @IBOutlet weak var textViewHeightDescription: NSLayoutConstraint!
    @IBOutlet weak var lbActividades: UILabel!
    //    @IBOutlet weak var textViewHeightSub: NSLayoutConstraint!
//    @IBOutlet weak var textViewHeightAct: NSLayoutConstraint!
    
    @IBOutlet weak var degradadoImagen: UIView!
    @IBOutlet weak var postularseView: UIView!
    @IBOutlet weak var imageViewAlimentos: UIView!
    //@IBOutlet weak var postularseV: UIView!
    
    @IBOutlet weak var tlHoras: UILabel!
    @IBOutlet weak var tlFecha: UILabel!
    @IBOutlet weak var lbNombreProyecto: UILabel!
    @IBOutlet weak var imgProyecto: UIImageView!
    @IBOutlet weak var btnInscribirme: UIButton!
    
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
            
        self.view.bringSubviewToFront(postularseView)
        lbActividades.numberOfLines = 0
        lbDescripcion.numberOfLines = 0
        lbDescripcion.sizeToFit()
        lbActividades.sizeToFit()
        
        imageViewAlimentos.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        postularseView.roundCorners(corners: [.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 15)
        
        degradadoImagen.setTwoGradient(colorOne: UIColor.white.withAlphaComponent(0.1), colorTwo: UIColor(red: 0.56, green: 0.76, blue: 0.62, alpha: 1.00))
        
//        tituloHeight.constant = self.textViewTitulo.contentSize.height
        
        // HORAS Y FECHA
        tlHoras.text = "06 octubre"
        tlFecha.text = ""
        
        
        
        // DESCRIPCION TEXTO
        
//        let descripcion = NSMutableParagraphStyle()
//        descripcion.lineSpacing = 4.0
//        let attributedStringDesc = NSMutableAttributedString(string: "Maneja alimentos a gran escala para hacerlos llegar a comunidades de extrema pobreza con problemas de desnutrición.", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
//
//        attributedStringDesc.addAttribute(NSAttributedString.Key.paragraphStyle, value: descripcion, range: NSMakeRange(0, attributedStringDesc.length))
//
//        textViewDescription.attributedText = attributedStringDesc
//        textViewHeightDescription.constant = self.textViewDescription.contentSize.height
        
        
        
        // SUBTITULO TEXTO
        
        
//        textViewSubtitulo.text = "Actividades generales a realizar: "
//        textViewHeightSub.constant = self.textViewSubtitulo.contentSize.height

        // ACTIVIDADES TEXTO
        
//        let actividades = NSMutableParagraphStyle()
//        actividades.lineSpacing = 4.0
//        let attributedString = NSMutableAttributedString(string: "— Apoyar en la selección, peso y clasificación de alimentos\n— Lavar tarimas y cajas plásticas con pistola y cepillos en exterior del almacén\n— Apoyar en el registro y captura de vales de las instituciones beneficiadas con algún programa", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
//
//
//        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: actividades, range: NSMakeRange(0, attributedString.length))
        
       
        
//        textViewActividades.attributedText = attributedString
//        textViewHeightAct.constant = self.textViewActividades.contentSize.height
        
        lbNombreProyecto.text = projectReceived.projectName
        lbDescripcion.text = projectReceived.projectDesc
        lbActividades.text = projectReceived.projectActivities
        imgProyecto.image = projectReceived.projectImage
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            "idVol": Int(idVol),
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
        /*let alerta = UIAlertController(title: "Inscripción completada", message: "La inscripción ha sido validada correctamente.", preferredStyle: .alert);
                   let botonCancel = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                   alerta.addAction(botonCancel)
                   present(alerta, animated: true)*/
        btnInscribirme.isEnabled = false
        btnInscribirme.setTitle("Inscrito", for: .normal)
        API()
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
