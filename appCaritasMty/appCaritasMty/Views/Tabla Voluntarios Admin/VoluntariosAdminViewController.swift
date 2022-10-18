//
//  VoluntariosAdminViewController.swift
//  appCaritasMty
//
//  Created by CLP on 12/10/22.
//

import UIKit

class VoluntariosAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tablaVoluntarios: UITableView!
    
    let reuseIdentifier = "VoluntariosCell"
    
    var volManager = voluntariosManager()

    var listaVoluntarios = [horasValidadasVoluntario](){
        didSet {
            DispatchQueue.main.async {
                self.tablaVoluntarios.reloadData()
            }
        }
    }
    
    var nombresVoluntarios = [String] ()
    
    var sectionTittle = [String]()
    
    var volDict = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volManager.fetchVoluntarios{volArray in self.listaVoluntarios = volArray}
        
        tablaVoluntarios.delegate = self
        tablaVoluntarios.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nombresVoluntarios = [String] ()
        sectionTittle = [String]()
        volDict = [String: [String]]()
        volManager.fetchVoluntarios{volArray in self.listaVoluntarios = volArray}
        
        tablaVoluntarios.delegate = self
        tablaVoluntarios.dataSource = self
        tablaVoluntarios.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listaVoluntarios.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! VoluntarioTableViewCell

        cell.lbNombre.text = listaVoluntarios[indexPath.row].Nombre
        cell.lbCorreo.text = listaVoluntarios[indexPath.row].Correo
        cell.lbHoras.text = listaVoluntarios[indexPath.row].HorasVol

        return cell
    }
    
    /*
    Autora: GERALDINE TORRES

     Esta función envía el voluntario Seleccionado a la pantalla de HrsVoluntarioViewController para poder utilizar su id en esa pantalla.
     
     :params: variable de tipo horasValidadasVoluntario que será el voluntario seleccionado.
     :returns: ninguno
     
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vistaSiguiente = segue.destination as! HrsVoluntarioViewController

        let renglonSeleccionado = tablaVoluntarios.indexPathForSelectedRow!
        
        let voluntarioSeleccionado = listaVoluntarios[renglonSeleccionado.row]

        vistaSiguiente.voluntarioRecibido = voluntarioSeleccionado

    }
}
