//
//  SignUpView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 07/09/23.
//

import SwiftUI

struct SignUpView: View {
   
    @ObservedObject private var signupVM = SignupViewModel()
    @FocusState private var userNameFocused: Field?
    @StateObject var router = Router.shared
    var body: some View {
        NavigationStack(path: $router.path){
            ZStack{
                Color.gray.opacity(0.4).ignoresSafeArea()
                VStack{
                    Spacer()
                    Text(strings.SIGNUP_BUTTON_ON_LOGIN).bold().font(.largeTitle)
                    AuthTextField(hintText: strings.EMAIL, bindingText: $signupVM.email)
                    SecureField(strings.PASSWORD,text: $signupVM.password).onSubmit {
                    }
                    .padding()
                    
                    .autocorrectionDisabled(true)
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.4)))
                    .padding()
                    .focused($userNameFocused, equals: .password)
                    
                    Button {
                        signupVM.signup()
                    } label: {
                        Text(strings.SIGNUP_BUTTON_ON_LOGIN).font(.title2).padding()
                            .frame(width: 320)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(30)
                    }.padding().alert(isPresented: $signupVM.showAlert) {
                        Alert(title: Text("Username must be greater than 3 characters"))
                    }
                    Button {
                        print(router.path)
                        self.router.path.removeLast()
                    } label: {
                        Text(strings.LOGIN_TITLE).font(.title2).padding()
                        
                            .frame(width: 320)
                        
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.7))
                            .cornerRadius(30)
                    }
                    Text(strings.SIGN_IN_VIA_MOBILE).padding(.vertical).foregroundColor(.gray).onTapGesture {
                        router.path.append("SignInViaMobile")
                    }
                    
                    
                    
                    Spacer()
                    
                }.padding()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action: {
                        print(router.path)
                        self.router.path.removeLast()
                    }, label: {
                        Image(systemName:imageStrings.BACK_BUTTON).imageScale(.large).foregroundColor(.black)
                    })
                    )
                
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        SignUpView()
    }
}

struct AuthTextField: View {
    var hintText : String
    var bindingText : Binding<String>
    @FocusState var userNameFocused: Field?
    var body: some View {
        TextField(hintText,text: bindingText).onSubmit {
        }
        .padding()
        .autocorrectionDisabled(true)
        .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.4)))
        .padding()
        .focused($userNameFocused, equals: .username)
    }
}
