import UIKit

class SeatSelectionViewController: UIViewController {
    
    @IBOutlet weak var back_BTN: UIButton!
    @IBOutlet weak var checkout_BTN: UIButton!
    @IBOutlet weak var totalPrice_LBL: UILabel!
    @IBOutlet weak var seatsCollectionView: UICollectionView!
    @IBOutlet weak var seatsListCollectionView: UICollectionView!
    
    private let viewModel = ShowsViewModel()
    var comedian: Comedian?
    var show : Show?
    var selectedSeats = [Seat]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.show != nil {
            self.show!.seats = show!.seats.sorted(by: { s1, s2 in
                if s1.row == s2.row {
                    return s1.seat_number < s2.seat_number
                }
                
                return s1.row < s2.row
            })
        }
        
        self.seatsCollectionView.dataSource = self
        self.seatsCollectionView.delegate = self
        self.seatsListCollectionView.dataSource = self
        self.seatsListCollectionView.delegate = self
        
        print(self.show!.seats)
        
        
        
    }
    @IBAction func didTapBack(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowsViewController") as? ShowsViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.comedian = self.comedian
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapCheckout(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.show = self.show
        vc.seats = self.selectedSeats
        vc.comedian = self.comedian
        present(vc, animated: true, completion: nil)
    }
    
    func addSelectedSeat(with index: Int) {
        self.selectedSeats.append(self.show!.seats[index])
        self.show!.seats[index].is_availble = false
        self.seatsListCollectionView.reloadData()
        updateTotalPrice()
    }
    
    func removeSelectedSeat(row: Int, seatNumber: Int) {
        var i : Int = 0
        for seat in selectedSeats {
            
            if seat.row == row && seat.seat_number == seatNumber {
                self.selectedSeats.remove(at: i)
                self.show!.seats[((row - 1) * 10) + (seatNumber - 1)].is_availble = true
                self.show!.seats[((row - 1) * 10) + (seatNumber - 1)].is_selected = false
            }
            i = i + 1
        }
        
        
        self.seatsCollectionView.reloadData()
        self.seatsListCollectionView.reloadData()
        updateTotalPrice()
        
    }
    
    func updateTotalPrice() {
        var total = 0.0
        for seat in selectedSeats {
            total = total + seat.price
        }
        
        self.totalPrice_LBL.text = "Total price: \(total)"
    }
}


extension SeatSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.seatsCollectionView {
            if let show = self.show {
                return show.seats.count
            }
            
        } else if collectionView == self.seatsListCollectionView {
            return self.selectedSeats.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.seatsCollectionView {
            let cell = self.seatsCollectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
            cell.setupView(with: self.show!.seats[indexPath.row])
            cell.isMarked = false
            if (!self.show!.seats[indexPath.row].is_availble && self.show!.seats[indexPath.row].is_selected) {
                cell.backgroundColor = UIColor.green
            } else if (!self.show!.seats[indexPath.row].is_availble) {
                cell.backgroundColor = UIColor.red
            } else if (self.show!.seats[indexPath.row].is_selected) {
                cell.backgroundColor = UIColor.green
            } else {
                cell.backgroundColor = UIColor.gray
            }
            return cell
            
            
        } else {
            let cell = self.seatsListCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCollectionViewCell", for: indexPath) as! SelectedSeatCollectionViewCell
            
            cell.delegate = self
            cell.seat = self.selectedSeats[indexPath.row]
            cell.setupView(with: self.selectedSeats[indexPath.row])
            return cell
        }
        
        
    }
    
    
}

extension SeatSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.seatsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! SeatCollectionViewCell
        
            
            if self.show!.seats[indexPath.row].is_availble && self.show!.seats[indexPath.row].is_selected == false {
                self.show!.seats[indexPath.row].is_availble = false
                self.show!.seats[indexPath.row].is_selected = true
                self.addSelectedSeat(with: indexPath.row)
                cell.backgroundColor = UIColor.green
            }
        } else {
            
        }
    }
    
}

extension SeatSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.seatsCollectionView {
            let size = collectionView.frame.size.width - 8 * 9
            return CGSize(width: size / 12, height: 30)
            
        } else  {
            return CGSize(width: 370, height: 49)
        }
    }
}

extension SeatSelectionViewController: SelectedSeatCollectionViewCellDelegate {
    func didTapButton(with seat: Seat) {
        self.removeSelectedSeat(row: seat.row, seatNumber: seat.seat_number)
    }
}


