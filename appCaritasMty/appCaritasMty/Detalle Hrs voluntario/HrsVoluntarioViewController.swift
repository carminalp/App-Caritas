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
    
    let fechas = ["09/08/2022", "10/08/2022", "11/08/2022", "09/08/2022", "10/08/2022", "11/08/2022","09/08/2022", "10/08/2022", "11/08/2022", "09/08/2022", "10/08/2022", "11/08/2022"]
    let horasEntrada = ["9:00 AM", "10:00 AM", "8:00 AM","9:00 AM", "10:00 AM", "8:00 AM","9:00 AM", "10:00 AM", "8:00 AM","9:00 AM", "10:00 AM", "8:00 AM"]
    let horasSalida = ["13:00 PM", "14:00 PM", "12:00 PM","13:00 PM", "14:00 PM", "12:00 PM","13:00 PM", "14:00 PM", "12:00 PM","13:00 PM", "14:00 PM", "12:00 PM"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vistaTabla.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
        hrsTable.delegate = self
        hrsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fechas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hrsTable.dequeueReusableCell(withIdentifier: "hrsData") as! HrsDataTableViewCell
        
        let fecha = fechas[indexPath.row]
        let horaEntrada = horasEntrada[indexPath.row]
        let horaSalida = horasSalida[indexPath.row]
        
        
        cell.lbFecha.text = fecha
        cell.lbHoraEntrada.text = horaEntrada
        cell.lbHoraSalida.text = horaSalida
        
        
        
        
        
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
