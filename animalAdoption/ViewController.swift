import UIKit
import Foundation
class ViewController: UIViewController, UITextFieldDelegate {
    var alertAccountNotExist = UIAlertController(title: "登入失敗", message: "帳號不存在", preferredStyle: .alert)
    var alertWrongPassword = UIAlertController(title: "登入失敗", message: "密碼錯誤", preferredStyle: .alert)
    var okAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var imgSheetDB: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfAccount.delegate = self
        tfPassword.delegate = self
        
        imgSheetDB.image = UIImage(named: "sheetDB")
        alertAccountNotExist.addAction(self.okAction)
        alertWrongPassword.addAction(self.okAction)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tfAccount.text = ""
        tfPassword.text = ""
    }

    @IBAction func clickSignUp(_ sender: Any) {
    }
    
    func setUIAvailable(status: Bool) {
        tfAccount.isEnabled = status
        tfPassword.isEnabled = status
        btnLogIn.isEnabled = status
        btnLogIn.isEnabled = status
    }
    @IBAction func clickLogIn(_ sender: Any) {
        setUIAvailable(status: false)
        activityIndicator.startAnimating()
        let userAccount = tfAccount.text ?? ""
        let userPassword = tfPassword.text ?? ""
        
        let url = URL(string: "https://sheetdb.io/api/v1/0kog41wk2hsr5/search?Account=\(userAccount)&casesensitive=true")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let decodedData = try? decoder.decode([[String: String]].self, from: data){
                print("get succeed")
                print(decodedData)
                print(type(of: decodedData))
                DispatchQueue.main.async {
                    
                    if decodedData == [] {
                        print("NO This Account")
                        self.setUIAvailable(status: true)
                        self.activityIndicator.stopAnimating()
                        self.present(self.alertAccountNotExist, animated: true)
                    } else if decodedData[0]["Password"] != userPassword {
                        print("Wrong Password")
                        self.setUIAvailable(status: true)
                        self.activityIndicator.stopAnimating()
                        self.present(self.alertWrongPassword, animated: true)
                    } else {
                        print("LogIn suceed")
                        self.setUIAvailable(status: true)
                        self.userName = decodedData[0]["Name"]
                        self.activityIndicator.stopAnimating()
                        self.performSegue(withIdentifier: "segue_logIn", sender: self)
                    }
                }
            } else {
                print("task failed")
            }
        }
        task.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    var userName: String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_logIn" {
           //Text("sessuce")
            /*
            let MainVC = segue.destination as! MainVC
            MainVC.userAccount = tfAccount.text
            MainVC.userName = userName
 */
        }
    }

    @IBAction func unwindToLogIn(_ sender: UIStoryboardSegue){
    }
}
