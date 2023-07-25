//
//  Extentions + UIViewController.swift
//  MVVM project
//
//  Created by 2B on 25/07/2023.
//

import Foundation
import UIKit

extension UIViewController{
    func showALert(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
