//
//  passwordupdatemobileOTP.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/12/22.
//

import UIKit

class passwordupdatemobileOTP: UIViewController,UITextFieldDelegate
{

    @IBOutlet weak var viewoverall: UIView!

    @IBOutlet weak var lblenterotp: UILabel!
    @IBOutlet weak var lblsmshasbeensent: UILabel!
    @IBOutlet weak var lbldidnotreceivecode: UILabel!
    @IBOutlet weak var btnresendcode: UIButton!
    
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!
    
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
        self.title = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language1"))
        
        //Create Back Button
        let yourBackImage = UIImage(named: "back")
        let Back = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(pressBack))
        Back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = Back
        
        lblsmshasbeensent.isHidden = true
        
        txt1.layer.borderWidth = 1.0
        txt1.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt1.layer.cornerRadius = 4.0
        txt1.layer.masksToBounds = true
        
        txt2.layer.borderWidth = 1.0
        txt2.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt2.layer.cornerRadius = 4.0
        txt2.layer.masksToBounds = true
        
        txt3.layer.borderWidth = 1.0
        txt3.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt3.layer.cornerRadius = 4.0
        txt3.layer.masksToBounds = true
        
        txt4.layer.borderWidth = 1.0
        txt4.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt4.layer.cornerRadius = 4.0
        txt4.layer.masksToBounds = true
        
        txt5.layer.borderWidth = 1.0
        txt5.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt5.layer.cornerRadius = 4.0
        txt5.layer.masksToBounds = true
        
        txt6.layer.borderWidth = 1.0
        txt6.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt6.layer.cornerRadius = 4.0
        txt6.layer.masksToBounds = true
        
        if #available(iOS 12.0, *) {
            self.txt1.textContentType = .oneTimeCode
        }
        self.txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txt1.becomeFirstResponder()
        
    }
    
    //MARK: -  press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: -  pressresendcode method
    @IBAction func pressresendcode(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: "Do you want to resend OTP to your mobile number?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.postOTPRequestAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblenterotp.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language2"))
        lblsmshasbeensent.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language3"))
        lbldidnotreceivecode.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language4"))
        btnresendcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language5")), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
    
        }
        else
        {

        }
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField){
    }
    func textFieldDidEndEditing(_ textField: UITextField){
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if #available(iOS 12.0, *) {
            if textField.textContentType == UITextContentType.oneTimeCode{
                //here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count > 4{
                    txt1.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
                    txt2.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                    txt3.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                    txt4.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
                    txt5.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 4)])
                    txt6.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 5)])
                }
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count == 1)
        {
            if textField == txt1 {
                txt2?.becomeFirstResponder()
            }
            if textField == txt2 {
                txt3?.becomeFirstResponder()
            }
            if textField == txt3 {
                txt4?.becomeFirstResponder()
            }
            if textField == txt4 {
                txt5?.becomeFirstResponder()
            }
            if textField == txt5 {
                txt6?.becomeFirstResponder()
            }
            if textField == txt6 {
                textField.text? = string
                print("API Call Verify OTP")
                self.postOTPVerifyAPIMethod()
            }
            textField.text? = string
            return false
        }
        else
        {
            if textField == txt1 {
                txt1?.becomeFirstResponder()
            }
            if textField == txt2 {
                txt1?.becomeFirstResponder()
            }
            if textField == txt3 {
                txt2?.becomeFirstResponder()
            }
            if textField == txt4 {
                txt3?.becomeFirstResponder()
            }
            if textField == txt5 {
                txt4?.becomeFirstResponder()
            }
            if textField == txt6 {
                txt5?.becomeFirstResponder()
                print("API NOT Call Verify OTP")
            }
            textField.text? = string
            return false
        }
    }
    
    //MARK: - post OTP Request API method
    func postOTPRequestAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let parameters = ["countrycode": strcountrycode,"mobileno": strmobileno]as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod87)
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
                            /*let uiAlert = UIAlertController(title: "", message: "OTP has been sent to your mobile number." , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))*/
                            self.lblsmshasbeensent.isHidden = false
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
    
    //MARK: - post OTP Verify API method
    func postOTPVerifyAPIMethod()
    {
        let strverifycode = String(format: "%@%@%@%@%@%@", txt1.text!,txt2.text!,txt3.text!,txt4.text!,txt5.text!,txt6.text!)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let parameters = ["mobileno": strmobileno,"verificationcode": strverifycode]as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod6)
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
                            //Go to Reset Password page
                            let obj = passwordupdatesubmit(nibName: "passwordupdatesubmit", bundle: nil)
                            obj.strcountrycode = self.strcountrycode
                            obj.strmobileno = self.strmobileno
                            obj.strpageidentifier = self.strpageidentifier
                            self.navigationController?.pushViewController(obj, animated: true)
                            
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
