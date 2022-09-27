//
//  addreviewpage.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 24/06/22.
//

import UIKit


class addreviewpage: UIViewController,UITextFieldDelegate,UITextViewDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!

    
    @IBOutlet weak var imgvpencil: UIImageView!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var viewstar: UIView!
    @IBOutlet weak var btnstar1: UIButton!
    @IBOutlet weak var btnstar2: UIButton!
    @IBOutlet weak var btnstar3: UIButton!
    @IBOutlet weak var btnstar4: UIButton!
    @IBOutlet weak var btnstar5: UIButton!
    
    @IBOutlet weak var txtenternickname: UITextField!
    @IBOutlet weak var txtreviewtitle: UITextField!
    
    @IBOutlet weak var txtvreviewcomments: UITextView!
    @IBOutlet weak var btnsubmit: UIButton!
    
    var strproductid = ""
    
    var rating = ""

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Write Reviews"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnsubmit.layer.cornerRadius = 18.0
        btnsubmit.layer.masksToBounds = true
        
        txtvreviewcomments.layer.cornerRadius = 8.0
        txtvreviewcomments.layer.borderWidth = 1.0
        txtvreviewcomments.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtvreviewcomments.layer.masksToBounds = true
        
        txtenternickname.setLeftPaddingPoints(10)
        txtenternickname.layer.cornerRadius = 8.0
        txtenternickname.layer.borderWidth = 1.0
        txtenternickname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtenternickname.layer.masksToBounds = true
        
        txtreviewtitle.setLeftPaddingPoints(10)
        txtreviewtitle.layer.cornerRadius = 8.0
        txtreviewtitle.layer.borderWidth = 1.0
        txtreviewtitle.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtreviewtitle.layer.masksToBounds = true
        
        let dicuser = UserDefaults.standard.value(forKey: "customerdetails")as! NSDictionary
        print("dicuser",dicuser)
        
        let strfirstname = String(format: "%@", dicuser.value(forKey: "firstname")as? String ?? "")
        self.txtenternickname.text = strfirstname
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: press Submit method
    @IBAction func pressSubmit(_ sender: Any)
    {
        if rating == ""{
            let uiAlert = UIAlertController(title: "", message: "Please give your rating star", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtenternickname.text == ""{
            let uiAlert = UIAlertController(title: "", message: "Please enter your Nickname", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtreviewtitle.text == ""{
            let uiAlert = UIAlertController(title: "", message: "Please enter Review Title", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtvreviewcomments.text == ""{
            let uiAlert = UIAlertController(title: "", message: "Please enter Review Comments", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postAddReviewApIMethod()
        }
    }
    
    //MARK: -  press Star Selection method
    @IBAction func pressStar1(_ sender: Any) {
        btnstar1.isSelected = true
        btnstar2.isSelected = false
        btnstar3.isSelected = false
        btnstar4.isSelected = false
        btnstar5.isSelected = false
        rating = "1"
    }
    @IBAction func pressStar2(_ sender: Any) {
        btnstar1.isSelected = true
        btnstar2.isSelected = true
        btnstar3.isSelected = false
        btnstar4.isSelected = false
        btnstar5.isSelected = false
        rating = "2"
    }
    @IBAction func pressStar3(_ sender: Any) {
        btnstar1.isSelected = true
        btnstar2.isSelected = true
        btnstar3.isSelected = true
        btnstar4.isSelected = false
        btnstar5.isSelected = false
        rating = "3"
    }
    @IBAction func pressStar4(_ sender: Any) {
        btnstar1.isSelected = true
        btnstar2.isSelected = true
        btnstar3.isSelected = true
        btnstar4.isSelected = true
        btnstar5.isSelected = false
        rating = "4"
    }
    @IBAction func pressStar5(_ sender: Any) {
        btnstar1.isSelected = true
        btnstar2.isSelected = true
        btnstar3.isSelected = true
        btnstar4.isSelected = true
        btnstar5.isSelected = true
        rating = "5"
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
    
    
    //MARK: - post Add Review API method
    func postAddReviewApIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["productId": strproductid,
                          "customerNickName": txtenternickname.text!,
                          "reviewTitle": txtreviewtitle.text!,
                          "reviewDetail": txtvreviewcomments.text!,
                          "rating": rating
         ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod14)
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
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_reviewadd") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                
                                self.rating = ""
                                
                                self.btnstar1.isSelected = false
                                self.btnstar2.isSelected = false
                                self.btnstar3.isSelected = false
                                self.btnstar4.isSelected = false
                                self.btnstar5.isSelected = false
                                
                                self.txtreviewtitle.text = ""
                                self.txtvreviewcomments.text = ""
                                
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
