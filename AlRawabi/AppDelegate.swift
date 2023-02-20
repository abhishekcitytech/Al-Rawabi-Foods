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

import NISdk

struct Constants {
    struct conn {
        
        //FIXMESANDIPAN -Last-Updated-By-20-02-2023
        //MARK: - Web Service API URL - DEV
        //static let ConnUrl = "https://alrawabi.task2bill.com/index.php/rest/default/V1/"
        
        //MARK: - Web Service API URL - UAT
        static let ConnUrl = "https://staging1.alrawabifoods.com/index.php/rest/default/V1/"
        
        //MARK: - GOOGLE PLACE API KEY
        static let GoogleAPIKey = "AIzaSyB0HROT7zT3VgKKv7oAEbvkyD_J0ErZ6RQ"
        
        //AIzaSyBJAhGdm5k7WgmHUkWX_4w5DY0uA88e4Hk - Paylite app
        //AIzaSyB0HROT7zT3VgKKv7oAEbvkyD_J0ErZ6RQ - AlRawabi
        
        //MARK: - CUT OFF TIME
        static let CutOffTime = "15:00:00"
        
        //MARK: - CUT OFF SUBSCRIPTION ORDER TOTAL
        static let CutOffSubscriptionOrderTotal = 15.00
        
        //MARK: - STATIC CALL NO
        static let STATISCALLNO = "+97147043000"
        
