//
//  DetalleProyectoViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 03/10/22.
//

import UIKit

class DetalleProyectoViewController: UIViewController {
    
    @IBOutlet weak var textViewTitulo: UITextView!
    @IBOutlet weak var tituloHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var textViewHeightDescription: NSLayoutConstraint!
    
    @IBOutlet weak var textViewSubtitulo: UITextView!
    @IBOutlet weak var textViewHeightSub: NSLayoutConstraint!
    
    @IBOutlet weak var textViewActividades: UITextView!
    @IBOutlet weak var textViewHeightAct: NSLayoutConstraint!
    
    @IBOutlet weak var degradadoImagen: UIView!
    
    @IBOutlet weak var postularseView: UIView!
    @IBOutlet weak var imageViewAlimentos: UIView!
    @IBOutlet weak var postularseV: UIView!
    
    
    @IBOutlet weak var tlHoras: UILabel!
    @IBOutlet weak var tlFecha: UILabel!
    
    @IBOutlet weak var lbNombreProyecto: UILabel!
    @IBOutlet weak var imgProyecto: UIImageView!
    
    @IBOutlet weak var btnInscribirme: UIButton!
    
    var projectReceived = projectList(projectName: "oli", projectDesc: "",projectActivities: "", projectImage: UIImage(named: "imgAlimentos")!)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(postularseView)
        
        imageViewAlimentos.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        postularseView.roundCorners(corners: [.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 15)
        
        degradadoImagen.setTwoGradient(colorOne: UIColor.white.withAlphaComponent(0.1), colorTwo: UIColor(red: 0.56, green: 0.76, blue: 0.62, alpha: 1.00))
        
        tituloHeight.constant = self.textViewTitulo.contentSize.height
        
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
        textViewDescription.text = projectReceived.projectDesc
        textViewActividades.text = projectReceived.projectActivities
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

    @IBAction func inscribirme(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Inscripción completada", message: "La inscripción ha sido validada correctamente.", preferredStyle: .alert);
                   let botonCancel = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                   alerta.addAction(botonCancel)
                   present(alerta, animated: true)
        btnInscribirme.isEnabled = false
    }
    
}
