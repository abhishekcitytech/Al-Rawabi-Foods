//
//  registrationclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 20/06/22.
//

import UIKit

class registrationclass: BaseViewController,UIScrollViewDelegate,UITextFieldDelegate,DataBackDelegate1
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var viewscroll: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgvregbanner: UIImageView!
    @IBOutlet weak var lblregister: UILabel!
    @IBOutlet weak var lblquicklycreateaccount: UILabel!
    
    @IBOutlet weak var viewfirstname: UIView!
    @IBOutlet weak var viewfirstname1: UIView!
    @IBOutlet weak var txtfirstname: UITextField!
    
    @IBOutlet weak var viewlastname: UIView!
    @IBOutlet weak var viewlastname1: UIView!
    @IBOutlet weak var txtlastname: UITextField!
    
    @IBOutlet weak var viewemil: UIView!
    @IBOutlet weak var viewemil1: UIView!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnemailverified: UIButton!
    
    @IBOutlet weak var viewmobile: UIView!
    @IBOutlet weak var viewmobile1: UIView!
    @IBOutlet weak var lblmobilecountrycode: UILabel!
    @IBOutlet weak var txtmobile: UITextField!
    @IBOutlet weak var btnverifynow: UIButton!
    
    @IBOutlet weak var viewpassword: UIView!
    @IBOutlet weak var viewpassword1: UIView!
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var viewconfirmpassword: UIView!
    @IBOutlet weak var viewconfirmpassword1: UIView!
    @IBOutlet weak var txtconfirmpassword: UITextField!
    
    @IBOutlet weak var btnshowhidepassword1: UIButton!
    @IBOutlet weak var btnshowhidepassword2: UIButton!
    
    @IBOutlet weak var lblor: UILabel!
    @IBOutlet weak var btnregister: UIButton!
    @IBOutlet weak var btnlogin: UIButton!
    
    var boolverifiedmobileno = false
    
    // MARK: - Verify OTP record Back Delegate Method
    func savePreferences1(preferisget: Bool)
    {
        print("preferisget",preferisget)
        self.boolverifiedmobileno = preferisget
        
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
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
        
        //FIXMESANDIPAN
        //self.txtpassword.text = "123456"
        //self.txtconfirmpassword.text = "123456"
        
   
        self.scrolloverall.backgroundColor = .white
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.scrolloverall.frame.size.width, height: self.viewscroll.frame.size.height - 235)
        
        viewfirstname.layer.cornerRadius = 3.0
        viewfirstname.layer.masksToBounds = true
        viewlastname.layer.cornerRadius = 3.0
        viewlastname.layer.masksToBounds = true
        
        viewemil.layer.borderWidth = 1.0
        viewemil.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewemil.layer.cornerRadius = 3.0
        viewemil.layer.masksToBounds = true
        
        viewmobile.layer.cornerRadius = 3.0
        viewmobile.layer.masksToBounds = true
        viewpassword.layer.cornerRadius = 3.0
        viewpassword.layer.masksToBounds = true
        viewconfirmpassword.layer.cornerRadius = 3.0
        viewconfirmpassword.layer.masksToBounds = true
        
        self.btnemailverified.isHidden = true
        
        txtfirstname.setLeftPaddingPoints(10)
        txtlastname.setLeftPaddingPoints(10)
        txtemail.setLeftPaddingPoints(10)
        txtmobile.setLeftPaddingPoints(10)
        txtpassword.setLeftPaddingPoints(10)
        txtconfirmpassword.setLeftPaddingPoints(10)
        
        btnregister.layer.cornerRadius = 22.0
        btnregister.layer.masksToBounds = true
        
        btnverifynow.layer.borderWidth = 1.0
        btnverifynow.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnverifynow.layer.cornerRadius = 4.0
        btnverifynow.layer.masksToBounds = true
        
        btnlogin.layer.borderWidth = 1.0
        btnlogin.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnlogin.layer.cornerRadius = 22.0
        btnlogin.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtmobile.inputAccessoryView = toolbarDone
    }
    
    //MARK: -  press Back method
    @IBAction func pressBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - press Show Hide Password Method
    @IBAction func pressShowHidePassword(_ sender: Any)
    {
        if btnshowhidepassword1.isSelected == true
        {
            btnshowhidepassword1.isSelected = false
            self.txtpassword.isSecureTextEntry = true
        }
        else{
            btnshowhidepassword1.isSelected = true
            self.txtpassword.isSecureTextEntry = false
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
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblregister.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language15"))
        lblquicklycreateaccount.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language16"))
       
        btnlogin.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language278")), for: .normal)
        btnregister.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language24")), for: .normal)
        
        self.txtfirstname.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language28"))
        self.txtlastname.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language29"))
        self.txtemail.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language30"))
        self.txtmobile.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language31"))
        self.txtpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language32"))
        self.txtconfirmpassword.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language33"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            lblregister.textAlignment = .left
            lblquicklycreateaccount.textAlignment = .left
            
            self.viewfirstname1.frame = CGRect(x: 1, y: self.viewfirstname1.frame.origin.y, width: self.viewfirstname1.frame.size.width, height: self.viewfirstname1.frame.size.height)
            self.txtfirstname.frame = CGRect(x: 54, y: self.txtfirstname.frame.origin.y, width: self.txtfirstname.frame.size.width, height: self.txtfirstname.frame.size.height)
            self.txtfirstname.textAlignment = .left
            
            self.viewlastname1.frame = CGRect(x: 1, y: self.viewlastname1.frame.origin.y, width: self.viewlastname1.frame.size.width, height: self.viewlastname1.frame.size.height)
            self.txtlastname.frame = CGRect(x: 54, y: self.txtlastname.frame.origin.y, width: self.txtlastname.frame.size.width, height: self.txtlastname.frame.size.height)
            self.txtlastname.textAlignment = .left
            
            self.viewemil1.frame = CGRect(x: 1, y: self.viewemil1.frame.origin.y, width: self.viewemil1.frame.size.width, height: self.viewemil1.frame.size.height)
            self.txtemail.frame = CGRect(x: 54, y: self.txtemail.frame.origin.y, width: self.txtemail.frame.size.width, height: self.txtemail.frame.size.height)
            self.txtemail.textAlignment = .left
            self.btnemailverified.frame = CGRect(x: self.viewemil.frame.size.width - self.btnemailverified.frame.size.width - 4, y: self.btnemailverified.frame.origin.y, width: self.btnemailverified.frame.size.width, height: self.btnemailverified.frame.size.height)
            
            self.viewmobile1.frame = CGRect(x: 1, y: self.viewmobile1.frame.origin.y, width: self.viewmobile1.frame.size.width, height: self.viewmobile1.frame.size.height)
            self.lblmobilecountrycode.frame = CGRect(x: 54, y: self.lblmobilecountrycode.frame.origin.y, width: self.lblmobilecountrycode.frame.size.width, height: self.lblmobilecountrycode.frame.size.height)
            self.txtmobile.frame = CGRect(x: self.lblmobilecountrycode.frame.maxX, y: self.txtmobile.frame.origin.y, width: self.txtmobile.frame.size.width, height: self.txtmobile.frame.size.height)
            self.txtmobile.textAlignment = .left
            self.btnverifynow.frame = CGRect(x: self.viewmobile.frame.size.width - self.btnverifynow.frame.size.width - 10, y: self.btnverifynow.frame.origin.y, width: self.btnverifynow.frame.size.width, height: self.btnverifynow.frame.size.height)
            
            self.viewpassword1.frame = CGRect(x: 1, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            self.txtpassword.frame = CGRect(x: 54, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .left
            
            self.viewconfirmpassword1.frame = CGRect(x: 1, y: self.viewconfirmpassword1.frame.origin.y, width: self.viewconfirmpassword1.frame.size.width, height: self.viewconfirmpassword1.frame.size.height)
            self.txtconfirmpassword.frame = CGRect(x: 54, y: self.txtconfirmpassword.frame.origin.y, width: self.txtconfirmpassword.frame.size.width, height: self.txtconfirmpassword.frame.size.height)
            self.txtconfirmpassword.textAlignment = .left
            
            self.btnshowhidepassword1.frame = CGRect(x: self.txtpassword.frame.size.width - 5, y: self.btnshowhidepassword1.frame.origin.y, width: self.btnshowhidepassword1.frame.size.width, height: self.btnshowhidepassword1.frame.size.height)
            
            self.btnshowhidepassword2.frame = CGRect(x: self.txtconfirmpassword.frame.size.width - 5, y: self.btnshowhidepassword2.frame.origin.y, width: self.btnshowhidepassword2.frame.size.width, height: self.btnshowhidepassword2.frame.size.height)
            
        }
        else
        {
            lblregister.textAlignment = .right
            lblquicklycreateaccount.textAlignment = .right
            
            self.viewfirstname1.frame = CGRect(x: self.viewfirstname.frame.size.width - 53, y: self.viewfirstname1.frame.origin.y, width: self.viewfirstname1.frame.size.width, height: self.viewfirstname1.frame.size.height)
            self.txtfirstname.frame = CGRect(x: 1, y: self.txtfirstname.frame.origin.y, width: self.txtfirstname.frame.size.width, height: self.txtfirstname.frame.size.height)
            self.txtfirstname.textAlignment = .right
            
            self.viewlastname1.frame = CGRect(x: self.viewlastname.frame.size.width - 53, y: self.viewlastname1.frame.origin.y, width: self.viewlastname1.frame.size.width, height: self.viewlastname1.frame.size.height)
            self.txtlastname.frame = CGRect(x: 1, y: self.txtlastname.frame.origin.y, width: self.txtlastname.frame.size.width, height: self.txtlastname.frame.size.height)
            self.txtlastname.textAlignment = .right
            
            self.viewemil1.frame = CGRect(x: self.viewemil.frame.size.width - 53, y: self.viewemil1.frame.origin.y, width: self.viewemil1.frame.size.width, height: self.viewemil1.frame.size.height)
            self.txtemail.frame = CGRect(x: 1, y: self.txtemail.frame.origin.y, width: self.txtemail.frame.size.width, height: self.txtemail.frame.size.height)
            self.txtemail.textAlignment = .right
            self.btnemailverified.frame = CGRect(x: 8, y: self.btnemailverified.frame.origin.y, width: self.btnemailverified.frame.size.width, height: self.btnemailverified.frame.size.height)
            
            self.viewmobile1.frame = CGRect(x: self.viewmobile.frame.size.width - 53, y: self.viewmobile1.frame.origin.y, width: self.viewmobile1.frame.size.width, height: self.viewmobile1.frame.size.height)
            self.txtmobile.frame = CGRect(x: 1, y: self.txtmobile.frame.origin.y, width: self.txtmobile.frame.size.width, height: self.txtmobile.frame.size.height)
            self.txtmobile.textAlignment = .right
            self.lblmobilecountrycode.frame = CGRect(x: self.txtmobile.frame.maxX, y: self.lblmobilecountrycode.frame.origin.y, width: self.lblmobilecountrycode.frame.size.width, height: self.lblmobilecountrycode.frame.size.height)
            self.btnverifynow.frame = CGRect(x: 10, y: self.btnverifynow.frame.origin.y, width: self.btnverifynow.frame.size.width, height: self.btnverifynow.frame.size.height)
            
            self.viewpassword1.frame = CGRect(x: self.viewpassword.frame.size.width - 53, y: self.viewpassword1.frame.origin.y, width: self.viewpassword1.frame.size.width, height: self.viewpassword1.frame.size.height)
            self.txtpassword.frame = CGRect(x: 1, y: self.txtpassword.frame.origin.y, width: self.txtpassword.frame.size.width, height: self.txtpassword.frame.size.height)
            self.txtpassword.textAlignment = .right
            
            self.viewconfirmpassword1.frame = CGRect(x: self.viewconfirmpassword.frame.size.width - 53, y: self.viewconfirmpassword1.frame.origin.y, width: self.viewconfirmpassword1.frame.size.width, height: self.viewconfirmpassword1.frame.size.height)
            self.txtconfirmpassword.frame = CGRect(x: 1, y: self.txtconfirmpassword.frame.origin.y, width: self.txtconfirmpassword.frame.size.width, height: self.txtconfirmpassword.frame.size.height)
            self.txtconfirmpassword.textAlignment = .right
            
            self.btnshowhidepassword1.frame = CGRect(x: 10, y: self.btnshowhidepassword1.frame.origin.y, width: self.btnshowhidepassword1.frame.size.width, height: self.btnshowhidepassword1.frame.size.height)
            
            self.btnshowhidepassword2.frame = CGRect(x: 10, y: self.btnshowhidepassword2.frame.origin.y, width: self.btnshowhidepassword2.frame.size.width, height: self.btnshowhidepassword2.frame.size.height)
        }
        
        if self.boolverifiedmobileno == true
        {
            self.lblmobilecountrycode.isUserInteractionEnabled = false
            self.txtmobile.isUserInteractionEnabled = false
            self.btnverifynow.isUserInteractionEnabled = false
            
            self.btnverifynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language18")), for: .normal)
            
            self.lblmobilecountrycode.backgroundColor = .clear
            self.txtmobile.backgroundColor = .clear
        }
        else{
            self.lblmobilecountrycode.isUserInteractionEnabled = true
            self.txtmobile.isUserInteractionEnabled = true
            self.btnverifynow.isUserInteractionEnabled = true
            
            self.btnverifynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language17")), for: .normal)
            
            self.lblmobilecountrycode.backgroundColor = .white
            self.txtmobile.backgroundColor = .white
        }
        
        self.lblor.text = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language19"))
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtmobile.resignFirstResponder()
    }

    //MARK: - pressverifynow method
    @IBAction func pressverifynow(_ sender: Any) {
        print("pressverifynow")
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtmobile.text?.count == 9{
            
            print("countrycode",lblmobilecountrycode.text!)
            print("mobile",txtmobile.text!)
            
            let obj = otpverifyclass(nibName: "otpverifyclass", bundle: nil)
            obj.strcountrycode = "971" //FIXMESANDIPAN
            obj.strmobileno = txtmobile.text!
            obj.delegate = self
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
    
    // MARK: - presslogin Method
    @IBAction func presslogin(_ sender: Any) {
        print("presslogin")
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - press register Method
    @IBAction func pressregister(_ sender: Any)
    {
        print("pressregister")
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
        else if txtemail.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language8"), preferredStyle: UIAlertController.Style.alert)
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
        else if txtpassword.text == ""
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
        else if txtpassword.text != txtconfirmpassword.text
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language12"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if self.isValidEmail(emailStr: txtemail.text!) == false
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language13"), preferredStyle: UIAlertController.Style.alert)
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
        else if self.boolverifiedmobileno != true
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language368"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postRegistrationDetailsAPImethod()
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
                    self.postUniqueEmailValidationAPImethod(stremailaddress:txtemail.text!)
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
        if textField.isEqual(txtmobile) {
            let maxLength = 9 //FIXMESANDIPAN
            let currentString: NSString = txtmobile.text! as NSString
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
    
    //MARK: - post Unique Email Address Validation API method
    func postUniqueEmailValidationAPImethod(stremailaddress:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let parameters = ["customerEmail": txtemail.text!] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod3)
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
                    self.btnemailverified.isHidden = true
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
                    let strcustomerStatus = String(format: "%@", dictemp.value(forKey: "customerStatus")as! CVarArg)
                    print("strstatus",strstatus)
                    print("strcustomerStatus",strcustomerStatus)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if strcustomerStatus == "1"
                            {
                                //Customer Already Exist
                                //NonVerified
                                self.btnemailverified.isHidden = true
                                
                                self.btnregister.isUserInteractionEnabled = false
                                
                                let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                                self.present(uiAlert, animated: true, completion: nil)
                                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                    print("Click of default button")
                                }))
                            }
                            else{
                                //Customer does not Exist. Its NEW Customer
                                //Verified
                                
                                self.btnregister.isUserInteractionEnabled = true
                                
                                self.btnemailverified.isHidden = false
                            }
                        }
                        else{
                            self.btnemailverified.isHidden = true
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.btnemailverified.isHidden = true
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post registration details API method
    func postRegistrationDetailsAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let parameters = ["firstName": txtfirstname.text!,
        "lastName": txtlastname.text!,
        "email": txtemail.text!,
        "countryCode": "971",
        "mobileNo": txtmobile.text!,
        "password": txtpassword.text!]
        as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod4)
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
                    self.btnemailverified.isHidden = true
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.postLoginAPImethod()
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
                    self.btnemailverified.isHidden = true
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
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
        

        let parameters = ["emailId": txtemail.text!,
                          "password":txtpassword.text!,
                          "deviceId":struniquedeviceid,
                          "deviceToken":strfcmToken,
                          "deviceType":"I",] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod1)
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
