//
//  BaseViewController.swift
//  IQRAA
//
//  Created by Rajkumar Yadav on 29/11/19.
//  Copyright © 2019 Rajkumar Yadav. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*  let lbl = UILabel.init()
         lbl.text = NSLocalizedString("title", comment: "")*/
        
        // Do any additional setup after loading the view.
        
    }
    
    func setupNavLogo()
    {
        let imageV = UIImageView(image: UIImage(named: "logonav"))
        imageV.contentMode = .scaleAspectFill
        self.navigationItem.titleView = imageV
    }
    
    
    func showAleart(msg:String)  {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func isStringContainsOnlyNumbers(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}




//FIXME: need to cloce
func printSupersetu(object: Any) {
#if DEBUG
    // print(object)
#endif
}


func printDictJson(dic: NSDictionary?) {
#if DEBUG
    
    guard let di = dic else {
        return
    }
    
    let jsonData = try! JSONSerialization.data(withJSONObject: di, options: JSONSerialization.WritingOptions.prettyPrinted)
    
    let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    print(jsonString)
    
#endif
}
