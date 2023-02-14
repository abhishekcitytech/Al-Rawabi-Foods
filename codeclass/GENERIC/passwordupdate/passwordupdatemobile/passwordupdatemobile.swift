//
//  passwordupdatemobile.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/12/22.
//

import UIKit

class passwordupdatemobile: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var lblentermobileno: UILabel!
    
    @IBOutlet weak var viewmobileno: UIView!
    @IBOutlet weak var viewiconbox1: UIView!
    @IBOutlet weak var imgvicon1: UIImageView!
    @IBOutlet weak var lblcountrycode: UILabel!
    @IBOutlet weak var txtmobileno: UITextField!
    
    @IBOutlet weak var btncontinue: UIButton!
    
    var strpageidentifier = ""

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
        setupRTLLTR()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language292")
       
        //Create Back Button
        let yourBackImage = UIImage(named: "back")
        let Back = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(pressBack))
        Back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = Back
        
        viewmobileno.layer.cornerRadius = 3.0
        viewmobileno.layer.masksToBounds = true
        
        txtmobileno.setLeftPaddingPoints(10)
        
        btncontinue.layer.cornerRadius = 22.0
        btncontinue.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtmobileno.inputAccessoryView = toolbarDone
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
         let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblentermobileno.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language240"))
        
        btncontinue.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language50")), for: .normal)

        self.txtmobileno.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language31"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
        
            self.viewiconbox1.frame = CGRect(x: 1, y: self.viewiconbox1.frame.origin.y, width: self.viewiconbox1.frame.size.width, height: self.viewiconbox1.frame.size.height)
            
            self.lblcountrycode.frame = CGRect(x: self.viewiconbox1.frame.maxX, y: self.lblcountrycode.frame.origin.y, width: self.lblcountrycode.frame.size.width, height: self.lblcountrycode.frame.size.height)
            self.txtmobileno.frame = CGRect(x: self.lblcountrycode.frame.maxX, y: self.txtmobileno.frame.origin.y, width: self.txtmobileno.frame.size.width, height: self.txtmobileno.frame.size.height)
            self.txtmobileno.textAlignment = .left
            
        }
        else
        {
            
            self.viewiconbox1.frame = CGRect(x: self.viewmobileno.frame.size.width - 53, y: self.viewiconbox1.frame.origin.y, width: self.viewiconbox1.frame.size.width, height: self.viewiconbox1.frame.size.height)
            
            self.lblcountrycode.frame = CGRect(x: self.viewiconbox1.frame.minX - 44, y: self.lblcountrycode.frame.origin.y, width: self.lblcountrycode.frame.size.width, height: self.lblcountrycode.frame.size.height)
            self.txtmobileno.frame = CGRect(x: 1, y: self.txtmobileno.frame.origin.y, width: self.txtmobileno.frame.size.width, height: self.txtmobileno.frame.size.height)
            self.txtmobileno.textAlignment = .right
            
        }
    }
    
    //MARK: -  press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - press Continue Method
    @IBAction func pressContinue(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtmobileno.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language9"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtmobileno.text?.count != 10
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language14"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            
            self.lblcountrycode.text = "971" //FIXMESANDIPAN
            self.postOTPRequestAPIMethod(strcountrycode: lblcountrycode.text!, strmobileno: txtmobileno.text!)
        }
        
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtmobileno.resignFirstResponder()
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
        if textField.isEqual(txtmobileno) {
            let maxLength = 9 //FIXMESANDIPAN
            let currentString: NSString = txtmobileno.text! as NSString
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
    
    //MARK: - post OTP Request API method
    func postOTPRequestAPIMethod(strcountrycode:String,strmobileno:String)
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
                            /*let uiAlert = UIAlertController(title: "", message: "OTP has been sent to your mobile number." , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))*/
                            
                            let obj = passwordupdatemobileOTP(nibName: "passwordupdatemobileOTP", bundle: nil)
                            obj.strcountrycode = strcountrycode
                            obj.strmobileno = strmobileno
                            obj.strpageidentifier = self.strpageidentifier
                            self.navigationController?.pushViewController(obj, animated: true)
                            
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
