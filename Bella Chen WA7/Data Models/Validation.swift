//
//  Validation.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import Foundation
import UIKit

class Validation {
    static let defaults = UserDefaults.standard
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    static func showErrorAlert(_ view: UIViewController, _ text: String) {
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        view.present(alert, animated: true)
    }
}

