//
//  Audition_BookingApp.swift
//  Audition Booking
//
//  Created by Apoorv Verma on 02/05/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Audition_BookingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userAuth: UserAuthModel =  UserAuthModel()
    
//    init(){
////        UINavigationBar.appearance().backgroundColor = .orange
////        UINavigationBar.appearance().barTintColor = .orange
////        UINavigationBar.appearance().tintColor = .orange
//////        UINavigationBar.appearance().accessibilityIgnoresInvertColors = true     
////        UINavigationBar.appearance().isTranslucent = true
//        
////        UIToolbar.appearance().backgroundColor = .red
//        UIToolbar.appearance().isTranslucent = false
//
//
//    }

    var body: some Scene {
        WindowGroup {
         ContentView()
                .environmentObject(userAuth)

        }
    }
}

class AppDelegate : NSObject , UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.Message_ID"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self

        let config = GIDConfiguration(clientID: "212859177371-3sb9gm89701m4e8dkos0muh6damfcuta.apps.googleusercontent.com")
                
        GIDSignIn.sharedInstance.configuration = config
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions :UNAuthorizationOptions = [.alert , .badge , .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        }else{
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types:  [.alert , .badge , .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
extension AppDelegate : MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
//        let dataDict : [String:String] = ["token" : fcmToken ?? ""]
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")

    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
        return [[.banner,.badge, .sound]]
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)
  }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }

}
