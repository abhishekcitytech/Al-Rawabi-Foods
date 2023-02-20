//
//  myprofile.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class myprofile: BaseViewController,UIScrollViewDelegate,UITextFieldDelegate,DataBackDelegate2
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewfirstname: UIView!
    @IBOutlet weak var txtfirstname: UITextField!
    
    @IBOutlet weak var viewlastname: UIView!
    @IBOutlet weak var txtlastname: UITextField!
    
    @IBOutlet weak var viewemail: UIView!
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var viewmobile: UIView!
    @IBOutlet weak var lblmobilecountrycode: UILabel!
    @IBOutlet weak var btnverifynow: UIButton!
    @IBOutlet weak var txtmobile: UITextField!
    
    @IBOutlet weak var btnupdatesave: UIButton!
    
    var dicprofiledetails = NSMutableDictionary()
    
    var boolverifiedmobileno = false
    
    // MARK: - Verify OTP record Back Delegate Method
    func savePreferences2(preferisget: Bool)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        print("preferisget",preferisget)
        self.boolverifiedmobileno = preferisget
        
        if self.boolverifiedmobileno == true
        {
            self.txtmobile.isUserInteractionEnabled = false
            self.btnverifynow.isUserInteractionEnabled = false
            self.btnverifynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language18")), for: .normal)
        }
        else
        {
            self.txtmobile.isUserInteractionEnabled = true
            self.btnverifynow.isUserInteractionEnabled = true
            self.btnverifynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language17")), for: .normal)
        }
        
    }
    
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
        
        self.getaccountprofiledetails()
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language310")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .white
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.scrolloverall.frame.size.width, height: self.viewoverall.frame.size.height - 235)
        
        txtfirstname.setLeftPaddingPoints(10)
        txtlastname.setLeftPaddingPoints(10)
        txtemail.setLeftPaddingPoints(10)
        txtmobile.setLeftPaddingPoints(10)
        
        self.btnverifynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language17")), for: .normal)
        btnverifynow.tag = 101
        
        btnupdatesave.layer.cornerRadius = 16.0
        btnupdatesave.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtmobile.inputAccessoryView = toolbarDone
        
        setupRTLLTR()
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
         let myAppDelegate = UIApplication.shared.delegate as! AppDelegate

        txtfirstname.placeholder = myAppDelegate.changeLanguage(key: "msg_language28")
        txtlastname.placeholder = myAppDelegate.changeLanguage(key: "msg_language29")
        txtemail.placeholder = myAppDelegate.changeLanguage(key: "msg_language30")
        txtmobile.placeholder = myAppDelegate.changeLanguage(key: "msg_language31")
        
        btnupdatesave.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language392")), for: .normal)
        
         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtmobile.resignFirstResponder()
    }
    
    //MARK: - pressverifynow method
    @IBAction func pressverifynow(_ sender: Any)
    {
        print("pressverifynow")
        
        var strfullmobilenocode = ""
        var strfullmobileno = ""
        let arrm = self.dicprofiledetails.value(forKey: "custom_attributes") as? NSArray ?? []
        for x in 0 ..< arrm.count
        {
            let dic = arrm.object(at: x)as? NSDictionary
            let strattributecode = String(format: "%@", dic?.value(forKey: "attribute_code")as? String ?? "")
            if strattributecode.containsIgnoreCase("mobile")
            {
                strfullmobileno = String(format: "%@", dic?.value(forKey: "value")as? String ?? "")
            }
            if strattributecode.containsIgnoreCase("country_code")
            {
                strfullmobilenocode = String(format: "%@", dic?.value(forKey: "value")as? String ?? "")
            }
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strfullmobileno == txtmobile.text!
        {
            //Mobile no Same want to verify again
            
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language378"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            if txtmobile.text?.count == 9{
                
                print("countrycode",lblmobilecountrycode.text!)
                print("mobile",txtmobile.text!)
                
                let obj = otpverifyclass(nibName: "otpverifyclass", bundle: nil)
                obj.strcountrycode = "971" //FIXMESANDIPAN
                obj.strmobileno = txtmobile.text!
                obj.delegate2 = self
                obj.strpagefrom = "100"
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language14"), preferredStyle: UIAlertController.Style.alert)
                self.present(uiAlert, animated: true, completion: nil)
                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                    print("Click of default button")
                }))
            }
        }
        
    }
    
   
    //MARK: - press Update Save Method
    @IBAction func pressUpdateSave(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtfirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language238"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language239"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtmobile.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language240"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtmobile.text?.count != 9
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language14"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            print("update successfull")
            print("firstname",txtfirstname.text!)
            print("lastname",txtlastname.text!)
            print("countrycode","971")
            print("txtmobile",txtmobile.text!)
            
            self.postUpdateProfileDetailsAPImethod()
        }
    }
    

    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if textField == txtemail
        {
            //verify email
            if txtemail.text != ""
            {
                if self.isValidEmail(emailStr: txtemail.text!) == false
                {
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language13"), preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                }
                else{
                    //verify email validation API
                }
            }
        }
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
    
    //MARK: - get account profile details API method
    func getaccountprofiledetails()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod46,"")
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
                    //print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let dict = dictemp.value(forKey: "customerDetails")as? NSDictionary
                            self.dicprofiledetails = dict?.mutableCopy() as! NSMutableDictionary
                            print("self.dicprofiledetails",self.dicprofiledetails)
                            
                            var strfullmobilenocode = ""
                            var strfullmobileno = ""
                            let arrm = self.dicprofiledetails.value(forKey: "custom_attributes") as? NSArray ?? []
                            for x in 0 ..< arrm.count
                            {
                                let dic = arrm.object(at: x)as? NSDictionary
                                let strattributecode = String(format: "%@", dic?.value(forKey: "attribute_code")as? String ?? "")
                                if strattributecode.containsIgnoreCase("mobile") || strattributecode.containsIgnoreCase("phone_number")
                                {
                                    strfullmobileno = String(format: "%@", dic?.value(forKey: "value")as? String ?? "")
                                }
                                if strattributecode.containsIgnoreCase("country_code")
                                {
                                    strfullmobilenocode = String(format: "%@", dic?.value(forKey: "value")as? String ?? "")
                                }
                            }
                            
                            let strfirstname = String(format: "%@", self.dicprofiledetails.value(forKey: "firstname")as? String ?? "")
                            let strlastname = String(format: "%@", self.dicprofiledetails.value(forKey: "lastname")as? String ?? "")
                            let stremail = String(format: "%@", self.dicprofiledetails.value(forKey: "email")as? String ?? "")
                            
                            self.txtfirstname.text = strfirstname
                            self.txtlastname.text = strlastname
                            self.txtemail.text = stremail
                            self.txtmobile.text = String(format: "%@",strfullmobileno)
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

    //MARK: - post update profile details API method
    func postUpdateProfileDetailsAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["customerFirstName": txtfirstname.text!,
        "customerLastName": txtlastname.text!,
        "customerPhoneCountryCode": "971",
        "customerPhoneNumber": txtmobile.text!
        ]
        as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod106)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language369") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.getaccountprofiledetails()
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
