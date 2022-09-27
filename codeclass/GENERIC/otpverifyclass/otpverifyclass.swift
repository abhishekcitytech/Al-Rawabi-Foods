//
//  otpverifyclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 16/05/22.
//

import UIKit

class otpverifyclass: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!

    @IBOutlet weak var lblenterotp: UILabel!
    @IBOutlet weak var lblsmshasbeensent: UILabel!
    @IBOutlet weak var lbldidnotreceivecode: UILabel!
    @IBOutlet weak var btnresendcode: UIButton!
    
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!

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
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Verify Number"
        
        //Create Back Button
        let yourBackImage = UIImage(named: "back")
        let Back = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(pressBack))
        Back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = Back
        
        txt1.layer.borderWidth = 1.0
        txt1.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt1.layer.cornerRadius = 4.0
        txt1.layer.masksToBounds = true
        
        txt2.layer.borderWidth = 1.0
        txt2.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt2.layer.cornerRadius = 4.0
        txt2.layer.masksToBounds = true
        
        txt3.layer.borderWidth = 1.0
        txt3.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt3.layer.cornerRadius = 4.0
        txt3.layer.masksToBounds = true
        
        txt4.layer.borderWidth = 1.0
        txt4.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt4.layer.cornerRadius = 4.0
        txt4.layer.masksToBounds = true
        
        txt5.layer.borderWidth = 1.0
        txt5.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txt5.layer.cornerRadius = 4.0
        txt5.layer.masksToBounds = true
        
        if #available(iOS 12.0, *) {
            self.txt1.textContentType = .oneTimeCode
        }
        self.txt1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txt1.becomeFirstResponder()
        
    }
    
    //MARK: -  press Back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: -  pressresendcode method
    @IBAction func pressresendcode(_ sender: Any) {
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField){
    }
    func textFieldDidEndEditing(_ textField: UITextField){
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if #available(iOS 12.0, *) {
            if textField.textContentType == UITextContentType.oneTimeCode{
                //here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count > 4{
                    txt1.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
                    txt2.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                    txt3.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                    txt4.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
                    txt5.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 4)])
                }
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count == 1)
        {
            if textField == txt1 {
                txt2?.becomeFirstResponder()
            }
            if textField == txt2 {
                txt3?.becomeFirstResponder()
            }
            if textField == txt3 {
                txt4?.becomeFirstResponder()
            }
            if textField == txt4 {
                txt5?.becomeFirstResponder()
            }
            if textField == txt5 {
                textField.text? = string
                print("API Call Verify OTP")
            }
            textField.text? = string
            return false
        }
        else
        {
            if textField == txt1 {
                txt1?.becomeFirstResponder()
            }
            if textField == txt2 {
                txt1?.becomeFirstResponder()
            }
            if textField == txt3 {
                txt2?.becomeFirstResponder()
            }
            if textField == txt4 {
                txt3?.becomeFirstResponder()
            }
            if textField == txt5 {
                txt4?.becomeFirstResponder()
                print("API NOT Call Verify OTP")
            }
            textField.text? = string
            return false
        }
    }
}
