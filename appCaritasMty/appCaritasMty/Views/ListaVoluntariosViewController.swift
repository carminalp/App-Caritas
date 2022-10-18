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
    
    var idReg = [Int] ()
    var idVo = [Int] ()
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
    override func viewWillAppear(_ animated: Bool) {
        idReg = [Int] ()
        idVo = [Int] ()
        voluntarios = [String] ()
        proyectos = [String] ()
        Fecha = [String] ()
        Hora = [String] ()
        API()
        let nombreA = defaults.string(forKey: "nombreAd")
        tablaVoluntarios.delegate = self
        tablaVoluntarios.dataSource = self
        tablaVoluntarios.reloadData()
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
        
        cell.btnValidar.tag = indexPath.row
        cell.btnValidar.addTarget(self, action: #selector(addtoButton), for: .touchUpInside)
        
        cell.btnNoValidar1.tag = indexPath.row
        cell.btnNoValidar1.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
        
       //cell.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        return cell
    }
    
    @objc func addtoButton(sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let idVoluntariado = idReg[indexPath.row]
        let idVol = idVo[indexPath.row]
        API01(idR: idVoluntariado, idV: idVol)
        voluntarios.remove(at: indexPath.row)
        tablaVoluntarios.deleteRows(at: [indexPath], with: .fade)
    }
    
    @objc func deleteButton(sender:UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let idVoluntariado1 = idReg[indexPath.row]
        let idVol1 = idVo[indexPath.row]
        API02(idR: idVoluntariado1, idV: idVol1)
        voluntarios.remove(at: indexPath.row)
        tablaVoluntarios.deleteRows(at: [indexPath], with: .fade)
        
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
                                                self.idReg.append(i.idVoluntariado)
                                                self.idVo.append(i.idVol)
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
    
    func API01(idR: Int, idV: Int){
        //Usar los arreglos con los registros de los ids
        let idVoluntariado = idR
        let idVol = idV
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/horas/validas?idVoluntariado=\(idVoluntariado)&idVol=\(idVol)") else{
                return
            }
 
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("No murio:  \(response)")
            }catch{
                print(error)
            }
        }
        task.resume()
        return
    }
    
    func API02(idR: Int, idV: Int){
        //Usar los arreglos con los registros de los ids
        let idVoluntariado = idR
        let idVol = idV
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/borrarHoras?idVoluntariado=\(idVoluntariado)&idVol=\(idVol)") else{
                return
            }
 
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("No murio:  \(response)")
            }catch{
                print(error)
            }
        }
        task.resume()
        return
    }
    
    
    
}



