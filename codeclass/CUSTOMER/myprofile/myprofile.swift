//
//  myprofile.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class myprofile: BaseViewController,UIScrollViewDelegate,UITextFieldDelegate
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
    @IBOutlet weak var txtmobile: UITextField!
    
    @IBOutlet weak var btnupdatesave: UIButton!
    
    var dicprofiledetails = NSMutableDictionary()
    
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
        // Do any additional setup after loading the view.
        self.title = "Profile Details"
        
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
        
        
        btnupdatesave.layer.cornerRadius = 16.0
        btnupdatesave.layer.masksToBounds = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    //MARK: - press Update Save Method
    @IBAction func pressUpdateSave(_ sender: Any)
    {
        if txtfirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your first name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your last name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtemail.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your email", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if self.isValidEmail(emailStr: txtemail.text!) == false
        {
            let uiAlert = UIAlertController(title: "", message: "please enter valid email address", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            print("update successfull")
        }
    }
    

    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == txtemail
        {
            //verify email
            if txtemail.text != ""
            {
                if self.isValidEmail(emailStr: txtemail.text!) == false
                {
                    let uiAlert = UIAlertController(title: "", message: "please enter valid email address", preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod46)
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
                                if strattributecode.containsIgnoreCase("mobile")
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
                            self.txtmobile.text = String(format: "%@ %@", strfullmobilenocode,strfullmobileno)
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