        //MARK: - STATIC EMAIL
        static let STATISEMAILID = "sales@alrawabi.ae"
        
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
        static let apimethod32 = "timeSlotDetails/timeSlotDetails-api"
        static let apimethod33 = "chooseAddress/chooseAddress-api"
        static let apimethod34 = "shippingMethodList/shippingMethodList-api"
        static let apimethod35 = "setDefaultAddress/setDefaultAddress-api"
        static let apimethod36 = "subscriptionshippment/subscriptionshippment-api"
        static let apimethod37 = "recenttransaction/recenttransaction-api"
        static let apimethod38 = "totalwalletvalue/totalwalletvalue-api"
        static let apimethod39 = "walletdetail/walletdetail-api"
        static let apimethod40 = "allpaymentmethod/allpaymentmethod-api"
        static let apimethod41 = "quoteinfo/quoteinfo-api"
        static let apimethod42 = "orderOncePlace/orderOncePlace-api"
        static let apimethod43 = "chooseShippingMethod/chooseShippingMethod-api"
        static let apimethod44 = "subscriptionlist/subscriptionlist-api"
        static let apimethod45 = "creditCardPayment/creditCardPayment-api"
        static let apimethod46 = "customerprofile/customerprofile-api"
        static let apimethod47 = "subscriptionpause/subscriptionpause-api"
        static let apimethod48 = "subscriptioncancel/subscriptioncancel-api"
        static let apimethod49 = "subscriptionview/subscriptionview-api"
        static let apimethod50 = "createSubscription/createSubscription-api"
        static let apimethod51 = "subscriptionCouponApply/subscriptionCouponApply-api"
        static let apimethod52 = "subscriptionPlaceOrder/subscriptionPlaceOrder-api"
        static let apimethod53 = "reorderonce/reorderonce-api"
        static let apimethod54 = "savedeliverydateandtime/savedeliverydateandtime-api"
        static let apimethod55 = "subscribedProductEditAddProduct/subscribedProductEditAddProduct-api"
        static let apimethod56 = "subscribedProductEditTimeslotEdit/subscribedProductEditTimeslotEdit-api"
        static let apimethod57 = "subscribedProductEditQuantity/subscribedProductEditQuantity-api"
        static let apimethod58 = "subscribedProductEditRemoveProduct/subscribedProductEditRemoveProduct-api"
        static let apimethod59 = "subscriptionEditView/subscriptionEditView-api"
        static let apimethod60 = "subscriptionEditProductQtyOnce/subscriptionEditProductQtyOnce-api"
        static let apimethod61 = "subscriptionEditProductQtyAll/subscriptionEditProductQtyAll-api"
        static let apimethod62 = "subscriptionEditProductAdd/subscriptionEditProductAdd-api"
        static let apimethod63 = "subscriptionEditProductRemove/subscriptionEditProductRemove-api"
        static let apimethod64 = "subscriptionEditTimeslotEdit/subscriptionEditTimeslotEdit-api"
        static let apimethod65 = "allLocation/allLocation-api"
        static let apimethod66 = "subaccountlist/subaccountlist-api"
        static let apimethod67 = "editsubaccount/editsubaccount-api"
        static let apimethod68 = "subscriptionEditDateEdit/subscriptionEditDateEdit-api"
        static let apimethod69 = "subscriptionRenewView/subscriptionRenewView-api"
        static let apimethod70 = "maidaccountdelete/maidaccountdelete-api"
        static let apimethod71 = "transferwalletamount/transferwalletamount-api"
        static let apimethod72 = "timeslot/timeslot-api"
        static let apimethod73 = "subscriptionRenewCreate/subscriptionRenewCreate-api"
        static let apimethod74 = "rechargewallet/rechargewallet-api"
        static let apimethod75 = "walletpayment/walletpayment-api"
        static let apimethod76 = "customerForgotPassword/customerForgotPassword-api"
        static let apimethod77 = "maidLogin/maidLogin-api"
        static let apimethod78 = "maidaddresslist/maidaddresslist-api"
        static let apimethod79 = "maidCartUpdate/maidCartUpdate-api"
        static let apimethod80 = "maidsubscriptionlist/maidsubscriptionlist-api"
        static let apimethod81 = "maidsubscriptionlistpaused/maidsubscriptionlistpaused-api"
        static let apimethod82 = "maidsubscriptionview/maidsubscriptionview-api"
        static let apimethod83 = "maidsubscriptionpause/maidsubscriptionpause-api"
        static let apimethod84 = "maidAllorders/maidAllorders-api"
        static let apimethod85 = "maidaddresslist/maidaddresslist-api"
        static let apimethod86 = "maidOrderOncePlace/maidOrderOncePlace-api"
        static let apimethod87 = "resetPasswordOtpRequest/resetPasswordOtpRequest-api"
        static let apimethod88 = "wallettransactionview/wallettransactionview-api"
        static let apimethod89 = "countryinfo/countryinfo-api"
        static let apimethod90 = "rewardpoints/rewardpoints-api"
        static let apimethod91 = "rewardtransactions/rewardtransactions-api"
        static let apimethod92 = "aboutuspage/aboutuspage-api"
        static let apimethod93 = "privacypolicypage/privacypolicypage-api"
        static let apimethod94 = "deliverypolicypage/deliverypolicypage-api"
        static let apimethod95 = "refundandcancellationpage/refundandcancellationpage-api"
        static let apimethod96 = "termsandconditionpage/termsandconditionpage-api"
        static let apimethod97 = "disclaimerpage/disclaimerpage-api"
        static let apimethod98 = "homepageHealtySuhoorBanner/homepageHealtySuhoorBanner-api"
        static let apimethod99 = "homepageJuiceBanner/homepageJuiceBanner-api"
        static let apimethod100 = "homepageNewinstoreBanner/homepageNewinstoreBanner-api"
        static let apimethod101 = "rewardpointapply/rewardpointapply-api"
        static let apimethod102 = "contactus/contactus-api"
        static let apimethod103 = "creditmemolist/creditmemolist-api"
        static let apimethod104 = "cancelcoupon/cancelcoupon-api"
        static let apimethod105 = "cancelrewardpoint/cancelrewardpoint-api"
        static let apimethod106 = "customerProfileUpdate/customerProfileUpdate-api"
        static let apimethod107 = "subscriptionRewardPointApply/subscriptionRewardPointApply-api"
        static let apimethod108 = "mobileOtpRequestExist/mobileOtpRequestExist-api"
        static let apimethod109 = "locationcoordinates/locationcoordinates-api"
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate,UITabBarControllerDelegate
{
    var window: UIWindow?
    var navController: UINavigationController?
    let tabBarController = UITabBarController()
    
    let gcmMessageIDKey = "gcm.message_id"
    
    //FIXME: GLOBAL VARIABLES FOR LOCAL DATABSE CHECKING FOR SUBSCRIPTION PLAN
    var strSelectedPLAN = ""
    
    
    //MARK: -  Appdidfinish launch option method
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        NISdk.sharedInstance.setSDKLanguage(language: "en")
        
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
        let pre1 = NSLocale.current.languageCode
        print("Device Language |||",pre1.debugDescription)
        let pre = Locale.preferredLanguages[0]
        print("APP Language |||",pre.debugDescription)
        
        var langStr = String()
        if pre.containsIgnoreCase("ar")
        {
            langStr = "ar"
        }
        else{
            langStr = "en"
        }
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? langStr)
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
        
