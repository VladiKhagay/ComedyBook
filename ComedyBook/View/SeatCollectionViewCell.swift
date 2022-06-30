import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var seatNumber_LBL: UILabel!
    
    var isMarked: Bool = false
    
    func setupView(with seat:Seat) {
        self.seatNumber_LBL.text = String(seat.seat_number)
        if !seat.is_availble {
//            self.seatNumber_LBL.backgroundColor = UIColor.red
        }
    }
}
