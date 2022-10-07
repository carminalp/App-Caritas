//
//  ProjectCollectionViewCell.swift
//  appCaritasMty
//
//  Created by Alumno on 04/10/22.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    static let identifier = "projectCell"
    
    @IBOutlet weak var lbProjectName: UILabel!
    @IBOutlet weak var lbProjectDesc: UILabel!
    @IBOutlet weak var imgProjectImg: UIImageView!
    
    @IBOutlet weak var vwContentCell: UIView!
    func setupCell(name: String, desc: String, image: UIImage){
        lbProjectName.text = name
        lbProjectDesc.text = desc
        imgProjectImg.image = image
        vwContentCell.layer.cornerRadius = 8
        
    }
    
}
