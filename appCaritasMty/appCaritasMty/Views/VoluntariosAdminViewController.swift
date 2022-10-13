//
//  VoluntariosAdminViewController.swift
//  appCaritasMty
//
//  Created by CLP on 12/10/22.
//

import UIKit

class VoluntariosAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tablaVoluntarios: UITableView!
    
    var voluntarios = ["Geraldine Torres", "Cristina Hernández", "Carmina López", "Eduardo Hernández", "Andrés Ramírez","Omar Omar", "Emiliano Borreguito", "Axel Gru", "Brandiuxx Minions", "Ricardo Minions", "Ivan Minions", "Marifer Minion", "Alfonso Minions"]
    
    var sectionTittle = [String]()
    
    var volDict = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectionTittle = Array(Set(voluntarios.compactMap({String($0.prefix(1))})))
        sectionTittle.sort()
        
        for stittle in sectionTittle{
            volDict[stittle]=[String]()
        }
        for voluntario in voluntarios {
            volDict[String(voluntario.prefix(1))]?.append(voluntario)
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volDict[sectionTittle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaVoluntarios.dequeueReusableCell(withIdentifier: "volCell", for: indexPath) as! VoluntarioTableViewCell
        cell.lbNombre?.text = volDict[sectionTittle[indexPath.section]]?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTittle.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTittle
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTittle[section]
    }
}
