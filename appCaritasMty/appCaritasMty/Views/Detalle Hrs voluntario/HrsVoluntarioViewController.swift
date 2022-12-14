//
//  HrsVoluntarioViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 09/10/22.
//

import UIKit

class HrsVoluntarioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var ivPerfil: UIImageView!
    @IBOutlet weak var vistaTabla: UIView!
    @IBOutlet weak var hrsTable: UITableView!
    @IBOutlet weak var NombreVoluntario: UILabel!
    
    var voluntarioRecibido: horasValidadasVoluntario?
    var backButton = UIBarButtonItem()
    var listHorasProyecto = [horasProyecto]()
    
    var listHoras = [String] ()
    var listProyectos = [String] ()
    var apellido = ""
    var nombre = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPerfil.layer.cornerRadius = 150.0/2.0
        ivPerfil.layer.borderWidth = 6
        ivPerfil.layer.borderColor = UIColor(red: 255/255, green: 175/255, blue: 128/255, alpha: 1).cgColor
        backButton.title = "Back"
        backButton.isEnabled = true
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        vistaTabla.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        hrsTable.delegate = self
        hrsTable.dataSource = self
        
        if (voluntarioRecibido != nil){
            API01()
            NombreVoluntario.text = nombre + " " + apellido
        }
        
    }
    

    /*
     
     Autora: GERALDINE TORRES
     
     API01 obtiene las horas por proyecto del voluntario de acuerdo al id que tiene el voluntario.
     
     :condiciones: es importante que
            * La base de datos debe tener datos del voluntario.
            * Se deben crear dos arreglos de tipo string en el view controller
     
     :param: una variable de tipo int que representa el id del voluntario
     :returns: popula los arreglos de tipo string llamados listHoras y listProyectos con la infromación de la API.
     

     */
    func API01(){
        let id = self.voluntarioRecibido?.idVol
        var apiAnswer = ""
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasproyecto?idVol=\(id!)") else{
                return
        }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                        if let data = data{
                            do{
                                let decoder = JSONDecoder()
                                let tasks = try decoder.decode([horasProyecto].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        self.listHoras.append(i.Horas)
                                        self.listProyectos.append(i.Proyecto)
                                        self.apellido = i.Apellido
                                        self.nombre = i.Nombre

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
        return
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProyectos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hrsTable.dequeueReusableCell(withIdentifier: "hrsData") as! HrsDataTableViewCell

        let proyecto = listProyectos[indexPath.row]
        let hora = listHoras[indexPath.row]

        cell.lbFecha.text = proyecto
        cell.lbHoraSalida.text = hora

        return cell
    }
    


}

