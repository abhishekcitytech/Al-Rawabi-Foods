//
//  addnewaddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class addnewaddress: UIViewController,UITextFieldDelegate,UITextViewDelegate
{
    @IBOutlet var viewoverall: UIView!
    @IBOutlet var scrolloverall: UIScrollView!
    
    @IBOutlet var viewfirstname: UIView!
    @IBOutlet var txtfirstname: UITextField!
    @IBOutlet var viewlastname: UIView!
    @IBOutlet var txtlastname: UITextField!
    @IBOutlet var viewmobileno: UIView!
    @IBOutlet var txtmobileno: UITextField!
    @IBOutlet var viewlocation: UIView!
    @IBOutlet var txtlocation: UITextField!
    @IBOutlet var viewcountry: UIView!
    @IBOutlet var txtcountry: UITextField!
    @IBOutlet var viewcity: UIView!
    @IBOutlet var txtcity: UITextField!
    @IBOutlet var viewstreetaddress: UIView!
    @IBOutlet var txtstreetaddress: UITextView!
    
    @IBOutlet weak var lblpreciselocationdetails: UILabel!
    @IBOutlet weak var btncurrentlocation: UIButton!
    
    @IBOutlet weak var switchmakedefault: UISwitch!
    @IBOutlet weak var switchformaid: UISwitch!
    
    @IBOutlet weak var btnsaveaddresspopup: UIButton!
    
    var strstreetaddressfrommap = ""
    var strstreetaddressfrommapLocation = ""
    var strstreetaddressfrommapCity = ""
    
    var strisdefaultaddress = "0"
    var strisformaid = "0"

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
        
        if strstreetaddressfrommap != ""{
            //Fetch from MAP ADDRESS
            self.txtstreetaddress.text = strstreetaddressfrommap
            self.txtlocation.text = strstreetaddressfrommapLocation
            self.txtcity.text = strstreetaddressfrommapCity
            
        }
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Add Address"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .clear
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        btnsaveaddresspopup.layer.cornerRadius = 18.0
        btnsaveaddresspopup.layer.masksToBounds = true
        
        btncurrentlocation.layer.cornerRadius = 6.0
        btncurrentlocation.layer.masksToBounds = true
        
        self.txtcountry.isUserInteractionEnabled = false
        self.txtcountry.text = "United Arab Emirates"
        
        strisdefaultaddress = "0"
        switchmakedefault.isOn = false
        strisformaid = "0"
        switchformaid.isOn = false
        
        createbordersetup()
    }
    
    //MARK: - create curve border setup method
    @objc func createbordersetup()
    {
        viewfirstname.layer.borderWidth = 1.0
        viewfirstname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewfirstname.layer.cornerRadius = 6.0
        viewfirstname.layer.masksToBounds = true
        
        viewlastname.layer.borderWidth = 1.0
        viewlastname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlastname.layer.cornerRadius = 6.0
        viewlastname.layer.masksToBounds = true
        
        
        viewmobileno.layer.borderWidth = 1.0
        viewmobileno.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewmobileno.layer.cornerRadius = 6.0
        viewmobileno.layer.masksToBounds = true
        
        viewlocation.layer.borderWidth = 1.0
        viewlocation.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlocation.layer.cornerRadius = 6.0
        viewlocation.layer.masksToBounds = true
        
        viewcountry.layer.borderWidth = 1.0
        viewcountry.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcountry.layer.cornerRadius = 6.0
        viewcountry.layer.masksToBounds = true
        
        viewcity.layer.borderWidth = 1.0
        viewcity.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcity.layer.cornerRadius = 6.0
        viewcity.layer.masksToBounds = true
        
        viewstreetaddress.layer.borderWidth = 1.0
        viewstreetaddress.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewstreetaddress.layer.cornerRadius = 6.0
        viewstreetaddress.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtmobileno.inputAccessoryView = toolbarDone
        
        txtstreetaddress.text = "Street Address"
        txtstreetaddress.textColor = UIColor.lightGray
        txtstreetaddress.centerVertically()
      
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtmobileno.resignFirstResponder()
    }
    
    //MARK: - press add new address method
    @IBAction func pressaddnewaddress(_ sender: Any)
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
        else if txtmobileno.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your mobile number", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtstreetaddress.text == "" || txtstreetaddress.text == "Street Address"
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your Street address", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlocation.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your location", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcity.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your city", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcountry.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your country", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postAddNewAddressAPIMethod()
        }
    }
    
    //MARK: - press make default method
    @IBAction func pressmakedefault(_ sender: Any)
    {
        if switchmakedefault.isOn == true
        {
            strisdefaultaddress = "1"
        }
        else{
            strisdefaultaddress = "0"
        }
    }
    
    //MARK: - press for maid method
    @IBAction func pressformaid(_ sender: Any)
    {
        if switchformaid.isOn == true
        {
            strisformaid = "1"
        }
        else{
            strisformaid = "0"
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
        if textField.isEqual(txtmobileno) {
            let maxLength = 10
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
    
    // MARK: - TextView Delegate Method
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtstreetaddress.textColor == UIColor.lightGray {
            txtstreetaddress.text = nil
            txtstreetaddress.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if txtstreetaddress.text.isEmpty {
            txtstreetaddress.text = "Street Address"
            txtstreetaddress.textColor = UIColor.lightGray
            }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: - press Current Location Method
    @IBAction func pressCurrentlocationmethod(_ sender: Any)
    {
        let ctrl = mapaddress(nibName: "mapaddress", bundle: nil)
        ctrl.strFrompageMap = "addnewaddress"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - post add new address API Method
    func postAddNewAddressAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
       
        let parameters = ["firstname": self.txtfirstname.text!,
                          "lastname": self.txtlastname.text!,
                          "telephone": self.txtmobileno.text!,
                          "street": self.txtstreetaddress.text!,
                          "region": self.txtcity.text!,
                          "city": self.txtcity.text!,
                          "countryid": "AE",
                          "latitude": "",
                          "longitude": "",
                          "isdefaultaddress": strisdefaultaddress
                          ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod25)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_networkerror") , preferredStyle: UIAlertController.Style.alert)
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
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let uiAlert = UIAlertController(title: "", message: "Your address has been added succesfully." , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))

                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
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
extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
