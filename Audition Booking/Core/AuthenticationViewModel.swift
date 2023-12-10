//
//  AuthenticationViewModel.swift
//  Audition Booking
//
//  Created by Shivam Chawla on 08/08/23.
//


import SwiftUI
import GoogleSignIn
import AuthenticationServices

class UserAuthModel:NSObject, ObservableObject {
    
    @Published var idToken: String = ""
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @StateObject private var loginViewModel = LoginViewModel()

    @Published var loading : Bool = false
    private var api = APIManager()

//    init(){
//        check()
//    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
            self.idToken = user.idToken?.tokenString ?? ""
            
            
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(){
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController ) { user, error in
            guard error == nil else { return }
//            guard let user = user else { return }
//            print(user?.user.idToken?.tokenString ?? "")
//            print(user?.user.profile?.name)
//            self.checkStatus()
            self.login(token: user?.user.idToken?.tokenString ?? "")
//            self.isLoggedIn = true
            
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
    
    func login(token : String) {
        self.loading = true

     
        // setting up request headers
        api.requestHttpHeaders.setContentType(contentType: .applicationJSON)
        
        // setting up body parameters of the request
        api.httpBodyParameters.add(value: token, forKey: "id_token")
        api.httpBodyParameters.add(value: UserDefaults.standard.string(forKey: "fcmToken")! , forKey: "fcm_token")

        // generating URL
        if let url = URLManager().getURLFor(endpoint: .google_login) {
            // initiating an API call
            api.makeRequest(toURL: url, withHttpMethod: .post) { result in
                // checking if response Code
                // 200 : Continue with the flow
                // 404 : Handel 404 seperately
                // 419 : Handel JWT error seperately
                // 400 - 499: Display Unable to Reach to the server
                // 500 - 599: There was an error logging in
                
                print(self.api.requestHttpHeaders.allValues())
                if result.response?.httpStatusCode == 200 {
                    HapticManager.instance.notification(type: .success)
                    
                    if let data = result.data {
                        do {
                            //decoding the JSON Response to Swift Model
                            let decoder = JSONDecoder()
                            let loginResponse = try decoder.decode(LoginModel.self, from: data)
                            
                            // Function encodes and saves the data in UserDefaults
                            print(loginResponse)
                            saveUserToUserDefaults(loginResponse.user)
                            
                            // this user default is used to prevent the walkthrough screen
                            UserDefaults.standard.set(true, forKey: "WalkthroughScreenViewed")
                            UserDefaults.standard.set(loginResponse.token, forKey: "token")
                            
                            // Login to App
                            DispatchQueue.main.async {
                                self.isLoggedIn = true
                                self.loading = false

                            }
                            
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                    
                //Handeling 404 Error
                }else if result.response?.httpStatusCode == 404 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                        
                    }
                    
                //Handeling 400 - 499 Errors
                } else if 400...499 ~= result.response?.httpStatusCode ?? 0 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                       
                    }
                    
                // Handeling Server errors
                } else if 500...599 ~= result.response?.httpStatusCode ?? 0 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                      
                    }
                }
            }
        } else {
            debugPrint("Error Generating URL")
        }
        
    }
    func appleLogin(token : String , name : String , email : String) {
        
        self.loading = true
        // setting up request headers
        api.requestHttpHeaders.setContentType(contentType: .applicationJSON)
        
        // setting up body parameters of the request
        api.httpBodyParameters.add(value: token, forKey: "token")
        api.httpBodyParameters.add(value: UserDefaults.standard.string(forKey: "fcmToken")! , forKey: "fcm_token")
        api.httpBodyParameters.add(value: email, forKey: "email")
        api.httpBodyParameters.add(value: name, forKey: "name")
        
        

        // generating URL
        if let url = URLManager().getURLFor(endpoint: .apple_login) {
            // initiating an API call
            api.makeRequest(toURL: url, withHttpMethod: .post) { result in
                // checking if response Code
                // 200 : Continue with the flow
                // 404 : Handel 404 seperately
                // 419 : Handel JWT error seperately
                // 400 - 499: Display Unable to Reach to the server
                // 500 - 599: There was an error logging in
                
                print(self.api.requestHttpHeaders.allValues())
                
                print(result.response?.httpStatusCode ?? 0)
                if result.response?.httpStatusCode == 200 {
                    HapticManager.instance.notification(type: .success)
                    
                    if let data = result.data {
                        do {
                            //decoding the JSON Response to Swift Model
                            let decoder = JSONDecoder()
                            let loginResponse = try decoder.decode(LoginModel.self, from: data)
                            
                            // Function encodes and saves the data in UserDefaults
                            print(loginResponse)
                            saveUserToUserDefaults(loginResponse.user)
                            
                            // this user default is used to prevent the walkthrough screen
                            UserDefaults.standard.set(true, forKey: "WalkthroughScreenViewed")
                            UserDefaults.standard.set(loginResponse.token, forKey: "token")
                            
                            // Login to App
                            DispatchQueue.main.async {
                                self.isLoggedIn = true
                                self.loading = false

                            }
                            
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                    
                //Handeling 404 Error
                }else if result.response?.httpStatusCode == 404 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                        
                    }
                    
                //Handeling 400 - 499 Errors
                } else if 400...499 ~= result.response?.httpStatusCode ?? 0 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                       
                    }
                    
                // Handeling Server errors
                } else if 500...599 ~= result.response?.httpStatusCode ?? 0 {
                    DispatchQueue.main.async {
                        HapticManager.instance.notification(type: .error)
                      
                    }
                }
            }
        } else {
            debugPrint("Error Generating URL")
        }
        
    }


}
extension UserAuthModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.appleLogin(token: "\(appleIDCredential.user)", name: appleIDCredential.fullName?.givenName ?? "", email: appleIDCredential.email ?? "")
        }
    }
    
    private func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
    
    func performAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}
