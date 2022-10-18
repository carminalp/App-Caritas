//
//  CustomTableViewCell.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 08/10/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var vistaVoluntario: UIView!
    
    @IBOutlet weak var vistaVoluntarioRoundC: UIView!
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbTituloProyecto: UILabel!
    @IBOutlet weak var lbFechaInicio: UILabel!
    @IBOutlet weak var lbHrsAcumuladas: UILabel!
    @IBOutlet weak var btnValidar: UIButton!
    @IBOutlet weak var btnNoValidar1: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaVoluntarioRoundC.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
        btnNoValidar1.layer.borderWidth = 1
        btnNoValidar1.layer.borderColor = UIColor(rgb: 0xFFAF80).cgColor
        btnNoValidar1.layer.backgroundColor = UIColor(rgb: 0xFFAF80).cgColor
        btnNoValidar1.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }

}


