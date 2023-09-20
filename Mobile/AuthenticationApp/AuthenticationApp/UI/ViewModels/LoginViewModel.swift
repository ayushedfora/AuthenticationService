//
//  LoginViewModel.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 07/09/23.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject {
    
    @Published var emailId : String
    @Published var password : String
    @Published var alertMessage = ""
    @Published var showAlert = false;
    @Published var showLoader = false;

    init() {
        self.emailId = ""
        self.password = ""
    }
    
    func setEmailId(emailId: String) {
        self.emailId = emailId
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getEmailId() -> String {
        return self.emailId
    }
    
    func loginUser() {
        if(!isValidEmail(self.emailId)){
            
            self.toggleAlert(alertValue: true, message: "Invalid Email Id")
            return
        }
        if(!isValidPassword(self.password)){
            self.toggleAlert(alertValue: true, message: "Password must be 6 characters")
            return
        }
        
    }
    
    func toggleAlert(alertValue: Bool, message: String) {
        self.showAlert = alertValue
        self.alertMessage = message
    }
    
    func toggleLoader(loaderValue: Bool) {
        
    }
    
    
}
