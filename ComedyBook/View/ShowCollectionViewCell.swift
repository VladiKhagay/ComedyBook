import UIKit
import Kingfisher

protocol ShowCollectionViewCellDelegate : AnyObject {
    func didTapButton(with index: Int)
}

class ShowCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var details_LBL: UILabel!
    @IBOutlet weak var select_BTN: UIButton!
    
    weak var delegate: ShowCollectionViewCellDelegate?
    var index : Int = -1
    private var isClickable = true
    
    func setUpView(with show : Show){
        
        var day: String = ""
        switch show.day_of_week {
        case 1:
            day = "Sun"
        case 2:
            day = "Mon"
        case 3:
            day = "Tue"
        case 4:
            day = "Wed"
        case 5:
            day = "Thu"
        case 6:
            day = "Fri"
        case 7:
            day = "Sat"
        default:
            day = ""
        }
        let details: String = "  \(show.date) \(day) \(show.time)\n  \(show.location)"
        details_LBL.text = details
        
        if (show.is_sold_out) {
            self.isClickable = false
            select_BTN.setImage(UIImage(named: "cancel-24.png"), for: .normal)
            select_BTN.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        if self.isClickable {
            delegate?.didTapButton(with: self.index)
        }
        
    }
    
}
