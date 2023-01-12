//
//  rechargewallet.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit
import PassKit
import SwiftyJSON
import NISdk

class rechargewallet: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,CardPaymentDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    
    @IBOutlet weak var colrechargeamount: UICollectionView!
    var reuseIdentifier1 = "colcellrechargeamount"
    
    @IBOutlet weak var lblcurrency: UILabel!
    @IBOutlet weak var txtamount: UITextField!
    @IBOutlet weak var btnpayment: UIButton!
    
    var arrMamount = NSMutableArray()
    
    var strselectedamount = ""
    
    var authCode = ""
    var CardReference = ""
    var CardOutletId = ""
    var refNumber:String?

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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language222")
        
        txtamount.placeholder = myAppDelegate.changeLanguage(key: "msg_language370")
        btnpayment.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language371")), for: .normal)
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpayment.layer.cornerRadius = 18.0
        btnpayment.layer.masksToBounds = true
        
        lblcurrency.layer.borderWidth = 1.0
        lblcurrency.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        lblcurrency.layer.cornerRadius = 4.0
        lblcurrency.layer.masksToBounds = true
        
        txtamount.layer.borderWidth = 1.0
        txtamount.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtamount.layer.cornerRadius = 4.0
        txtamount.layer.masksToBounds = true
        
        txtamount.setLeftPaddingPoints(10)
        
        arrMamount = ["50","100","200","300","500"]
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colrechargeamount.frame.size.width / 4, height: 70)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        colrechargeamount.collectionViewLayout = layout
        colrechargeamount.register(UINib(nibName: "colcellrechargeamount", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colrechargeamount.showsHorizontalScrollIndicator = false
        colrechargeamount.showsVerticalScrollIndicator=false
        colrechargeamount.backgroundColor = .clear
        
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDone))
        toolbarDone.items = [barBtnDone]
        txtamount.inputAccessoryView = toolbarDone
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Done Amount method
    @objc func pressDone(sender: UIButton)
    {
        txtamount.resignFirstResponder()
    }
    
    //MARK: - press make payment method
    @IBAction func pressmakepayment(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtamount.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language372"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtamount.text == "0"
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language373"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            strselectedamount = txtamount.text!
            print("txtamount.text",txtamount.text!)
            print("strselectedamount",strselectedamount)
            
            let dblTotal  = (self.strselectedamount as NSString).doubleValue
            print("dblTotal",dblTotal)
            
            let orderCreationViewController = CreateOrderViewControllerRW(paymentAmount: dblTotal, refNumber: refNumber ?? "", and: self)
            orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            orderCreationViewController.modalPresentationStyle = .overCurrentContext
            orderCreationViewController.cardPaymentCtrl = self
            self.present(orderCreationViewController, animated: false, completion: nil)
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
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrMamount.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellrechargeamount
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let stramount = String(format: "%@", arrMamount.object(at: indexPath.row)as? String ?? "")
        cellA.lblamount.text = stramount
        
        if strselectedamount == stramount
        {
            cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 4.0
            cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        else{
            cellA.viewcell.backgroundColor = .white
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        
       
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let stramount = String(format: "%@", arrMamount.object(at: indexPath.row)as? String ?? "")
        strselectedamount = stramount
        txtamount.text = strselectedamount
        colrechargeamount.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    
    //MARK: - NI SDK DELEGATE METHOD
    func paymentDidCompleteWithAuthCode(with status: PaymentStatus, authCode:String)
    {
        print("authCode",authCode)
        self.authCode = authCode
        paymentDidComplete(with: status)
    }
    @objc func paymentDidComplete(with status: PaymentStatus) {
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        print("status",status)
        self.view.backgroundColor = .white
        
        if(status == .PaymentSuccess)
        {
            print("Success")
            
            print("CardReference >> ",CardReference)
            print("CardOutletId >>",CardOutletId)
            
            self.postPlaceOrder(stramount: txtamount.text!)
         
        }
        else if(status == .PaymentFailed)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language348") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
        }
        else if(status == .PaymentCancelled)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language349") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
        }
    }
    
    //MARK: - post Place Order API Recharge method
    func postPlaceOrder(stramount:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)

        let parameters = ["currency": "AED","amount":stramount] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod74)
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
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language374"), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.txtamount.text = ""
                                self.navigationController?.popViewController(animated: true)
                            }))
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
