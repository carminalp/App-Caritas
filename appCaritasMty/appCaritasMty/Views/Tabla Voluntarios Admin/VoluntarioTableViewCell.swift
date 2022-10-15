//
//  VoluntarioTableViewCell.swift
//  appCaritasMty
//
//  Created by CLP on 12/10/22.
//

import UIKit

class VoluntarioTableViewCell: UITableViewCell {

    @IBOutlet weak var vistaVoluntario: UIView!
    
    @IBOutlet weak var vistaVoluntarioRoundC: UIView!
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbCorreo: UILabel!
    @IBOutlet weak var lbHoras: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
