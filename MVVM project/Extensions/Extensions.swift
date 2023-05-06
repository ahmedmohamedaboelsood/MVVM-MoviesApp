//
//  Extensions.swift
//  MVVM project
//
//  Created by 2B on 05/05/2023.
//

import Foundation
import UIKit

//MARK: - UIView

extension UIView{
    
    func round(_ radius : CGFloat = 10){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    func borders(color: UIColor , width : CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
