//
//  passwordupdatesubmit.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/12/22.
//

import UIKit

class passwordupdatesubmit: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var lblupdatepassword: UILabel!
    
    @IBOutlet weak var viewnewpassword: UIView!
    @IBOutlet weak var viewiconbox1: UIView!
    @IBOutlet weak var imgvicon1: UIImageView!
    @IBOutlet weak var txtnewpassword: UITextField!
    
    @IBOutlet weak var viewconfirmpassword: UIView!
    @IBOutlet weak var viewiconbox2: UIView!
    @IBOutlet weak var imgvicon2: UIImageView!
    @IBOutlet weak var txtconfirmpassword: UITextField!
    
    @IBOutlet weak var btnsubmit: UIButton!
    
    @IBOutlet weak var btnshowhidepassword1: UIButton!
    @IBOutlet weak var btnshowhidepassword2: UIButton!
    
    
    var strpageidentifier = ""
    
    var strcountrycode = ""
    var strmobileno = ""
    

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
        setupRTLLTR()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language135")
        
        //Create Back Button
        let yourBackImage = UIImage(named: "back")
        let Back = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(pressBack))
        Back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = Back
        
        viewnewpassword.layer.cornerRadius = 3.0
        viewnewpassword.layer.masksToBounds = true
        viewconfirmpassword.layer.cornerRadius = 3.0
        viewconfirmpassword.layer.masksToBounds = true
        
        txtnewpassword.setLeftPaddingPoints(10)
        txtconfirmpassword.setLeftPaddingPoints(10)
        
        btnsubmit.layer.cornerRadius = 22.0
        btnsubmit.layer.masksToBounds = true
        
        
    }
    
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblupdatepassword.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language291"))
        
        btnsubmit.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language178")), for: .normal)
        
        self.txtnewpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language32"))
        self.txtconfirmpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language33"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.viewiconbox1.frame = CGRect(x: 1, y: self.viewiconbox1.frame.origin.y, width: self.viewiconbox1.frame.size.width, height: self.viewiconbox1.frame.size.height)
            
            self.txtnewpassword.frame = CGRect(x: 54, y: self.txtnewpassword.frame.origin.y, width: self.txtnewpassword.frame.size.width, height: self.txtnewpassword.frame.size.height)
            self.txtnewpassword.textAlignment = .left
            
            self.btnshowhidepassword1.frame = CGRect(x: self.txtnewpassword.frame.size.width - 5, y: self.btnshowhidepassword1.frame.origin.y, width: self.btnshowhidepassword1.frame.size.width, height: self.btnshowhidepassword1.frame.size.height)
            
            self.viewiconbox2.frame = CGRect(x: 1, y: self.viewiconbox2.frame.origin.y, width: self.viewiconbox2.frame.size.width, height: self.viewiconbox2.frame.size.height)
            
            self.txtconfirmpassword.frame = CGRect(x: 54, y: self.txtconfirmpassword.frame.origin.y, width: self.txtconfirmpassword.frame.size.width, height: self.txtconfirmpassword.frame.size.height)
            self.txtconfirmpassword.textAlignment = .left
            
            self.btnshowhidepassword2.frame = CGRect(x: self.txtconfirmpassword.frame.size.width - 5, y: self.btnshowhidepassword2.frame.origin.y, width: self.btnshowhidepassword2.frame.size.width, height: self.btnshowhidepassword2.frame.size.height)
        }
        else
        {
            self.viewiconbox1.frame = CGRect(x: self.viewnewpassword.frame.size.width - 53, y: self.viewiconbox1.frame.origin.y, width: self.viewiconbox1.frame.size.width, height: self.viewiconbox1.frame.size.height)
            
            self.txtnewpassword.frame = CGRect(x: 1, y: self.txtnewpassword.frame.origin.y, width: self.txtnewpassword.frame.size.width, height: self.txtnewpassword.frame.size.height)
            self.txtnewpassword.textAlignment = .right
            
            self.btnshowhidepassword1.frame = CGRect(x: 10, y: self.btnshowhidepassword1.frame.origin.y, width: self.btnshowhidepassword1.frame.size.width, height: self.btnshowhidepassword1.frame.size.height)
            
            self.viewiconbox2.frame = CGRect(x: self.viewconfirmpassword.frame.size.width - 53, y: self.viewiconbox2.frame.origin.y, width: self.viewiconbox2.frame.size.width, height: self.viewiconbox2.frame.size.height)
            
            self.txtconfirmpassword.frame = CGRect(x: 1, y: self.txtconfirmpassword.frame.origin.y, width: self.txtconfirmpassword.frame.size.width, height: self.txtconfirmpassword.frame.size.height)
            self.txtconfirmpassword.textAlignment = .right
            
            self.btnshowhidepassword2.frame = CGRect(x: 10, y: self.btnshowhidepassword2.frame.origin.y, width: self.btnshowhidepassword2.frame.size.width, height: self.btnshowhidepassword2.frame.size.height)
        }
    }
    
    
    //MARK: -  press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Show Hide Password Method
    @IBAction func pressShowHidePassword(_ sender: Any)
    {
        if btnshowhidepassword1.isSelected == true
        {
            btnshowhidepassword1.isSelected = false
            self.txtnewpassword.isSecureTextEntry = true
        }
        else{
            btnshowhidepassword1.isSelected = true
            self.txtnewpassword.isSecureTextEntry = false
        }
    }
    
    //MARK: - press Show Hide Confirm Password Method
    @IBAction func pressShowHideConfirmPassword(_ sender: Any)
    {
        if btnshowhidepassword2.isSelected == true
        {
            btnshowhidepassword2.isSelected = false
            self.txtconfirmpassword.isSecureTextEntry = true
        }
        else{
            btnshowhidepassword2.isSelected = true
            self.txtconfirmpassword.isSecureTextEntry = false
        }
    }

    
    //MARK: - press Submit Method
    @IBAction func pressSubmit(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtnewpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language10"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtconfirmpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language11"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtnewpassword.text != txtconfirmpassword.text
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language12"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.postResetPasswordAPIMethod()
        }
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    //MARK: - post Reset pasword API method
    func postResetPasswordAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")

        let parameters = ["countryCode": strcountrycode,"mobileNo": strmobileno,"newPassword": txtconfirmpassword.text!,"language":strLangCode]as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod76)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        //request.setValue("Bearer \(strapikey ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    let dictemp = json as NSDictionary
                    print("dictemp",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            //Go Back
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                
                                if self.strpageidentifier == "100"
                                {
                                    //Go To CUSTOMER Login Screen
                                    
                                    guard let vc = self.navigationController?.viewControllers else { return }
                                    for controller in vc {
                                       if controller.isKind(of: loginclass.self) {
                                          let tabVC = controller as! loginclass
                                          self.navigationController?.popToViewController(tabVC, animated: true)
                                       }
                                    }
                                }
                                else if self.strpageidentifier == "3300"
                                {
                                    //Go To MAID Login Screen
                                    
                                    guard let vc = self.navigationController?.viewControllers else { return }
                                    for controller in vc {
                                       if controller.isKind(of: maidloginclass.self) {
                                          let tabVC = controller as! maidloginclass
                                          self.navigationController?.popToViewController(tabVC, animated: true)
                                       }
                                    }
                                }
                                else
                                {
                                    //Go to Menu Screen
                                    
                                    //REMEMBER ME CHECK ON VIEWDIDAPPEAR LOGIN SCREEN
                                    let is_rememberme = String(format: "%@",UserDefaults.standard.value(forKey: "is_rememberme") as? String ?? "")
                                    if is_rememberme == "1"
                                    {
                                        UserDefaults.standard.set(self.txtconfirmpassword.text!, forKey: "password_rememberme")
                                        UserDefaults.standard.synchronize()   
                                    }else{
                                    }
                                    
                                    guard let vc = self.navigationController?.viewControllers else { return }
                                    for controller in vc {
                                       if controller.isKind(of: menuclass.self) {
                                          let tabVC = controller as! menuclass
                                          self.navigationController?.popToViewController(tabVC, animated: true)
                                       }
                                    }
                                }
                                
                            }))
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }

}
