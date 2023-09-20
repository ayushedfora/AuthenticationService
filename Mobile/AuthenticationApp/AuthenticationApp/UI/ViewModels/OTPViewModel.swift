//
//  OTPViewModel.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 20/09/23.
//

import Foundation

class OTPViewModel: ObservableObject {
    @Published var isAlertShown = false
    @Published var timeElapsed = 0.0
    @Published var timeLeft = 30.0
    @Published var alertCount = 0
    @Published var showResendOTPText = false
    @Published var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
}
