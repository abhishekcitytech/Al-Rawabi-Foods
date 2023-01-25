//
//  maidordersuccess.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 12/12/22.
//

import UIKit

class maidordersuccess: UIViewController
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        lblorderid.text = String(format: "%@ #%@",myAppDelegate.changeLanguage(key: "msg_language308"), strorderid)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language198")
        
        lbl1.text = myAppDelegate.changeLanguage(key: "msg_language199")
        lbl2.text = String(format: "%@ %@", myAppDelegate.changeLanguage(key: "msg_language200"),myAppDelegate.changeLanguage(key: "msg_language201"))
        
        btncontinueshopping.setTitle(myAppDelegate.changeLanguage(key: "msg_language203"), for: .normal)
        
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
        self.navigationController?.popViewController(animated: true)
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

        //ORDER ONCE
        guard let vc = self.navigationController?.viewControllers else { return }
        for controller in vc {
           if controller.isKind(of: maidhomeclass.self) {
              let tabVC = controller as! maidhomeclass
              self.navigationController?.popToViewController(tabVC, animated: true)
           }
            else if controller.isKind(of: maidproductdetails.self) {
                let tabVC = controller as! maidhomeclass
                self.navigationController?.popToViewController(tabVC, animated: true)
             }
        }
    }

}
