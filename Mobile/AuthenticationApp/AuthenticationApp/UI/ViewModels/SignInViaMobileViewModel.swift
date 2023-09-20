//
//  SignInViaMobileViewModel.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 18/09/23.
//

import Foundation

class SignInViaMobile : ObservableObject {
    @Published var searchCountry: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedCountryFlag: String = countryList[0].flag
    @Published var selectedCountryCode: String = countryList[0].dialCode
    @Published var showSheet: Bool = false
    @Published var showAlert: Bool = false
    var filteredCountries: [Country] {
           if searchCountry.isEmpty {
               return countryList
           } else {
               return countryList.filter { $0.name.contains(searchCountry) }
           }
       }

    
    func toggleAlert(val: Bool) {
        showSheet = val
    }
    
}
