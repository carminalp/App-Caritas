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
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombre = defaults.string(forKey: "nombreVol")
        lbNombre.text = nombre!
        pieChart.addChartData(data: [
             JPieChartDataSet(percent: 20, colors: [UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 1.0),UIColor(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 0.5)]),
             JPieChartDataSet(percent: 20, colors: [UIColor(red: 255/255.0, green: 175/255, blue: 128/255, alpha: 1.0), UIColor(red: 255/255.0, green: 175/255, blue: 128/255, alpha: 0.5)]),
             JPieChartDataSet(percent: 20, colors: [UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 1.0), UIColor(red: 21/255.0, green: 57/255, blue: 90/255, alpha: 0.5)]),
             JPieChartDataSet(percent: 0.5, colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
         ])
         pieChart.lineWidth = 0.85
        // Do any additional setup after loading the view.
        //(red: 69/255.0, green: 154/255, blue: 164/255, alpha: 1.0)
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
