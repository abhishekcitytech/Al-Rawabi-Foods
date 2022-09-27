//
//  AppDelegate.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/05/22.
//

import UIKit
import CoreData

import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

struct Constants {
    struct conn {
        
        //MARK: - Web Service API URL - UAT
        static let ConnUrl = "https://alrawabi.task2bill.com/index.php/rest/default/V1/"
    }
    
    struct methodname {
        
        //MARK: -  API Services Method Name
        static let apimethod1 = "customerLogin/customerLogin-api"
        static let apimethod2 = "customerDetails/customerDetails-api"
        static let apimethod3 = "uniqueEmailCheck/uniqueEmailCheck-api"
        static let apimethod4 = "customerRegistration/customerRegistration-api"
        static let apimethod5 = "mobileOtpRequest/mobileOtpRequest-api"
        static let apimethod6 = "mobileOtpVerify/mobileOtpVerify-api"
        static let apimethod7 = "homepageMainBanner/homepageMainBanner-api"
        static let apimethod8 = "topdeals/topdeals-api"
        static let apimethod9 = "categoryTree/categoryTree-api"
        static let apimethod10 = "productListCategorySpecific/productListCategorySpecific-api"
        static let apimethod11 = "productDetailsById/productDetailsById-api"
        static let apimethod12 = "wishlistmanagement/wishlistmanagement-api"
        static let apimethod13 = "wishlistcollection/wishlistcollection-api"
        static let apimethod14 = "addreviewratingInterface/addreviewratingInterface-api"
        static let apimethod15 = "allreviewratingInterface/allreviewratingInterface-api"
        static let apimethod16 = "cartAdd/cartAdd-api"
        static let apimethod17 = "cartlistInterface/cartlistInterface-api"
        static let apimethod18 = "cartItemRemove/cartItemRemove-api"
        static let apimethod19 = "cartUpdate/cartUpdate-api"
        static let apimethod20 = "allorders/allorders-api"
        static let apimethod21 = "orderdetail/orderdetail-api"
        static let apimethod22 = "couponlist/couponlist-api"
        static let apimethod23 = "discountcoupon/discountcoupon-api"
        static let apimethod24 = "customerAllAddress/customerAllAddress-api"
        static let apimethod25 = "addaddress/addaddress-api"
        static let apimethod26 = "newArrival/newArrival-api"
        static let apimethod27 = "orderstatusoption/orderstatusoption-api"
        static let apimethod28 = "updateaddress/updateaddress-api"
        static let apimethod29 = "countcartitem/countcartitem-api"
        static let apimethod30 = "deleteaddress/deleteaddress-api"
        static let apimethod31 = "removewishlist/removewishlist-api"
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate
{
    var window: UIWindow?
    var navController: UINavigationController?
    let tabBarController = UITabBarController()
    
    let gcmMessageIDKey = "gcm.message_id"
    
    //FIXME: GLOBAL VARIABLES FOR LOCAL DATABSE CHECKING FOR SUBSCRIPTION PLAN
    //DAILY Set of Variables
    var strSelectedPLAN = ""
    var arrMproductlist = NSMutableArray()
    var arrMDATEWISEPRODUCTPLAN = NSMutableArray()
    
    //WEEKLY Set of Variables
    var arrMDATEWISEPRODUCTPLANWEEKLY = NSMutableArray()
    var arrMproductlistWeekly = NSMutableArray()
    
    //MONTHLY Set of Variables
    var arrMDATEWISEPRODUCTPLANMONTHLY = NSMutableArray()
    var arrMproductlistMonthly = NSMutableArray()
    
    func localarraycreate()
    {
        for x in 0 ..< 5
        {
            let intvalue = x + 1
            let dic1 = NSMutableDictionary()
            dic1.setValue(String(format: "%d", intvalue), forKey: "id")
            dic1.setValue(String(format: "Fruit Cocktail %d", intvalue), forKey: "name")
            dic1.setValue("0", forKey: "qty")
            dic1.setValue("0", forKey: "qtyATA")
            let intprc = intvalue * 5
            dic1.setValue(String(format: "%d", intprc), forKey: "price")
            arrMproductlist.add(dic1)
        }
        print("arrMproductlist",arrMproductlist)
    }
    
    //MARK: -  Appdidfinish launch option method
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        //FIXME: - PUSH FIREBASE SETUP
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        //FIXME: - LANGUAGE SETUP
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "ar")
        print("strLangCode",strLangCode)
        if (strLangCode == "ar")
        {
            UserDefaults.standard.set("ar", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        else if (strLangCode == "en")
        {
            UserDefaults.standard.set("en", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        else{
            UserDefaults.standard.set("en", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        
        //FIXME: - DELAY TIME SPLASH SCREEN
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 2.0))

        let themecolor = UIColor(named: "themecolor")!
        
        localarraycreate()
        
        /*UIFont.familyNames.forEach({ familyName in
         let fontNames = UIFont.fontNames(forFamilyName: familyName)
         print(familyName, fontNames)
         })*/
        
        /*
         "NunitoSans-Regular"
         "NunitoSans-Italic"
         "NunitoSans-ExtraLight"
         "NunitoSans-ExtraLightItalic"
         "NunitoSans-Light"
         "NunitoSans-LightItalic"
         "NunitoSans-SemiBold"
         "NunitoSans-SemiBoldItalic"
         "NunitoSans-Bold"
         "NunitoSans-BoldItalic"
         "NunitoSans-ExtraBold"
         "NunitoSans-ExtraBoldItalic"
         "NunitoSans-Black"
         "NunitoSans-BlackItalic"
         */
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themecolor,NSAttributedString.Key.font: UIFont(name: "NunitoSans-Bold", size: 18)!]
            appearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            //UINavigationBar.appearance().shadowImage = UIImage()
            //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            
            
            navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navController?.navigationBar.shadowImage = UIImage()
        }
        else{
            let navigationBarAppearace = UINavigationBar.appearance()
            navigationBarAppearace.isTranslucent = false;
            navigationBarAppearace.barStyle = .default
            //navigationBarAppearace.backgroundColor = .clear
            navigationBarAppearace.barTintColor = .white
            navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themecolor,NSAttributedString.Key.font: UIFont(name: "NunitoSans-Bold", size: 18)!]
            
            //UINavigationBar.appearance().shadowImage = UIImage()
            //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            
            navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navController?.navigationBar.shadowImage = UIImage()
        }
        
        
        //let str2 = UIDevice.current.identifierForVendor!.uuidString
        //let saveSuccessful: Bool = KeychainWrapper.standard.set(str2, forKey: "UniqueUDID")
        
        let dataNotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
        print("dataNotSave",dataNotSave)
        if (dataNotSave == 1)
        {
            print("TOKEN Already Sent")
        }
        else
        {
            print("TOKEN Not Sent")
            let struniquedeviceid = String(format: "%@", UIDevice.current.identifierForVendor!.uuidString)
            print("struniquedeviceid",struniquedeviceid)
            UserDefaults.standard.set(struniquedeviceid, forKey: "uniquedeviceid")
            UserDefaults.standard.synchronize()
        }
        
        tabSetting(type: "login")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = tabBarController
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        UserDefaults.standard.synchronize()
        self.saveContext()
    }
    
