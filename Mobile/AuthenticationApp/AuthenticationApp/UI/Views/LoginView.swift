//
//  SignUpView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 07/09/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginVM = LoginViewModel()
    @FocusState private var userNameFocused: Field?
    @StateObject var router = Router.shared
    var body: some View {
        
        NavigationStack(path: $router.path) {
            ZStack{
                Color.gray.opacity(0.4).ignoresSafeArea()
                VStack(alignment: .center){
                    Spacer()
                    Text(strings.LOGIN_TITLE).bold().font(.largeTitle)
                    TextField(strings.EMAIL,text: $loginVM.emailId).onSubmit {
                    }
                    .padding()
                    .autocorrectionDisabled(true)
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.4)))
                    .padding()
                    .focused($userNameFocused, equals: .username)
                    SecureField(strings.PASSWORD,text: $loginVM.password).onSubmit {
                    }
                    .padding()
                    
                    .autocorrectionDisabled(true)
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.4)))
                    .padding()
                    .focused($userNameFocused, equals: .password)
                   
                    AuthButton(onPressButton: loginVM.loginUser, isAlertPresented: $loginVM.showAlert, alertMessage: loginVM.alertMessage, foregroundColor: .white, backgroundColor: .black, text: strings.LOGIN_BUTTON)
                    AuthButton(onPressButton: navigateToSignUp, isAlertPresented: $loginVM.showAlert, alertMessage: loginVM.alertMessage, foregroundColor: .white, backgroundColor: .gray, text: strings.SIGNUP_BUTTON_ON_LOGIN)
                    Text(strings.FORGOT_PASSWORD).padding(.vertical).foregroundColor(.gray).onTapGesture {
                        router.path.append("ResetPasswordView")
                    }
                    Spacer()
                    
                }.navigationDestination(for: String.self) { view in
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
                }
                
            }
            
        }
       
    }
    
    func navigateToSignUp() {
        router.path.append("SignupView")
        print(router.path)
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct AuthButton: View {
    var onPressButton : () -> ()
    var isAlertPresented: Binding<Bool>
    var alertMessage: String
    var foregroundColor: Color
    var backgroundColor: Color
    var text: String
    var body: some View {
        Button {
            onPressButton()
        } label: {
            Text(text).font(.title2).padding()
                .frame(width: 320)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .cornerRadius(30)
        }.padding(.top).alert(isPresented: isAlertPresented) {
            Alert(title: Text(alertMessage))
        }
    }
}
