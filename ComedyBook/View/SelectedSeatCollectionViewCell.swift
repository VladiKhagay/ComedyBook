import UIKit

protocol SelectedSeatCollectionViewCellDelegate : AnyObject{
    
    func didTapButton(with seat:Seat)
}

class SelectedSeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seatDetails_LBL: UILabel!
    @IBOutlet weak var remove_BTN: UIButton!
    weak var delegate: SelectedSeatCollectionViewCellDelegate?
    var seat : Seat?
    
    func setupView(with seat:Seat) {
        self.seatDetails_LBL.text = "Row: \(seat.row), Seat: \(seat.seat_number), Price: \(seat.price)"
    }

    @IBAction func didTapButton(_ sender: Any) {
        delegate?.didTapButton(with: self.seat!)
    }
    
}
