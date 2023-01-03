//
//  loginclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/05/22.
//

import UIKit

class loginclass: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var scrollviewoverall: UIScrollView!
    
    @IBOutlet weak var imgvbanner: UIImageView!
    @IBOutlet weak var lblogin: UILabel!
    @IBOutlet weak var lblsigntoyouraccount: UILabel!
    
    @IBOutlet weak var viewusername: UIView!
    @IBOutlet weak var viewusername1: UIView!
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var viewpassword: UIView!
    @IBOutlet weak var viewpassword1: UIView!
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var switchrememberme: UISwitch!
    @IBOutlet weak var lblrememberme: UILabel!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnregisternow: UIButton!
    @IBOutlet weak var btnmaidlogin: UIButton!
    @IBOutlet weak var lblor: UILabel!
    
    @IBOutlet weak var btnhideshowpassword: UIButton!
    
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    
    
    @IBOutlet var viewforgotpassword: UIView!
    @IBOutlet weak var viewfg1: UIView!
    @IBOutlet weak var lblfgpopupheader: UILabel!
    @IBOutlet weak var txtfgpopupemail: UITextField!
    @IBOutlet weak var lblfgpopupmessage: UILabel!
    @IBOutlet weak var btnfgpopupSubmit: UIButton!
    @IBOutlet weak var btnfgpopupCross: UIButton!
    var viewPopupAddNewExistingBG2 = UIView()
    
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
        
        //LANGUAGE SET IN LOGIN PAGE LOAD
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        print("strLangCode",strLangCode)
        if (strLangCode == "en")
        {
            segmentLanguage.selectedSegmentIndex = 0
            UserDefaults.standard.set("en", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
        else
        {
            segmentLanguage.selectedSegmentIndex = 1
            UserDefaults.standard.set("ar", forKey: "applicationlanguage")
            UserDefaults.standard.synchronize()
        }
      
        //REMEMBER ME CHECK ON VIEWDIDAPPEAR LOGIN SCREEN
        let strrememberme_username = String(format: "%@",UserDefaults.standard.value(forKey: "username_rememberme") as? String ?? "")
        let strrememberme_password = String(format: "%@",UserDefaults.standard.value(forKey: "password_rememberme") as? String ?? "")
        let is_rememberme = String(format: "%@",UserDefaults.standard.value(forKey: "is_rememberme") as? String ?? "")
        if is_rememberme == "1"{
            switchrememberme.isOn = true
            txtusername.text = strrememberme_username
            txtpassword.text = strrememberme_password
        }else{
            switchrememberme.isOn = false
            //txtusername.text = ""
            //txtpassword.text = ""
        }
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.scrollviewoverall.backgroundColor = .clear
        self.scrollviewoverall.showsVerticalScrollIndicator = false
        self.scrollviewoverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        txtusername.setLeftPaddingPoints(10)
        txtpassword.setLeftPaddingPoints(10)
        
        viewusername.layer.cornerRadius = 3.0
        viewusername.layer.masksToBounds = true
        viewpassword.layer.cornerRadius = 3.0
        viewpassword.layer.masksToBounds = true
        
        btnlogin.layer.cornerRadius = 22.0
        btnlogin.layer.masksToBounds = true
        
        btnregisternow.layer.borderWidth = 1.0
        btnregisternow.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnregisternow.layer.cornerRadius = 22.0
        btnregisternow.layer.masksToBounds = true
        
        btnmaidlogin.layer.borderWidth = 1.0
        btnmaidlogin.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnmaidlogin.layer.cornerRadius = 22.0
        btnmaidlogin.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //UserDefaults.standard.set("0", forKey: "is_rememberme")
        //UserDefaults.standard.synchronize()
        
        //FIXMESANDIPAN
        //arpanray.citytech@gmail.com / $#Admin1
        //phpteam4@citytechcorp.com / admin@1234
        //arpan.ray@citytechcorp.com / $#Admin2
        //abhishek.biswas@citytechcorp.com / 123456
        
        txtusername.text = "arpan.ray@citytechcorp.com"
        txtpassword.text = "$#Admin2"
        
        self.btnhideshowpassword.isSelected = false
        self.txtpassword.isSecureTextEntry = true
        
    }
    
    //MARK: - press Segment Language Method
    @IBAction func presssegmentLanguage(_ sender: Any)
    {
        if segmentLanguage.selectedSegmentIndex == 0
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
    }
    
    //MARK: - keyboard show hide on Mobile number Textfield Method
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 160
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
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblogin.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language20"))
        lblsigntoyouraccount.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language21"))
        btnlogin.setTitle(myAppDelegate.changeLanguage(key: "msg_language20"), for: .normal)
        btnregisternow.setTitle(myAppDelegate.changeLanguage(key: "msg_language24"), for: .normal)
        btnmaidlogin.setTitle(myAppDelegate.changeLanguage(key: "msg_language272"), for: .normal)
        lblor.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language19"))
        self.txtusername.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language22"))
        self.txtpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language23"))
        
        lblrememberme.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language26"))
        btnforgotpassword.setTitle(myAppDelegate.changeLanguage(key: "msg_language27"), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lblogin.textAlignment = .left
            lblsigntoyouraccount.textAlignment = .left
            lblrememberme.textAlignment = .left
            
            self.viewusername1.frame = CGRect(x: 1, y: self.viewusername1.frame.origin.y, width: self.viewusername1.frame.size.width, height: self.viewusername1.frame.size.height)
            
            self.txtusername.frame = CGRect(x: 54, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width, height: self.txtusername.frame.size.height)
            self.txtusername.textAlignment = .left
            
            self.viewpassword1.frame = CGRect(x: 1, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            
            self.txtpassword.frame = CGRect(x: 54, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .left
            
            self.btnhideshowpassword.frame = CGRect(x: self.txtpassword.frame.size.width - 5, y: self.btnhideshowpassword.frame.origin.y, width: self.btnhideshowpassword.frame.size.width, height: self.btnhideshowpassword.frame.size.height)
            
            self.btnforgotpassword.frame = CGRect(x: self.viewpassword.frame.maxX - self.btnforgotpassword.frame.size.width, y: self.btnforgotpassword.frame.origin.y, width: self.btnforgotpassword.frame.size.width, height: self.btnforgotpassword.frame.size.height)
            
            
            self.switchrememberme.frame = CGRect(x: self.viewpassword.frame.minX, y: self.switchrememberme.frame.origin.y, width: self.switchrememberme.frame.size.width, height: self.switchrememberme.frame.size.height)
            self.lblrememberme.frame = CGRect(x: self.switchrememberme.frame.maxX + 2, y: self.lblrememberme.frame.origin.y, width: self.lblrememberme.frame.size.width, height: self.lblrememberme.frame.size.height)
        }
        else
        {
            lblogin.textAlignment = .right
            lblsigntoyouraccount.textAlignment = .right
            lblrememberme.textAlignment = .right
            
            self.viewusername1.frame = CGRect(x: self.viewusername.frame.size.width - 53, y: self.viewusername1.frame.origin.y, width: self.viewusername1.frame.size.width, height: self.viewusername1.frame.size.height)
            
            self.txtusername.frame = CGRect(x: 1, y: self.txtusername.frame.origin.y, width: self.txtusername.frame.size.width, height: self.txtusername.frame.size.height)
            self.txtusername.textAlignment = .right
            
            self.viewpassword1.frame = CGRect(x: self.viewpassword.frame.size.width - 53, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            
            self.txtpassword.frame = CGRect(x: 1, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .right
            
            self.btnhideshowpassword.frame = CGRect(x: 10, y: self.btnhideshowpassword.frame.origin.y, width: self.btnhideshowpassword.frame.size.width, height: self.btnhideshowpassword.frame.size.height)
            
            self.btnforgotpassword.frame = CGRect(x: self.viewpassword.frame.origin.x, y: self.btnforgotpassword.frame.origin.y, width: self.btnforgotpassword.frame.size.width, height: self.btnforgotpassword.frame.size.height)
            
            self.switchrememberme.frame = CGRect(x: self.viewpassword.frame.maxX - self.switchrememberme.frame.size.width, y: self.switchrememberme.frame.origin.y, width: self.switchrememberme.frame.size.width, height: self.switchrememberme.frame.size.height)
            self.lblrememberme.frame = CGRect(x: self.switchrememberme.frame.minX - self.lblrememberme.frame.size.width, y: self.lblrememberme.frame.origin.y, width: self.lblrememberme.frame.size.width, height: self.lblrememberme.frame.size.height)

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
    
    
    // MARK: - pressswitchrememberme Method
    @IBAction func pressswitchrememberme(_ sender: Any)
    {
        print("pressswitchrememberme")
        if switchrememberme.isOn == true{
            //Save as Remember Me
            
            UserDefaults.standard.set(txtusername.text!, forKey: "username_rememberme")
            UserDefaults.standard.set(txtpassword.text!, forKey: "password_rememberme")
            UserDefaults.standard.set("1", forKey: "is_rememberme")
            UserDefaults.standard.synchronize()
        }
        else{
            //Dont Save as Remember Me
            UserDefaults.standard.set("0", forKey: "is_rememberme")
            UserDefaults.standard.synchronize()
        }
        
    }
    // MARK: - pressforgotpassword Method
    @IBAction func pressforgotpassword(_ sender: Any)
    {
        print("pressforgotpassword")
        //self.createPopupForgotPassword()
        
        let obj = passwordupdatemobile(nibName: "passwordupdatemobile", bundle: nil)
        obj.strpageidentifier = "100"
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    //MARK: - create POPUP Forgot Password method
    func createPopupForgotPassword()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewforgotpassword.layer.cornerRadius = 6.0
        self.viewforgotpassword.layer.masksToBounds = true
        
        txtfgpopupemail.layer.borderWidth = 1.0
        txtfgpopupemail.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtfgpopupemail.layer.cornerRadius = 4.0
        txtfgpopupemail.layer.masksToBounds = true
        txtfgpopupemail.setLeftPaddingPoints(10)

        btnfgpopupSubmit.layer.cornerRadius = 16.0
        btnfgpopupSubmit.layer.masksToBounds = true
        
        viewPopupAddNewExistingBG2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG2.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG2.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG2.addSubview(self.viewforgotpassword)
        self.viewforgotpassword.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG2)

    }
    @IBAction func pressfgpopupCross(_ sender: Any)
    {
        print("pressfgpopupCross")
        txtfgpopupemail.resignFirstResponder()
        self.viewforgotpassword.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    @IBAction func pressfgpopupSubmit(_ sender: Any)
    {
        print("pressfgpopupCross")
        txtfgpopupemail.resignFirstResponder()
        self.viewforgotpassword.removeFromSuperview()
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    
    
    // MARK: - presslogin Method
    @IBAction func presslogin(_ sender: Any)
    {
        print("presslogin")
        
        if txtusername.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your username", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtpassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your passsword", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            
            self.postLoginAPImethod()

        }
        
        
    }
    // MARK: - pressskipnow Method
    @IBAction func pressregisternow(_ sender: Any) {
        print("pressregisternow")
        
        let obj = registrationclass(nibName: "registrationclass", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)
    }
    // MARK: - press Maid Login Method
    @IBAction func pressMaidLogin(_ sender: Any) {
        print("pressskipnow")
        
        let obj = maidloginclass(nibName: "maidloginclass", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)
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
        

        let parameters = ["emailId": txtusername.text!,
                          "password":txtpassword.text!,
                          "deviceId":struniquedeviceid,
                          "deviceToken":strfcmToken,
                          "deviceType":"I",] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod1)
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
                            
                            UserDefaults.standard.set(strbearertoken, forKey: "bearertoken")
                            UserDefaults.standard.set(dicdeviceinfo, forKey: "deviceInfo")
                            UserDefaults.standard.synchronize()
                            
                            self.getLoginuserdetailsmenthod()

                        }
                        else
                        {
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
    
    //MARK: - get login userdetails API method
    func getLoginuserdetailsmenthod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
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
                            
                            UserDefaults.standard.set(strcustomerid, forKey: "customerid")
                            UserDefaults.standard.set(diccustomerDetails, forKey: "customerdetails")
                            UserDefaults.standard.synchronize()

                            let appDel = UIApplication.shared.delegate as! AppDelegate
                            appDel.tabSetting(type: "home")
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
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
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }

}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.shadowColor = UIColor(red: 225/255, green: 237/255, blue: 250/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
    }
}
extension UITextView {
    func setBottomBorderTextview() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.shadowColor = UIColor(red: 225/255, green: 237/255, blue: 250/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
    }
}
extension UIView {
    func setBottomBorderuiview111() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.shadowColor = UIColor(red: 225/255, green: 237/255, blue: 250/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
    }
}

extension UIView {
    func setBottomBorderuiview() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
extension UILabel {
    func setBottomBorderuilabel() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
extension UILabel {
    func setUpperBorderuilabel() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
