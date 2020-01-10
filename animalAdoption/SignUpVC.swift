//
//  SignUpVC.swift
//  animalAdoption
//
//  Created by User15 on 2020/1/5.
//  Copyright © 2020 ibob. All rights reserved.
//

import UIKit


class SignUpVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgSheetDB: UIImageView!
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    var alertAccountIsAlreadyExist = UIAlertController(title: "註冊失敗", message: "帳號已經存在", preferredStyle: .alert)
    //        var alertWrongPassword = UIAlertController(title: "註冊失敗", message: "密碼錯誤", preferredStyle: .alert)
    var okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
//    var dismissAction = UIAlertAction(title: "確認", style: .cancel) {alertAction in dismiss(animated: true, completion: nil)}
//    alertSignUpSucceed.addAction(dismissAction)
    var alertSignUpSucceed = UIAlertController(title: "註冊成功", message: "請登入以繼續使用", preferredStyle: .alert)
    var alertSignUpFailed = UIAlertController(title: "註冊失敗", message: "請再嘗試一次，或聯絡開發者", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfAccount.delegate = self
        tfPassword.delegate = self
        tfName.delegate = self
        imgSheetDB.image = UIImage(named: "sheetDB")
        alertAccountIsAlreadyExist.addAction(okAction)
        alertSignUpFailed.addAction(okAction)
        // Do any additional setup after loading the view.
    }
    
    func setUIAvailable(status: Bool) {
        tfAccount.isEnabled = status
        tfPassword.isEnabled = status
        tfName.isEnabled = status
        btnBack.isEnabled = status
        btnSignUp.isEnabled = status
    }
    func isInputValid(input: String, pattern: String) -> Bool {
        /* self matches是特定寫法而且不區別大小寫，代表input值必須符合參數pattern要求的格式 */
        let predicate = NSPredicate(format: "self matches %@", pattern)
        let isValid = predicate.evaluate(with: input)
        return isValid
    }
    @IBAction func clickSignUp(_ sender: Any) {
        
        let pattern = "\\w{3,10}"
        let patternForName = "\\S{1,}"
        let isAccountValid = isInputValid(input: tfAccount.text ?? "", pattern: pattern)
        let isPasswordValid = isInputValid(input: tfPassword.text ?? "", pattern: pattern)
        let isNameValid = isInputValid(input: tfName.text ?? "", pattern: patternForName)
        
        if !isAccountValid {
            let alertAccountInvalid = UIAlertController(title: "帳號格式錯誤", message: "請輸入3-10位英文或數字", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertAccountInvalid.addAction(okAction)
            present(alertAccountInvalid, animated: true)
        } else if !isPasswordValid {
            let alertPasswordInvalid = UIAlertController(title: "帳號格式錯誤", message: "請輸入3-10位英文或數字", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertPasswordInvalid.addAction(okAction)
            present(alertPasswordInvalid, animated: true)
        } else if !isNameValid{
            let alertNameInvalid = UIAlertController(title: "暱稱格式錯誤", message: "請輸入暱稱", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertNameInvalid.addAction(okAction)
            present(alertNameInvalid, animated: true)
        } else {
            activityIndicator.startAnimating()
            setUIAvailable(status: false)
            let userAccount = tfAccount.text ?? ""
            let userPassword = tfPassword.text ?? ""
            let userName = tfName.text ?? ""
            let url = URL(string: "https://sheetdb.io/api/v1/0kog41wk2hsr5/search?Account=\(userAccount)&casesensitive=true")
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let decodedData = try? decoder.decode([[String: String]].self, from: data){
                    DispatchQueue.main.async {
                        if decodedData != [] {
                            self.setUIAvailable(status: true)
                            self.activityIndicator.stopAnimating()
                            self.present(self.alertAccountIsAlreadyExist, animated: true)
                        } else {
                            DispatchQueue.global(qos: .userInitiated).async {
                                let url = URL(string: "https://sheetdb.io/api/v1/0kog41wk2hsr5")
                                var urlRequest = URLRequest(url: url!)
                                urlRequest.httpMethod = "POST"
                                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                let user = User(Account: userAccount, Password: userPassword, Name: userName)
                                let userData = UserData(data: [user])
                                
                                let encoder = JSONEncoder()
                                if let data = try? encoder.encode(userData) {
                                    let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (reData, res, err) in
                                        let decoder = JSONDecoder()
                                        if let reData = reData, let statusCode = try? decoder.decode([String: Int].self, from: reData), statusCode["created"] == 1 {
                                            DispatchQueue.main.async {
                                                self.setUIAvailable(status: true)
                                                self.activityIndicator.stopAnimating()
                                                let dismissAction = UIAlertAction(title: "確認", style: .cancel) {alertAction in self.dismiss(animated: true, completion: nil)}
                                                self.alertSignUpSucceed.addAction(dismissAction)
                                                
                                                self.present(self.alertSignUpSucceed,animated: true)
                                            }
                                        } else {
                                            DispatchQueue.main.async {
                                                self.activityIndicator.stopAnimating()
                                                self.setUIAvailable(status: true)
                                                self.present(self.alertSignUpFailed, animated: true)
                                            }
                                        }
                                    })
                                    task.resume()
                                }
                            }
                        }
                    }
                } else {
                    print("check task failed")
                }
            }
            task.resume()
        }
        
    }
    
    @IBAction func clickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
