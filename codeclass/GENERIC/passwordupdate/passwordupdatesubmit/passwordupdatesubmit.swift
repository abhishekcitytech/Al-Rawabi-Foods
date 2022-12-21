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
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        _ = UIApplication.shared.delegate as! AppDelegate
        self.title = "Change Password"
        
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
    
    //MARK: -  press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    //MARK: - press Submit Method
    @IBAction func pressSubmit(_ sender: Any)
    {
        if txtnewpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtconfirmpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your condirm password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtnewpassword.text != txtconfirmpassword.text
        {
            let uiAlert = UIAlertController(title: "", message: "Confirm password does not match with your password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
        

        let parameters = ["countryCode": strcountrycode,"mobileNo": strmobileno,"newPassword": txtconfirmpassword.text!]as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod76)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        //request.setValue("Bearer \(strapikey ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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

                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            //Go Back
                            let uiAlert = UIAlertController(title: "", message: "You have successfully reset your password." , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                
                                if self.strpageidentifier == "100"
                                {
                                    //Go To Login Screen
                                    
                                    guard let vc = self.navigationController?.viewControllers else { return }
                                    for controller in vc {
                                       if controller.isKind(of: loginclass.self) {
                                          let tabVC = controller as! loginclass
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
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
