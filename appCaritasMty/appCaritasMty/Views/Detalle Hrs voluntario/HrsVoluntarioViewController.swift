//
//  HrsVoluntarioViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 09/10/22.
//

import UIKit

class HrsVoluntarioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var vistaTabla: UIView!
    
    @IBOutlet weak var hrsTable: UITableView!
    
    @IBOutlet weak var textoPrueba: UILabel!
    
    
    var voluntarioRecibido: horasValidadasVoluntario?
    var backButton = UIBarButtonItem()
    
    var listHorasProyecto = [horasProyecto]()
    
    
//    let fechas = ["Banco de alimentos", "Ducha-T", "Banco de dinero", "Ropa", "Bañatec"]
//    let horasAcumuladas = ["120", "100", "300","500", "20"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.title = "Back"
        backButton.isEnabled = true
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        vistaTabla.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        hrsTable.delegate = self
        hrsTable.dataSource = self
        
        if (voluntarioRecibido != nil){
            
            textoPrueba.text = voluntarioRecibido!.Nombre
            API(idVoluntario: voluntarioRecibido!.idVol)
            
        }
        
    }
    
    func API(idVoluntario: Int) {
        var listHorasProyecto2 = [horasProyecto]()
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasproyecto?idVol=\(voluntarioRecibido?.idVol)") else {return}
        
        let group = DispatchGroup()
        group.enter()
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil || data == nil {
                print("error")
            }
            else{
                if let responseText = String.init(data: data!, encoding: .ascii){
                    let jsonData = responseText.data(using: .utf8)!
                    listHorasProyecto2 = try! JSONDecoder().decode([horasProyecto].self, from: jsonData)
                    
                    self.listHorasProyecto = listHorasProyecto2
                    
                    
                }
            }
        })
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHorasProyecto.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hrsTable.dequeueReusableCell(withIdentifier: "hrsData") as! HrsDataTableViewCell

        let proyectos = listHorasProyecto[indexPath.row]
        let proyecto = proyectos.Proyecto
        let hora = proyectos.Horas


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

