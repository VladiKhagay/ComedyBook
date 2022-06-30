import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var back_BTN: UIButton!
    @IBOutlet weak var numOfTickets_LBL: UILabel!
    @IBOutlet weak var totalPrice_LBL: UILabel!
    @IBOutlet weak var cardNumber_TextField: UITextField!
    @IBOutlet weak var cardHolderName_TextField: UITextField!
    @IBOutlet weak var cvv_TextField: UITextField!
    @IBOutlet weak var exprDate_TextField: UITextField!
    @IBOutlet weak var checkout_BTN: UIButton!
    @IBOutlet weak var comletionView: UIView!
    
    var show: Show?
    var seats = [Seat]()
    var comedian : Comedian?
    private let viewModel = ShowsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numOfTickets_LBL.text = "\(seats.count)"
        self.setPriceLabel()
        
    }
    
    private func setPriceLabel() {
        var total: Double = 0.0
        
        for seat in seats {
            total = total + seat.price
        }
        
        self.totalPrice_LBL.text = "\(total)"
        
        print(Utils.seatsToArrayOfDict(from: self.seats))
        print(type(of: Utils.seatsToArrayOfDict(from: self.seats)))
    }
    
    
    @IBAction func didTapBack(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SeatSelectionViewController") as? SeatSelectionViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.show = self.show
        vc.comedian = self.comedian
        vc.selectedSeats = self.seats
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapCheckout(_ sender: Any) {
        
        if let cardNumber = cardNumber_TextField.text, cardNumber.isEmpty {
            cardNumber_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  card Number",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let cardNumber = self.cardNumber_TextField.text, cardNumber.count < 16 {
            self.cardNumber_TextField.text = ""
            cardNumber_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  valid card number",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let name = self.cardHolderName_TextField.text , name.isEmpty {
            self.cardNumber_TextField.attributedPlaceholder = NSAttributedString (
                string: "Enter Name",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
            
        }
        
        if let cvv = cvv_TextField.text, cvv.isEmpty {
            cvv_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  cvv",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let cvv = self.cvv_TextField.text, cvv.count < 3 {
            self.cvv_TextField.text = ""
            cvv_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  valid cvv",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        if let expr = self.exprDate_TextField.text, expr.isEmpty {
            self.exprDate_TextField.attributedPlaceholder = NSAttributedString(
                string: "Enter  expr date",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        } else if let expr = self.exprDate_TextField.text, !Utils.isValidExprDate(expr){
            self.exprDate_TextField.text = ""
            self.exprDate_TextField.attributedPlaceholder = NSAttributedString(
                string: "invalid format",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
            )
            return
        }
        
        self.comletionView.isHidden = false
        
        ShowsViewModel().updateDatainRepository(with: self.show!, with: self.comedian!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageController") as? HomePageController else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        

    }
    
}
