//
//  HrsDataTableViewCell.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 09/10/22.
//

import UIKit

class HrsDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var celdaView: UIView!
    
    @IBOutlet weak var lbFecha: UILabel!
    @IBOutlet weak var lbHoraEntrada: UILabel!
    @IBOutlet weak var lbHoraSalida: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //celdaView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
