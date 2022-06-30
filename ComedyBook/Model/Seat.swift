
import Foundation

struct Seat : Codable, Hashable {
    var row: Int
    var seat_number: Int
    var price: Double
    var is_availble: Bool
    var is_selected: Bool = false

    
    init(row: Int, seat_number: Int, price: Double, is_availble: Bool) {
        self.row = row
        self.seat_number = seat_number
        self.price = price
        self.is_availble = is_availble
    }
}
