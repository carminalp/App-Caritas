//
//  PerfilViewController.swift
//  appCaritasMty
//
//  Created by Andrés Ramírez on 11/10/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var pieChart: JPieChart!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbHorasV: UILabel!
    @IBOutlet weak var lbHorasP: UILabel!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombre = defaults.string(forKey: "nombreVol")
        lbNombre.text = nombre!
        API()
        API2()
        let hV = defaults.integer(forKey: "hValidas")
        let hP = defaults.integer(forKey: "hPend")
        lbHorasV.text = String(hV)
        lbHorasP.text = String(hP)
        
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: CGFloat(hV), colors: [UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 1.0), UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 0.5)]),
            JPieChartDataSet(percent: CGFloat(hP), colors: [UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 1.0),UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 0.5)])
         ])
         pieChart.lineWidth = 0.85
    }
    
    func API() -> String{
        let idVolun = defaults.integer(forKey: "idVol")
        var apiAnswer = ""
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/volHoras?idVol=\(idVolun)") else{
                return apiAnswer
            }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                
                let decoder = JSONDecoder()
                        if let data = data{
                            do{
                                let tasks = try decoder.decode([HorasR].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        // Agregar segue a la vista de voluntario
                                        apiAnswer = "valid"
                                        self.defaults.setValue(i.HorasVol, forKey: "hValidas")
                                    }
                                }else{
                                    // Ventana emergente usuario inválido
                                    apiAnswer = "invalid"
                                    print("----- HORAS NO ENCONTRADAS -----")
                                }
                            }catch{
                                print(error)
                            }
                        }
                group.leave()
            }
            task.resume()

        group.wait()
        return apiAnswer
    }
    func API2() -> String{
        let idVolun = defaults.integer(forKey: "idVol")
        var apiAnswer = ""
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/volHorasPend?idVol=\(idVolun)") else{
                return apiAnswer
            }
            
            let group = DispatchGroup()
            group.enter()
        
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                
                let decoder = JSONDecoder()
                        if let data = data{
                            do{
                                let tasks = try decoder.decode([HorasR].self, from: data)
                                if (!tasks.isEmpty){
                                    tasks.forEach{ i in
                                        // Agregar segue a la vista de voluntario
                                        apiAnswer = "valid"
                                        self.defaults.setValue(i.HorasVol, forKey: "hPend")
                                    }
                                }else{
                                    // Ventana emergente usuario inválido
                                    apiAnswer = "invalid"
                                    print("----- HORAS NO ENCONTRADAS -----")
                                }
                            }catch{
                                print(error)
                            }
                        }
                group.leave()
            }
            task.resume()

        group.wait()
        return apiAnswer
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
