//
//  utils.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 14/09/23.
//

import Foundation


func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword (_ password: String) -> Bool {
    if password.count < 6 {
        return false
    }
    return true
}

enum Field {
    case username
    case password
    case email
}
