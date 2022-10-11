//
//  PerfilViewController.swift
//  appCaritasMty
//
//  Created by Andrés Ramírez on 11/10/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var pieChart: JPieChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.addChartData(data: [
             JPieChartDataSet(percent: 20, colors: [UIColor.purpleishBlueThree,UIColor.brightLilac]),
             JPieChartDataSet(percent: 20, colors: [UIColor.darkishPink,UIColor.lightSalmon]),
             JPieChartDataSet(percent: 20, colors: [UIColor.dustyOrange,UIColor.lightMustard]),
             JPieChartDataSet(percent: 0.5, colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
         ])
         pieChart.lineWidth = 0.85
        // Do any additional setup after loading the view.
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