        //tabSetting(type: "login")
        tabSetting(type: "customlaunch")
        
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        print("strLangCode ---> ",strLangCode)
        
        let home:UIViewController
        if type == "login" {
            home = loginclass(nibName: "loginclass", bundle: nil)
        }
        else if type == "customlaunch" {
            home = customlaunch(nibName: "customlaunch", bundle: nil)
        }
        else{
            home = homeclass(nibName: "homeclass", bundle: nil)
            
        }
        
        home.tabBarItem.title = myAppDelegate.changeLanguage(key: "msg_language136")
        home.tabBarItem.image = UIImage(named: "tab11")
        home.tabBarItem.selectedImage = UIImage(named: "tab1")
        let homeNav  = UINavigationController(rootViewController: home)
        
        let subsription = subsriptionclass(nibName: "subsriptionclass", bundle: nil)
        subsription.tabBarItem.title = myAppDelegate.changeLanguage(key: "msg_language74")
        subsription.tabBarItem.image = UIImage(named: "tab22")
        subsription.tabBarItem.selectedImage = UIImage(named: "tab2")
        let subsriptionNav  = UINavigationController(rootViewController: subsription)
        
        let orderonce = orderonceclass(nibName: "orderonceclass", bundle: nil)
        orderonce.tabBarItem.title = myAppDelegate.changeLanguage(key: "msg_language104")
        orderonce.tabBarItem.image = UIImage(named: "tab33")
        orderonce.tabBarItem.selectedImage = UIImage(named: "tab3")
        let orderonceNav  = UINavigationController(rootViewController: orderonce)
        
        let cartorderonce = cartlistorderonce(nibName: "cartlistorderonce", bundle: nil)
        cartorderonce.tabBarItem.title = myAppDelegate.changeLanguage(key: "msg_language114")
        cartorderonce.tabBarItem.image = UIImage(named: "tab55")
        cartorderonce.tabBarItem.selectedImage = UIImage(named: "tab5")
        let cartorderonceNav  = UINavigationController(rootViewController: cartorderonce)
        
        let menu = menuclass(nibName: "menuclass", bundle: nil)
        if (strLangCode == "en"){
            menu.tabBarItem.title = ""
        }else{
            menu.tabBarItem.title = ""
        }
        menu.tabBarItem.image = UIImage(named: "tab44")
        menu.tabBarItem.selectedImage = UIImage(named: "tab4")
        let menuNav  = UINavigationController(rootViewController: menu)
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "lightblue")!], for: .selected)

        self.tabBarController.delegate = self
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
        cartorderonceNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        menuNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0 , left: 0, bottom: -20, right: 0)
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: +10)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "lightblue")!, NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 14) as Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font : UIFont(name: "NunitoSans-Bold", size: 14) as Any], for: .selected)
         
        if strLangCode == "ar"{
            tabBarController.viewControllers = [menuNav,cartorderonceNav,orderonceNav,subsriptionNav,homeNav]
            tabBarController.selectedIndex = 4
        }else{
            tabBarController.viewControllers = [homeNav,subsriptionNav,orderonceNav,cartorderonceNav,menuNav]
            tabBarController.selectedIndex = 0
        }
        
    }
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
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


class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 1

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
