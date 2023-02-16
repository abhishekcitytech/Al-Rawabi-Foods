//
//  CreateOrderViewControllerRW.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 29/11/22.
//

import UIKit
import PassKit
import SwiftyJSON
import NISdk

class CreateOrderViewControllerRW: UIViewController
{
    let paymentAmount: Double
    let cardPaymentDelegate: CardPaymentDelegate?
    // let paymentMethod: PaymentMethod?
    // let purchasedItems: [Product]
    var paymentRequest: PKPaymentRequest?
    var tokenForOrder = ""
    let referance:String
    var cardPaymentCtrl:rechargewallet?
    
    init(paymentAmount: Double,refNumber:String, and cardPaymentDelegate: CardPaymentDelegate) {
        
        self.cardPaymentDelegate = cardPaymentDelegate
        self.paymentAmount = paymentAmount
        self.referance = refNumber
        //self.paymentMethod = paymentMethod
        //self.purchasedItems = purchasedItems
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissVC() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func displayErrorAndClose(error: Error?) {
        var errorTitle = ""
        if let error = error {
            let userInfo: [String: Any] = (error as NSError).userInfo
            errorTitle = userInfo["NSLocalizedDescription"] as? String ?? "Unknown Error"
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: errorTitle, message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [weak self] _ in self?.dismissVC() }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func createOrder()
    {
        
        let dicuser = UserDefaults.standard.value(forKey: "customerdetails")as! NSDictionary
        print("dicuser",dicuser)
        let strfirstname = String(format: "%@", dicuser.value(forKey: "firstname")as? String ?? "")
        let strlastname = String(format: "%@", dicuser.value(forKey: "lastname")as? String ?? "")
        let stremail = String(format: "%@", dicuser.value(forKey: "email")as? String ?? "")
        
        let bfirstName = strfirstname
        let blastName = strlastname
        let bemail = stremail
        
        // Multiply amount always by 100 while creating an order
        // let token = UserDefaults.standard.value(forKey: "auth") as? String ?? ""
        let amount:Int = Int(paymentAmount * 100)
        // "reference": "9662e6bd-729d-4ec9-b56b-391df748106c",
        var orderRequest:Orderrequest2
        
        orderRequest = Orderrequest2(action: "SALE", amount: Orderamount2(currencyCode: "AED", value:amount ), emailAddress: bemail, firstname: bfirstName, lastname: blastName)
        
        let encoder = JSONEncoder()
        let orderRequestData = try! encoder.encode(orderRequest)
        
        print("orderRequest",orderRequest)
        
        //  let headers = ["Content-Type": "application/json"]
        // let headers = ["Authorization":"Bearer \(token)", "Content-Type":"application/json","Accept":"application/json"]
        
        let headers = [ "Content-Type":"application/json","Accept":"application/json"]
        let jsonString = NSString(data: orderRequestData, encoding: String.Encoding.utf8.rawValue)! as String
        
        print("jsonString",jsonString)

        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod45)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 100.0)

        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = orderRequestData
        print("strconnurl",strconnurl)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) in
            if (error != nil) {
                self?.displayErrorAndClose(error: error)
            }
            if let data = data {
                do {
                    let orderResponse: OrderResponse = try JSONDecoder().decode(OrderResponse.self, from: data)
                    let sharedSDKInstance = NISdk.sharedInstance
                    
                    DispatchQueue.main.async {
                        
                        // let httpResponse = response as? HTTPURLResponse
                        let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
                        print("Order response:",jsonString)
                        
                        self?.dismiss(animated: false, completion: { [weak self] in
                            
                            self?.cardPaymentCtrl?.CardOutletId = orderResponse.outletId!
                            self?.cardPaymentCtrl?.CardReference = orderResponse.reference!
                            
                            sharedSDKInstance.showCardPaymentViewWith(cardPaymentDelegate: (self?.cardPaymentDelegate!)!,
                                                                      overParent: self?.cardPaymentDelegate as! UIViewController,for: orderResponse)
                            
                        })
                    }
                } catch let error {
                    self?.displayErrorAndClose(error: error)
                }
            }
        })
        dataTask.resume()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.createOrder()
    }

}
