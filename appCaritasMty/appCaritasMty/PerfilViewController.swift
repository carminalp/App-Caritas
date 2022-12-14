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
    @IBOutlet weak var ivPerfil: UIImageView!
    
    
    @IBOutlet weak var vistaGrafica: UIView!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        vistaGrafica.roundCorners(corners: [.topLeft, .topRight, .bottomRight, .bottomLeft], radius: 10)
        
        ivPerfil.layer.cornerRadius = 150.0/2.0
        ivPerfil.layer.borderWidth = 6
        ivPerfil.layer.borderColor = UIColor(red: 255/255, green: 175/255, blue: 128/255, alpha: 1).cgColor
        let nombre = defaults.string(forKey: "nombreVol")
        lbNombre.text = nombre!
        let idVol = defaults.integer(forKey: "idVol")
        API(idVol: idVol)
        
        API2(idVol: idVol)
        let hV = defaults.integer(forKey: "hValidas")
        let hP = defaults.integer(forKey: "hPend")
        lbHorasV.text = String(hV)
        lbHorasP.text = String(hP)
        
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: CGFloat(hP), colors: [UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 1.0), UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 0.5)]),
            JPieChartDataSet(percent: CGFloat(hV), colors: [UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 1.0),UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 0.5)])
         ])
         pieChart.lineWidth = 0.85
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let idVol = defaults.integer(forKey: "idVol")
        self.defaults.removeObject(forKey: "hValidas")
        self.defaults.removeObject(forKey: "hPend")
        API(idVol: idVol)
        API2(idVol: idVol)
        let hV = defaults.integer(forKey: "hValidas")
        let hP = defaults.integer(forKey: "hPend")
        lbHorasV.text = String(hV)
        lbHorasP.text = String(hP)
        
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: CGFloat(hP), colors: [UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 1.0), UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 0.5)]),
            JPieChartDataSet(percent: CGFloat(hV), colors: [UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 1.0),UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 0.5)])
         ])
         pieChart.lineWidth = 0.85
    }
    
    func API(idVol: Int){
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/volHoras?idVol=\(idVol)") else{
                return
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
                                        self.defaults.setValue(i.HorasVol, forKey: "hValidas")
                                    }
                                }else{
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
        return
    }
    
    func API2(idVol: Int){
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/volHorasPend?idVol=\(idVol)") else{
                return
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
                                        
                                        self.defaults.setValue(i.HorasVol, forKey: "hPend")
                                    }
                                }else{
                                    
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
        return
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func cerrarSesion(_ sender: UIButton) {
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
}
