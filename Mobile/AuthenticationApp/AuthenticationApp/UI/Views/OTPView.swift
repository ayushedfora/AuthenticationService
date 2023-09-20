//
//  OTPView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 20/09/23.
//

import SwiftUI

struct OTPView: View {
    @StateObject var otpVM = OTPViewModel()
    @StateObject var router = Router.shared
    @State var prevValue  = 0.0
    var body: some View {
        NavigationStack(path: $router.path){
            ZStack{
                Color.gray.opacity(0.4).ignoresSafeArea()
                VStack{
                    ProgressView(value: otpVM.timeElapsed, total: 30.0).padding(32).hidden(otpVM.showResendOTPText).scaleEffect(x: 1, y: 4, anchor: .center).tint(.green).onReceive(otpVM.timer) { input in
                       runOngoingTimer()
                    }
                    Text("Time Left : \(otpVM.timeLeft.formatted()) seconds").font(.headline).hidden(otpVM.showResendOTPText)
                    Spacer()
                    OTPTextFieldView().padding(.horizontal,16)
                    Text("Resend OTP").font(.caption).underline(color: .black).hidden(!otpVM.showResendOTPText).onTapGesture {
                       resetTimerSettings()
                    }.padding(.top)
                    Spacer()
                    AuthButton(onPressButton: {
                        
                    }, isAlertPresented: $otpVM.isAlertShown, alertMessage: "Please enter correct OTP", foregroundColor: .white, backgroundColor: .black, text: "Verify")
                    
                    
                }.alert(isPresented: $otpVM.isAlertShown) {
                    Alert(title: Text("Time is up"))
                }
            }.navigationBarBackButtonHidden(true).navigationTitle("Verify OTP").navigationDestination(for: String.self) { view in
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
    
    func runOngoingTimer() {
        if (otpVM.timeElapsed < 30.0) {
            otpVM.timeElapsed += 0.01
            if floor(prevValue) != floor(otpVM.timeElapsed){
                otpVM.timeLeft -= 1
            }
            prevValue = otpVM.timeElapsed
        }
        if (otpVM.timeElapsed >= 30.0) {
            self.otpVM.timer.upstream.connect().cancel()
            if(otpVM.alertCount == 0){
                otpVM.isAlertShown.toggle()
                otpVM.showResendOTPText.toggle()
            }
            otpVM.alertCount += 1
        }
    }
    
    func resetTimerSettings() {
        otpVM.timeElapsed = 0.0
        otpVM.timeLeft = 30.0
        otpVM.showResendOTPText.toggle()
        otpVM.timer = self.otpVM.timer.upstream.autoconnect()
        otpVM.alertCount = 0
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
