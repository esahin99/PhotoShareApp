
import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            //User Login
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (AuthDataResult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Error", messageInput: error!.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            errorMessage(titleInput: "Error!", messageInput: "Please Enter Name and Password!")
        }
    }
    @IBAction func registerButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            //User Register
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authDataResult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Error!", messageInput: error!.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            errorMessage(titleInput: "Error!", messageInput: "Please Enter Name and Password!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func errorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

