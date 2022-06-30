
import UIKit
import FirebaseAuth
import SnackBar_swift

class SignInController: UIViewController {

    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var password_TextField: UITextField!
    @IBOutlet weak var signin_Button: UIButton!
    @IBOutlet weak var signUp_Button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignInClicked(_ sender: Any) {
        if let email = email_TextField.text, email.isEmpty {
            email_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  Email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let email = self.email_TextField.text, !Utils.isValidEmail(email) {
            self.email_TextField.text = ""
            email_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  valid email",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }

        if let password = self.password_TextField.text, password.isEmpty {
            self.password_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  Password",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let password = self.password_TextField.text, !Utils.isValidPassword(password).result{
            self.password_TextField.text = ""
            self.password_TextField.attributedPlaceholder = NSAttributedString(
                string: Utils.isValidPassword(password).error,
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        let email: String = email_TextField.text!
        let password: String = password_TextField.text!
        
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
            
            guard let strongSelf = self else {return}
            if error != nil {
                print(error ?? "Login faild")
                SnackBar.make(in: strongSelf.view, message: error!.localizedDescription, duration: .lengthShort).show()
                return
            }
            
            print("Logged in successfully with user: \(String(describing: authResult!.user.email))")
            
            self?.goToHome()
            
            
        }
        
    }
    
    
    @IBAction func onSignUpClicked(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpController") as? SignUpController else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func goToHome() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomePageController") as? HomePageController else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    

}
