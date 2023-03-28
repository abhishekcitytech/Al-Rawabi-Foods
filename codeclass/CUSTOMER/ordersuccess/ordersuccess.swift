//
//  ordersuccess.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/07/22.
//

import UIKit

class ordersuccess: UIViewController
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtick: UIView!
    
    @IBOutlet weak var lblorderid: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var btntrackorder: UIButton!
    @IBOutlet weak var btncontinueshopping: UIButton!
    
    
    var strorderid = ""
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        lblorderid.text = String(format: "%@ #%@", myAppDelegate.changeLanguage(key: "msg_language479"), strorderid)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language198")
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lbl1.text = String(format: "%@!", myAppDelegate.changeLanguage(key: "msg_language199"))
        }
        else
        {
            lbl1.text = String(format: "!%@", myAppDelegate.changeLanguage(key: "msg_language199"))
        }
        lbl2.text = String(format: "%@\n%@", myAppDelegate.changeLanguage(key: "msg_language200"),myAppDelegate.changeLanguage(key: "msg_language201"))
        
        btncontinueshopping.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language203")), for: .normal)
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        btntrackorder.layer.borderWidth = 1.0
        btntrackorder.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btntrackorder.layer.cornerRadius = 16.0
        btntrackorder.layer.masksToBounds = true
        
        btncontinueshopping.layer.borderWidth = 1.0
        btncontinueshopping.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btncontinueshopping.layer.cornerRadius = 16.0
        btncontinueshopping.layer.masksToBounds = true
        
        btntrackorder.isHidden = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        //self.navigationController?.popViewController(animated: true)
        
        //FIXME
        let strpayfromOrderonce = UserDefaults.standard.value(forKey: "payfromOrderonce")as? String ?? ""
        print("strpayfromOrderonce",strpayfromOrderonce)
        
        if strpayfromOrderonce == "1"
        {
            UserDefaults.standard.set("1", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //ORDER ONCE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: orderonceclass.self) {
                    let tabVC = controller as! orderonceclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: mysubscriptions.self) {
                    let tabVC = controller as! mysubscriptions
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else if strpayfromOrderonce == "3"
        {
            UserDefaults.standard.set("3", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //RENEW
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: subsriptionclass.self) {
                    let tabVC = controller as! subsriptionclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: mysubscriptions.self) {
                    let tabVC = controller as! mysubscriptions
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else if strpayfromOrderonce == "2"
        {
            UserDefaults.standard.set("2", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //SUBSCRIPTION CREATE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: subsriptionclass.self) {
                    let tabVC = controller as! subsriptionclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else
        {
            //ORDER ONCE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: orderonceclass.self) {
                    let tabVC = controller as! orderonceclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
    }
    
    //MARK: - press Track Order Method
    @IBAction func presstrackorder(_ sender: Any)
    {
        //let ctrl = trackorder(nibName: "trackorder", bundle: nil)
        //self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Continue Shopping Method
    @IBAction func presscontinueshopping(_ sender: Any)
    {
        //FIXME
        let strpayfromOrderonce = UserDefaults.standard.value(forKey: "payfromOrderonce")as? String ?? ""
        print("strpayfromOrderonce",strpayfromOrderonce)
        
        if strpayfromOrderonce == "1"
        {
            UserDefaults.standard.set("1", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //ORDER ONCE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: orderonceclass.self) {
                    let tabVC = controller as! orderonceclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: mysubscriptions.self) {
                    let tabVC = controller as! mysubscriptions
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else if strpayfromOrderonce == "3"
        {
            UserDefaults.standard.set("3", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //RENEW
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: subsriptionclass.self) {
                    let tabVC = controller as! subsriptionclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: mysubscriptions.self) {
                    let tabVC = controller as! mysubscriptions
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else if strpayfromOrderonce == "2"
        {
            UserDefaults.standard.set("2", forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
            
            //SUBSCRIPTION CREATE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: subsriptionclass.self) {
                    let tabVC = controller as! subsriptionclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        else
        {
            //ORDER ONCE
            guard let vc = self.navigationController?.viewControllers else { return }
            for controller in vc {
                if controller.isKind(of: homeclass.self) {
                    let tabVC = controller as! homeclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: orderonceclass.self) {
                    let tabVC = controller as! orderonceclass
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
                else if controller.isKind(of: cartlistorderonce.self) {
                    let tabVC = controller as! cartlistorderonce
                    self.navigationController?.popToViewController(tabVC, animated: true)
                }
            }
        }
        
    }
}
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
