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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaVoluntarioRoundC.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }

}


