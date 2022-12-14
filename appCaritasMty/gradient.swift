//
//  gradient.swift
//  appCaritasMty
//
//  Created by Eduardo Jair Hernández Gómez on 06/10/22.
//

import Foundation
import UIKit

extension UIView{
    public func setTwoGradient(colorOne: UIColor, colorTwo: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint (x: 0.5, y: 1.5)
        
        layer.insertSublayer (gradientLayer, at: 0)
    }
}
