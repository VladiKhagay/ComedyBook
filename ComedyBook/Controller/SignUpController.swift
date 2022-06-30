

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpController: UIViewController {

    @IBOutlet weak var fullName_EditText: UITextField!
    @IBOutlet weak var username_EditText: UITextField!
    @IBOutlet weak var email_EditText: UITextField!
    @IBOutlet weak var conf_email_EditText: UITextField!
    @IBOutlet weak var password_EditText: UITextField!
    @IBOutlet weak var conf_password_EditText: UITextField!
    @IBOutlet weak var signup_Button: UIButton!
    @IBOutlet weak var signin_Button: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignUpClicked(_ sender: Any) {

        if let fullname = fullName_EditText.text, fullname.isEmpty {
            fullName_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter Full Name",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
                
            )
            return
        }
        
        if let username = username_EditText.text, username.isEmpty {
            username_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  Username",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let email = email_EditText.text, email.isEmpty {
            email_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  Email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let email = email_EditText.text, !Utils.isValidEmail(email) {
            email_EditText.text = ""
            email_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  valid email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let conf_email = conf_email_EditText.text, conf_email.isEmpty {
            conf_email_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  Email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let conf_email = conf_email_EditText.text, !Utils.isValidEmail(conf_email) {
            conf_email_EditText.text = ""
            conf_email_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  valid email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let password = password_EditText.text, password.isEmpty {
            password_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  Password",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let password = password_EditText.text, !Utils.isValidPassword(password).result{
            password_EditText.text = ""
            password_EditText.attributedPlaceholder = NSAttributedString(
                string: Utils.isValidPassword(password).error,
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let conf_password = conf_password_EditText.text, conf_password.isEmpty {
            conf_password_EditText.attributedPlaceholder = NSAttributedString(
                string: "Enter  Password",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }else if let conf_password = conf_password_EditText.text, !Utils.isValidPassword(conf_password).result{
            conf_password_EditText.text = ""
            conf_password_EditText.attributedPlaceholder = NSAttributedString(
                string: Utils.isValidPassword(conf_password).error,
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        let fullName: String = fullName_EditText.text!
        let username: String = username_EditText.text!
        let email: String = email_EditText.text!
        let conf_email: String = conf_email_EditText.text!
        let password: String = password_EditText.text!
        let conf_password: String = conf_password_EditText.text!
        
        if email.caseInsensitiveCompare(conf_email) != .orderedSame {
            conf_email_EditText.text = ""
            conf_email_EditText.attributedPlaceholder = NSAttributedString(
                string: "Email addresses not match",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if password.caseInsensitiveCompare(conf_password) != .orderedSame {
            conf_password_EditText.text = ""
            conf_password_EditText.attributedPlaceholder = NSAttributedString(
                string: "PAsswords not match",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error ?? "Sign up failed")
            }
            
            self.ref.child("users").child(authResult!.user.uid).setValue(["fullName": fullName, "username": username, "email": email])

        }
        
        
//        self.goToSignIn()
        
    }
    

    @IBAction func onSignInClicked(_ sender: Any) {

        self.goToSignIn()
    }
    
    private func goToSignIn() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInController else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
