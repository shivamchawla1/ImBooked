//
//  ContentView.swift
//  Audition Booking
//
//  Created by Apoorv Verma on 02/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            NavigationView {
                if UserDefaults.standard.string(forKey: "token") != nil {
                    TabsView()
                } else if UserDefaults.standard.bool(forKey: "isWaitingOTP") ||
                            (UserDefaults.standard.bool(forKey: "isForgetPassword") && !UserDefaults.standard.bool(forKey: "isForgetOTPVerified")) {
                    if #available(iOS 15.0, *) {
                        OtpVerifyView()
                    } else {
                        // Fallback on earlier versions
                    }
                } else if UserDefaults.standard.bool(forKey: "isForgetPassword") && UserDefaults.standard.bool(forKey: "isForgetOTPVerified") {
                    ForgotPasswordView()
                } else if UserDefaults.standard.bool(forKey: "WalkthroughScreenViewed") {
                    LoginView()
                } else {
                    OnboardingView()
                }
            }
            
//            .background(Color.accentColor)
        }
        else{
            Launch()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.isActive = true
                        
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
