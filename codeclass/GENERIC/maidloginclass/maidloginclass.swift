//
//  maidloginclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import UIKit

class maidloginclass: UIViewController,UITextFieldDelegate
{

    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var imgvbanner: UIImageView!
    @IBOutlet weak var lblogin: UILabel!
    @IBOutlet weak var lblsigntoyouraccount: UILabel!
    
    @IBOutlet weak var viewusername: UIView!
    @IBOutlet weak var viewusername1: UIView!
    @IBOutlet weak var lblmobilecountrycode: UILabel!
    @IBOutlet weak var txtusername: UITextField!
    
    @IBOutlet weak var viewpassword: UIView!
    @IBOutlet weak var viewpassword1: UIView!
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var btnlogin: UIButton!
    
    @IBOutlet weak var btnhideshowpassword: UIButton!
    
    
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
        self.navigationController?.navigationBar.isHidden = true
        
        self.setupRTLLTR()
      
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        txtusername.setLeftPaddingPoints(10)
        txtpassword.setLeftPaddingPoints(10)
        
        btnlogin.layer.cornerRadius = 16.0
        btnlogin.layer.masksToBounds = true
        
        txtusername.keyboardType = .phonePad
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtusername.inputAccessoryView = toolbarDone
        
       
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.btnhideshowpassword.isSelected = false
        self.txtpassword.isSecureTextEntry = true
        
        //FIXMESANDIPAN
        //9674777246 Sandi@123 8621812596 9051015017
        
        txtusername.text = "8621812596"
        txtpassword.text = "maid@123"
        
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblogin.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language288"))
        lblsigntoyouraccount.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language289"))
       
        btnlogin.setTitle(myAppDelegate.changeLanguage(key: "msg_language20"), for: .normal)
        
        self.txtusername.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language9"))
        self.txtpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language23"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lblogin.textAlignment = .left
            lblsigntoyouraccount.textAlignment = .left
            
            txtusername.textAlignment = .left
            txtpassword.textAlignment = .left
            
            self.viewusername1.frame = CGRect(x: 1, y: self.viewusername1.frame.origin.y, width: self.viewusername1.frame.size.width, height: self.viewusername1.frame.size.height)
            
            self.lblmobilecountrycode.frame = CGRect(x: 54, y: self.lblmobilecountrycode.frame.origin.y, width: self.lblmobilecountrycode.frame.size.width, height: self.lblmobilecountrycode.frame.size.height)
            self.txtusername.frame = CGRect(x: self.lblmobilecountrycode.frame.maxX, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width - 1, height: self.txtusername.frame.size.height)
            
            //self.txtusername.frame = CGRect(x: 54, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width, height: self.txtusername.frame.size.height)
            self.txtusername.textAlignment = .left
            
            self.viewpassword1.frame = CGRect(x: 1, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            
            self.txtpassword.frame = CGRect(x: 54, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .left
            
            self.btnhideshowpassword.frame = CGRect(x: self.txtpassword.frame.size.width - 5, y: self.btnhideshowpassword.frame.origin.y, width: self.btnhideshowpassword.frame.size.width, height: self.btnhideshowpassword.frame.size.height)
        }
        else
        {
            lblogin.textAlignment = .right
            lblsigntoyouraccount.textAlignment = .right
            
            txtusername.textAlignment = .right
            txtpassword.textAlignment = .right
            
            self.viewusername1.frame = CGRect(x: self.viewusername.frame.size.width - 53, y: self.viewusername1.frame.origin.y, width: self.viewusername1.frame.size.width, height: self.viewusername1.frame.size.height)
            
            self.lblmobilecountrycode.frame = CGRect(x: self.txtusername.frame.maxX, y: self.lblmobilecountrycode.frame.origin.y, width: self.lblmobilecountrycode.frame.size.width, height: self.lblmobilecountrycode.frame.size.height)
            self.txtusername.frame = CGRect(x: 1, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width, height: self.txtusername.frame.size.height)
            //self.txtusername.frame = CGRect(x: 1, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width, height: self.txtusername.frame.size.height)
            self.txtusername.textAlignment = .right
            
            self.viewpassword1.frame = CGRect(x: self.viewpassword.frame.size.width - 53, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            
            self.txtpassword.frame = CGRect(x: 1, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .right
            
            self.btnhideshowpassword.frame = CGRect(x: 10, y: self.btnhideshowpassword.frame.origin.y, width: self.btnhideshowpassword.frame.size.width, height: self.btnhideshowpassword.frame.size.height)
        }
    }
    
    //MARK: - press back method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtusername.resignFirstResponder()
    }
    
    //MARK: - keyboard show hide on Mobile number Textfield Method
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 80
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @objc func hideKeyboard() {
        if self.view.frame.origin.y != 0 {
            txtusername.resignFirstResponder()
            txtpassword.resignFirstResponder()
            view.endEditing(true)
        }
        
    }
    
    //MARK: - press Hide / Show Password Method
    @IBAction func presshideshowpassword(_ sender: Any)
    {
        if btnhideshowpassword.isSelected == true
        {
            btnhideshowpassword.isSelected = false
            self.txtpassword.isSecureTextEntry = true
        }
        else{
            btnhideshowpassword.isSelected = true
            self.txtpassword.isSecureTextEntry = false
        }
    }
    
    // MARK: - presslogin Method
    @IBAction func presslogin(_ sender: Any)
    {
        print("presslogin")
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtusername.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language240"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language322"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            
            self.postLoginAPImethod()
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
        if textField.isEqual(txtusername) {
            let maxLength = 9 //FIXMESANDIPAN
            let currentString: NSString = txtusername.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
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
    
    //MARK: - post Login API method
    func postLoginAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let struniquedeviceid = UserDefaults.standard.value(forKey: "uniquedeviceid") as! String
        print("struniquedeviceid",struniquedeviceid)
        
        let strfcmToken = String(format: "%@",UserDefaults.standard.value(forKey: "fcmToken") as? String ?? "")
        print("strfcmToken",strfcmToken)
        

        let parameters = ["mobileNo": txtusername.text!,
                          "password":txtpassword.text!,
                          "deviceId":struniquedeviceid,
                          "deviceToken":strfcmToken,
                          "deviceType":"I",] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod77)
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
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let dicdeviceinfo = dictemp.value(forKey: "deviceInfo")
                            //print("dicdeviceinfo",dicdeviceinfo as Any)
                            let strbearertoken = String(format: "%@", dictemp.value(forKey: "token")as? String ?? "")
                            
                            UserDefaults.standard.set(strbearertoken, forKey: "bearertokenmaid")
                            UserDefaults.standard.set(dicdeviceinfo, forKey: "deviceInfomaid")
                            UserDefaults.standard.synchronize()
                            
                            self.getLoginuserdetailsmenthod()

                        }
                        else
                        {
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
    
    //MARK: - get login userdetails API method
    func getLoginuserdetailsmenthod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod2)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
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
                    print("dictemp --->",dictemp)
                   
                    
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let diccustomerDetails = dictemp.value(forKey: "customerDetails")as? NSDictionary
                            let strcustomerid = String(format: "%@", diccustomerDetails!.value(forKey: "id")as! CVarArg)
                            print("diccustomerDetails",diccustomerDetails as Any)
                            print("strcustomerid",strcustomerid)
                            
                            UserDefaults.standard.set(strcustomerid, forKey: "maidid")
                            UserDefaults.standard.set(diccustomerDetails, forKey: "maiddetails")
                            UserDefaults.standard.synchronize()

                            let obj = maidhomeclass(nibName: "maidhomeclass", bundle: nil)
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