    //MARK: - Tabbar Setting for CUSTOMER
    func tabSetting(type:String)
    {
        let home:UIViewController
        if type == "login" {
            home = loginclass(nibName: "loginclass", bundle: nil)
        }else{
            home = homeclass(nibName: "homeclass", bundle: nil)
            
        }
        home.tabBarItem.title = "Home"
        home.tabBarItem.image = UIImage(named: "tab11")
        home.tabBarItem.selectedImage = UIImage(named: "tab1")
        let homeNav  = UINavigationController(rootViewController: home)
        
        let subsription = subsriptionclass(nibName: "subsriptionclass", bundle: nil)
        subsription.tabBarItem.title = "Subscription"
        subsription.tabBarItem.image = UIImage(named: "tab22")
        subsription.tabBarItem.selectedImage = UIImage(named: "tab2")
        let subsriptionNav  = UINavigationController(rootViewController: subsription)
        
        let orderonce = orderonceclass(nibName: "orderonceclass", bundle: nil)
        orderonce.tabBarItem.title = "Order Once"
        orderonce.tabBarItem.image = UIImage(named: "tab33")
        orderonce.tabBarItem.selectedImage = UIImage(named: "tab3")
        let orderonceNav  = UINavigationController(rootViewController: orderonce)
        
        let menu = menuclass(nibName: "menuclass", bundle: nil)
        menu.tabBarItem.title = ""
        menu.tabBarItem.image = UIImage(named: "tab44")
        menu.tabBarItem.selectedImage = UIImage(named: "tab4")
        let menuNav  = UINavigationController(rootViewController: menu)
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "lightblue")!], for: .selected)

      
        self.tabBarController.tabBar.clipsToBounds = true
        self.tabBarController.tabBar.backgroundImage = UIImage()

        let bgView: UIImageView = UIImageView(image: UIImage(named: "tabbarbg.png"))
        bgView.frame = self.tabBarController.tabBar.bounds
        self.tabBarController.tabBar.addSubview(bgView)

        //self.tabBarController.tabBar.backgroundColor = UIColor(named: "themecolor")!
        self.tabBarController.tabBar.tintColor = UIColor.white
        self.tabBarController.tabBar.barTintColor =  UIColor(named: "themecolor")!
        UITabBar.appearance().tintColor = UIColor.gray
        
        homeNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        subsriptionNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        orderonceNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        menuNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: +10)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "lightblue")!, NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 14) as Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font : UIFont(name: "NunitoSans-Bold", size: 14) as Any], for: .selected)
           
        
        tabBarController.viewControllers = [homeNav,subsriptionNav,orderonceNav,menuNav]
        tabBarController.selectedIndex = 0
        
    }
    
    // MARK:- set Gradient Background method
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = tabBarController.tabBar.bounds
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0, 1]
        gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        tabBarController.tabBar.layer.insertSublayer(gradientlayer, at: 0)
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "AlRawabi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Firebase Delegate Methods
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        print("Firebase registration token: \(fcmToken ?? "")")
        
        let dataDict:[String: String] = ["token": String(format: "%@", fcmToken!)]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO If necessary send token to application server.
        //  Note: This callback is fired at each app startup and whenever a new token is generated.
        
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
        UserDefaults.standard.synchronize()
        
        let strfcmToken = String(format: "%@",UserDefaults.standard.value(forKey: "fcmToken") as? String ?? "")
        print("strfcmToken",strfcmToken)
        
        /*let uiAlert = UIAlertController(title: "Device Token", message: strDeviceToken, preferredStyle: UIAlertController.Style.alert)
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("Click of default button")
            
            let dataNotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
            print("dataNotSave",dataNotSave)
            if (dataNotSave == 1)
            {
                print("TOKEN Already Sent")
            }
            else
            {
                print("TOKEN Not Sent")
                self.postDeviceToken()
            }
        }))
        self.window?.rootViewController?.present(uiAlert, animated: true, completion: nil)*/
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            let dataNotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
            print("dataNotSave",dataNotSave)
            if (dataNotSave == 1)
            {
                print("TOKEN Already Sent")
            }
            else
            {
                print("TOKEN Not Sent")
            }
        }
    }
    private func application(application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    private func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification userInfo: [AnyHashable: Any],withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void){
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        self.notificationPopup(userInfo: userInfo as NSDictionary)
        completionHandler([.badge, .alert, .sound])
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void){
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        /*{
         "aps": {
           "alert": {
             "title": "Your food is done.",
             "body": "Be careful, it's really hot!"
           }
         }
       }
*/
        
        self.notificationPopup(userInfo: userInfo as NSDictionary)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Notification: Unable to register for remote notifications: \(error.localizedDescription)")
    }
    func notificationPopup(userInfo:NSDictionary)
    {
        if UIApplication.shared.applicationState == .background || UIApplication.shared.applicationState == .inactive
        {
            print("App is currently inactive or background state")
            self.notificationClickRedirection(userInfo: userInfo as NSDictionary)
        }
        else
        {
            print("App is currently active state")
            
            let dictemp = userInfo.value(forKey: "aps") as! NSDictionary
            let message = String(format: "%@", dictemp.value(forKey: "alert") as! CVarArg)
            
            let pushAlert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
            pushAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("Check Now logic here")
                self.notificationClickRedirection(userInfo: userInfo as NSDictionary)
            }))
            pushAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Cancel Logic here")
            }))
            
            self.window?.rootViewController?.present(pushAlert, animated: true, completion: nil)
        }
    }
    func notificationClickRedirection(userInfo:NSDictionary)
    {
        print("userInfo",userInfo)
        /*let stroptMode = String(format: "%@", userInfo.value(forKey: "gcm.notification.optMode") as! CVarArg)
        let stroptType = String(format: "%@", userInfo.value(forKey: "gcm.notification.optType") as! CVarArg)
        print("stroptMode ->",stroptMode)
        print("stroptType ->",stroptType)*/
    }

    //MARK: - Language Setup Method
    func changeLanguage(key:String) -> String
    {
        print("key:%@",key)
        var path = String()
        var updatedStr = String()
        
        let strK = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage")! as! CVarArg)
        if (strK == "en")
        {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")!
            let languageBundle = Bundle(path: path)
            updatedStr = (languageBundle?.localizedString(forKey: key, value: "", table: nil))!
        }
        else if (strK == "ar")
        {
            path = Bundle.main.path(forResource: "ar", ofType: "lproj")!
            let languageBundle = Bundle(path: path)
            updatedStr = (languageBundle?.localizedString(forKey: key, value: "", table: nil))!
        }
        return updatedStr
    }
}

