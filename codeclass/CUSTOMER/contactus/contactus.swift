//
//  contactus.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit
import MessageUI

class contactus: BaseViewController,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewname: UIView!
    @IBOutlet weak var viewname1: UIView!
    @IBOutlet weak var txtname: UITextField!
    
    @IBOutlet weak var viewemil: UIView!
    @IBOutlet weak var viewemil1: UIView!
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var viewmobile: UIView!
    @IBOutlet weak var viewmobile1: UIView!
    @IBOutlet weak var lblmobilecountrycode: UILabel!
    @IBOutlet weak var txtmobile: UITextField!
    
    @IBOutlet weak var lblwhatsinyourmind: UILabel!
    @IBOutlet weak var txtvcomments: UITextView!
    
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblphoneno: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var btncallfunction: UIButton!
    @IBOutlet weak var btnemailfunction: UIButton!
    
    var strPagename = String()
    
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
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = strPagename
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        lblphoneno.text = String(format: "%@", Constants.conn.STATISCALLNO)
        lblemail.text = String(format: "%@", Constants.conn.STATISEMAILID)
        
        
        self.scrolloverall.backgroundColor = .white
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.scrolloverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        viewname.layer.cornerRadius = 3.0
        viewname.layer.masksToBounds = true
        viewemil.layer.cornerRadius = 3.0
        viewemil.layer.masksToBounds = true
        viewmobile.layer.cornerRadius = 3.0
        viewmobile.layer.masksToBounds = true
        txtvcomments.layer.cornerRadius = 3.0
        txtvcomments.layer.masksToBounds = true
        
        btnsubmit.layer.borderWidth = 1.0
        btnsubmit.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        btnsubmit.layer.cornerRadius = 22.0
        btnsubmit.layer.masksToBounds = true
        
        txtname.setLeftPaddingPoints(10)
        txtemail.setLeftPaddingPoints(10)
        txtmobile.setLeftPaddingPoints(10)
        
        txtvcomments.layer.borderWidth = 1.0
        txtvcomments.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtvcomments.layer.cornerRadius = 4.0
        txtvcomments.layer.masksToBounds = true
        
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
        
        txtname.placeholder = myAppDelegate.changeLanguage(key: "msg_language390")
        txtemail.placeholder = myAppDelegate.changeLanguage(key: "msg_language30")
        txtmobile.placeholder = myAppDelegate.changeLanguage(key: "msg_language31")
        lblwhatsinyourmind.text = myAppDelegate.changeLanguage(key: "msg_language391")
        
        btnsubmit.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language178")), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            
        }
        else
        {
            
        }
    }
    
    //MARK: - press Call / Email Function Method
    @IBAction func presscallfunction(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language456"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            let phoneNumberVariable = Constants.conn.STATISCALLNO
            let formattedNumber = phoneNumberVariable.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
            if let url = NSURL(string: ("tel:" + (formattedNumber))) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func pressemailfunction(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language457"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            composeVC.setToRecipients([String(format: "%@", lblemail.text!)])
            composeVC.setSubject(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language454")))
            self.parent?.present(composeVC, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - press Submit Method
    @IBAction func pressSubmit(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language397"), preferredStyle: UIAlertController.Style.alert)
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
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language9"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtvcomments.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language398"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postContactusAPImethod()
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
    
    // MARK: - TextView Delegate Method
    func textViewDidBeginEditing(_ textView: UITextView)
    {
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: - post ContactUs API method
    func postContactusAPImethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["name": self.txtname.text!,
                          "email": self.txtemail.text!,
                          "phonenumber": self.txtmobile.text!,
                          "comment": self.txtvcomments.text!] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod102)
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
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.txtname.text = ""
                            self.txtemail.text = ""
                            self.txtmobile.text = ""
                            self.txtvcomments.text = ""
                            
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                            
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
}
