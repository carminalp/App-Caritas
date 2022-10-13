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
    
    let voluntarios = ["Geraldine Torres", "Cristina Hernández", "Carmina López", "Eduardo Hernández", "Andrés Ramírez"]
    
    var backButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nombreA = defaults.string(forKey: "nombreAd")
        lbNombre.text = "Hola, " + nombreA!
        
        backButton.title = ""
        backButton.isEnabled = false
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tablaVoluntarios.delegate = self
        tablaVoluntarios.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voluntarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaVoluntarios.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let voluntario = voluntarios[indexPath.row]
        cell.lbNombre.text = voluntario
        
       //cell.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        
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
