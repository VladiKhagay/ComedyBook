
import Foundation

struct Show: Codable {
    var id: String
    var date: String
    var day_of_week: Int
    var is_sold_out: Bool
    var location: String
    var time: String
    var seats: [Seat]
    
    init(id: String, date: String, day_of_week: Int, is_sold_out: Bool, location: String, time: String, seats: [Seat]) {
        self.id = id
        self.date = date
        self.day_of_week = day_of_week
        self.is_sold_out = is_sold_out
        self.location = location
        self.time = time
        self.seats = seats
    }
}
