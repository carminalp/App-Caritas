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
    
    /*
     Autora: GERALDINE TORRES
     
     Esta variable lo que hace es llenar la tabla con los datos del modelo horasValidadasVoluntario en caso de que haber creado objetos de ese tipo.
     
     */
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
        
        /*
         Autora: GERALDINE TORRES
         
         VolManager es una variable que equivale a una clase que se encarga de extraer todos los voluntarios registrados en la base de datos por medio de una llamada get a la API.
         
         Al momento de inicializar la vista, la variable inicializa el array de listaVoluntarios con el array generado dentro de la función de fetchVoluntarios perteneciente a volManager
         */
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vistaSiguiente = segue.destination as! HrsVoluntarioViewController

        let renglonSeleccionado = tablaVoluntarios.indexPathForSelectedRow!
        
        let voluntarioSeleccionado = listaVoluntarios[renglonSeleccionado.row]

        vistaSiguiente.voluntarioRecibido = voluntarioSeleccionado

    }
}
