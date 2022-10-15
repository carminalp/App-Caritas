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

        
       //cell.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        return cell
    }
    
    private func configureItems(){
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: nil
        )
        
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
                                            print(self.proyectos)
                                            self.voluntarios.append(i.Nombre)
                                            print(self.voluntarios)
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

    
//    @IBAction func btnCerrarSesion(_ sender: UIButton) {
//        print("SI JALÓ")
//        defaults.removeObject(forKey: "idVol")
//        defaults.removeObject(forKey: "nombreVol")
//        defaults.removeObject(forKey: "idAdmin")
//        defaults.removeObject(forKey: "nombreAd")
//        navigationController?.popToRootViewController(animated: true)
//    }
    
}






/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
