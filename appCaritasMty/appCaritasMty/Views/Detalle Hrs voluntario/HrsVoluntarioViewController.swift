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
     
     Lo que hace la función de API01 es obtener las horas por proyecto del voluntario de acuerdo al id que tiene el voluntario.
     
     El id se envía de la pantalla de voluntarios hacia la de hrsVoluntario y con él se hace la llamada a la API.
     
     Si hay información, entonces decodifica los datos de tipo horasProyecto y guarda individualmente los nombres y horas de los proyectos en diferentes arrays.
     
     Se guardó la información en arrays diferentes de tipo string y no de tipo horasProyecto para poder tener más fácil acceso a la infroamción necesaria que se debe mostrar.
     
     Si hay algún error, se imprimen los errores en la terminal.
     
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
                                        print("-------- Jaló ---------")
                                        self.listHoras.append(i.Horas)
                                        self.listProyectos.append(i.Proyecto)
                                        self.apellido = i.Apellido
                                        self.nombre = i.Nombre
                                        
                                        print(i.Horas)
                                        print(i.Proyecto)
                                        print(i.Nombre)
                                        print(i.Apellido)
                                        
                                        // Agregar segue a la vista de voluntario
                                        apiAnswer = "valid"
                                    }
                                }else{
                                    // Ventana emergente usuario inválido
                                    apiAnswer = "invalid"
                                    print("----- ERROR -----")
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






/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

