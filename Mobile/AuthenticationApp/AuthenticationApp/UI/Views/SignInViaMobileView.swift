//
//  SignInViaMobileView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 18/09/23.
//

import SwiftUI

struct SignInViaMobileView: View {
    @StateObject private var signInviaMobileVM : SignInViaMobile = SignInViaMobile()
    @StateObject var router = Router.shared
    var body: some View {
         return NavigationStack(path: $router.path) {
            ZStack{
                Color.gray.opacity(0.4).ignoresSafeArea()
                VStack{
                    Spacer()
                    Text(strings.SIGN_IN).bold().font(.largeTitle)
                    HStack{
                        Button {
                            signInviaMobileVM.toggleAlert(val: true)
                        } label: {
                            Text("\(signInviaMobileVM.selectedCountryFlag) \(signInviaMobileVM.selectedCountryCode)").padding(8)
                            
                                .background(.black, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .foregroundColor(.white)
                        }.sheet(isPresented: $signInviaMobileVM.showSheet) {
                            NavigationView {
                                List(signInviaMobileVM.filteredCountries){ country in
                                
                                    HStack {
                                        Text(country.flag)
                                        Text(country.name)
                                            .font(.headline)
                                        Spacer()
                                        Text(country.dialCode)
                                            .foregroundColor(.secondary)
                                    }.onTapGesture {
                                        changeSelectedCountryDetails(country: country)
                                    }
                                }.listStyle(.plain).searchable(text: $signInviaMobileVM.searchCountry, prompt: "Your Country")
                                
                            }.presentationDetents([.medium,.large])
                        }
                        AuthTextField(hintText: strings.PHONE_NUMBER, bindingText: $signInviaMobileVM.phoneNumber)
                    }.padding(.horizontal)
                    Button {
                        self.router.path.append("VerifyOTPView")
                    } label: {
                        Text(strings.GET_OTP).font(.title2).padding()
                            .frame(width: 320)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(30)
                    }.padding().alert(isPresented: $signInviaMobileVM.showAlert) {
                        Alert(title: Text("Invalid phone number"))
                    }
                    
                    Text(strings.SIGN_IN_VIA_EMAIL).padding(.vertical).foregroundColor(.gray).onTapGesture {
                        print(router.path)
                        router.path.removeLast()
                    }
                    Spacer()
                    
                }.padding()
            }.navigationBarBackButtonHidden(true)
                 .navigationBarItems(leading: Button(action: {
                             self.router.path.removeLast()
                         }, label: {
                             Image(systemName:imageStrings.BACK_BUTTON).imageScale(.large).foregroundColor(.black)
                         })
                         ).navigationDestination(for: String.self) { view in
                    switch (view) {
                    case screenNames.SIGNUP:
                        SignUpView()
                    case screenNames.RESET_PASSWORD:
                        ResetPasswordView()
                    case screenNames.SIGN_IN_MOBILE:
                        SignInViaMobileView()
                    case screenNames.LOGIN:
                        LoginView()
                    case screenNames.VERIFY_OTP:
                        OTPView()
                    default :
                        Text("No View")
            }
           
                 }.ignoresSafeArea(.keyboard)
                }
    }
    
    func changeSelectedCountryDetails(country: Country) {
        signInviaMobileVM.toggleAlert(val: false)
        self.signInviaMobileVM.selectedCountryCode = country.dialCode
        self.signInviaMobileVM.selectedCountryFlag = country.flag
        self.signInviaMobileVM.searchCountry = ""
        
    }
}

struct SignInViaMobileView_Previews: PreviewProvider {
    static var previews: some View {
        SignInViaMobileView()
    }
}




