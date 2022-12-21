//
//  changepassword.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class changepassword: UIViewController,UIScrollViewDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var btnupdatesave: UIButton!
    
    @IBOutlet weak var lblor: UILabel!
    @IBOutlet weak var lblchangelanguage: UILabel!
    @IBOutlet weak var segmentlanguage: UISegmentedControl!
    
    
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
        
        //LANGUAGE SET IN LOGIN PAGE LOAD
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        print("strLangCode",strLangCode)
        if (strLangCode == "en")
        {
            segmentlanguage.selectedSegmentIndex = 0
            UserDefaults.standard.set("en", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        else
        {
            segmentlanguage.selectedSegmentIndex = 1
            UserDefaults.standard.set("ar", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Change Password & Language"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .white
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.scrolloverall.frame.size.width, height: self.viewoverall.frame.size.height - 235)
       
        btnupdatesave.layer.cornerRadius = 16.0
        btnupdatesave.layer.masksToBounds = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press segment language Method
    @IBAction func presssegmentlanguage(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if segmentlanguage.selectedSegmentIndex == 0
        {
            //ENGLISH
            UserDefaults.standard.set("en", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
            
            self.viewDidLoad()
            self.viewWillAppear(true)
            self.viewDidAppear(true)
        }
        else{
            //ARABIC
            UserDefaults.standard.set("ar", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
            
            self.viewDidLoad()
            self.viewWillAppear(true)
            self.viewDidAppear(true)
        }
        myAppDelegate.tabSetting(type: "home")
    }
    
    
   
    //MARK: - press Update Save Method
    @IBAction func pressUpdateSave(_ sender: Any)
    {
        let obj = passwordupdatemobile(nibName: "passwordupdatemobile", bundle: nil)
        obj.strpageidentifier = "200"
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
