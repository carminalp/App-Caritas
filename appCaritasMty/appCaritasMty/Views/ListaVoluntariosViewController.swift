//
//  ListaVoluntariosViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 08/10/22.
//

import UIKit

class ListaVoluntariosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaVoluntarios: UITableView!
    @IBOutlet weak var lbNombre: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    var voluntarios = [String] ()
    var proyectos = [String] ()
    var Fecha = [String] ()
    var Hora = [String] ()
    
    var backButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API()
        
        let nombreA = defaults.string(forKey: "nombreAd")
        lbNombre.text = "Hola, " + nombreA!

        
        backButton.title = ""
        backButton.isEnabled = false
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tablaVoluntarios.delegate = self
        tablaVoluntarios.dataSource = self
        configureItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voluntarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaVoluntarios.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let voluntario = voluntarios[indexPath.row]
        cell.lbNombre.text = voluntario
                
        let proyecto = proyectos[indexPath.row]
        cell.lbTituloProyecto.text = proyecto
                
        let fecha = Fecha[indexPath.row]
        cell.lbFechaInicio.text = fecha
                
        let hora = Hora[indexPath.row]
        cell.lbHrsAcumuladas.text = hora
        
       //cell.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        return cell
    }
    
    private func configureItems(){
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: nil
        )
        
    }
    
    @IBAction func btnCerrarSesion(_ sender: UIButton) {
        showAlert(title: "Cerrar sesión", message: "¿Estás seguro que deseas cerrar sesión?", handlerAceptar: { action in
            self.defaults.removeObject(forKey: "idVol")
            self.defaults.removeObject(forKey: "nombreVol")
            self.defaults.removeObject(forKey: "idAdmin")
            self.defaults.removeObject(forKey: "nombreAd")
            self.defaults.removeObject(forKey: "idProyecto")
            self.defaults.removeObject(forKey: "idVolCheck")
            self.defaults.removeObject(forKey: "idProyectoCheck")
            self.defaults.removeObject(forKey: "hValidas")
            self.defaults.removeObject(forKey: "hPend")
            self.navigationController?.popToRootViewController(animated: true)
        }, handlerCancelar: {actionCanel in
            print("Action cancel called")
        })
    }
    
    func API(){
                
                guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/getNyP") else{
                        return
                    }
                    
                    let group = DispatchGroup()
                    group.enter()
                
                    let task = URLSession.shared.dataTask(with: url){
                        data, response, error in
                        
                        
                        let decoder = JSONDecoder()
                                if let data = data{
                                    do{
                                        let tasks = try decoder.decode([NyP].self, from: data)
                                        if (!tasks.isEmpty){
                                            tasks.forEach{ i in
                                                print("-------- INFO ---------")
                                                self.proyectos.append(i.Proyecto)
                                                self.Fecha.append(i.Mes + " " + i.Dia)
                                                self.Hora.append(i.HoraEntrada + " - " + i.HoraSalida + " hrs")
                                                self.voluntarios.append(i.Nombre + " " + i.Apellido)
                                            }
                                        }else{
                                            print("----- INFO NO ENCONTRADA -----")
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

    
}



