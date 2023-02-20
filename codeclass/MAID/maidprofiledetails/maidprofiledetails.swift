//
//  maidprofiledetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 09/12/22.
//

import UIKit

class maidprofiledetails: BaseViewController,UIScrollViewDelegate,UITextFieldDelegate
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewfirstname: UIView!
    @IBOutlet weak var viewfirstname1: UIView!
    @IBOutlet weak var txtfirstname: UITextField!
    
    @IBOutlet weak var viewlastname: UIView!
    @IBOutlet weak var viewlastname1: UIView!
    @IBOutlet weak var txtlastname: UITextField!
    
    @IBOutlet weak var viewemail: UIView!
    @IBOutlet weak var viewemail1: UIView!
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var viewmobile: UIView!
    @IBOutlet weak var viewmobile1: UIView!
    @IBOutlet weak var txtmobile: UITextField!
    
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
        
        self.txtfirstname.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language28"))
        self.txtlastname.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language29"))
        self.txtemail.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language30"))
        self.txtmobile.placeholder = String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language31"))
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            /*txtfirstname.textAlignment = .left
            txtlastname.textAlignment = .left
            txtemail.textAlignment = .left
            txtmobile.textAlignment = .left*/
            
           /* self.viewfirstname1.frame = CGRect(x: 1, y: self.viewfirstname1.frame.origin.y, width: self.viewfirstname1.frame.size.width, height: self.viewfirstname1.frame.size.height)
            self.txtfirstname.frame = CGRect(x: 54, y: self.txtfirstname.frame.origin.y, width: self.txtfirstname.frame.size.width, height: self.txtfirstname.frame.size.height)
            
            self.viewlastname1.frame = CGRect(x: 1, y: self.viewlastname1.frame.origin.y, width: self.viewlastname1.frame.size.width, height: self.viewlastname1.frame.size.height)
            self.txtlastname.frame = CGRect(x: 54, y: self.txtlastname.frame.origin.y, width: self.txtlastname.frame.size.width, height: self.txtlastname.frame.size.height)
            
            self.viewemail1.frame = CGRect(x: 1, y: self.viewemail1.frame.origin.y, width: self.viewemail1.frame.size.width, height: self.viewemail1.frame.size.height)
            self.txtemail.frame = CGRect(x: 54, y: self.txtemail.frame.origin.y, width: self.txtemail.frame.size.width, height: self.txtemail.frame.size.height)
            
            self.viewmobile1.frame = CGRect(x: 1, y: self.viewmobile1.frame.origin.y, width: self.viewmobile1.frame.size.width, height: self.viewmobile1.frame.size.height)
            self.txtmobile.frame = CGRect(x: 54, y: self.txtmobile.frame.origin.y, width: self.txtmobile.frame.size.width, height: self.txtmobile.frame.size.height)*/
            
        }
        else
        {
            /*txtfirstname.textAlignment = .right
            txtlastname.textAlignment = .right
            txtemail.textAlignment = .right
            txtmobile.textAlignment = .right*/
            
            
            
           /* self.txtfirstname.frame = CGRect(x: 1, y: self.txtfirstname.frame.origin.y, width: self.txtfirstname.frame.size.width, height: self.txtfirstname.frame.size.height)
            self.viewfirstname1.frame = CGRect(x: self.txtfirstname.frame.maxX, y: self.viewfirstname1.frame.origin.y, width: self.viewfirstname1.frame.size.width, height: self.viewfirstname1.frame.size.height)
            
            self.txtlastname.frame = CGRect(x: 1, y: self.txtlastname.frame.origin.y, width: self.txtlastname.frame.size.width, height: self.txtlastname.frame.size.height)
            self.viewlastname1.frame = CGRect(x: self.txtfirstname.frame.maxX, y: self.viewlastname1.frame.origin.y, width: self.viewlastname1.frame.size.width, height: self.viewlastname1.frame.size.height)
            
            self.txtemail.frame = CGRect(x: 1, y: self.txtemail.frame.origin.y, width: self.txtemail.frame.size.width, height: self.txtemail.frame.size.height)
            self.viewemail1.frame = CGRect(x: self.txtfirstname.frame.maxX, y: self.viewemail1.frame.origin.y, width: self.viewemail1.frame.size.width, height: self.viewemail1.frame.size.height)
            
            self.txtmobile.frame = CGRect(x: 1, y: self.txtmobile.frame.origin.y, width: self.txtmobile.frame.size.width, height: self.txtmobile.frame.size.height)
            self.viewmobile1.frame = CGRect(x: self.txtfirstname.frame.maxX, y: self.viewmobile1.frame.origin.y, width: self.viewmobile1.frame.size.width, height: self.viewmobile1.frame.size.height)
            */

        }
       
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
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
    
    //MARK: - get account profile details API method
    func getaccountprofiledetails()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
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
                            self.txtmobile.text = String(format: "%@ %@", strfullmobilenocode,strfullmobileno)
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
