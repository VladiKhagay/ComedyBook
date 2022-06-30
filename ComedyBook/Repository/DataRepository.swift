
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataRepository {
    static let shared = DataRepository()
    
    private let db = Firestore.firestore()
    private let comedians_path = "comedians"
    private let shows_path = "shows"
    private var comedians: [Comedian] = []
    private var shows: [Show] = []
    private var seats: [Seat] = []
    
    private init() {

    }
    /// Returns an array of objects of type Comedian.
    ///  - Returns an array of objects of type Comedian.
    ///
    func getComedians(completion: @escaping([Comedian])->Void){
        
        db.collection(comedians_path).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.comedians = snapshot?.documents.compactMap({ documentSnapshot in
                try? documentSnapshot.data(as: Comedian.self)
            }) ?? []
            completion(self.comedians)
            
        }
    }
    ///
    /// Returns an array of objjects of type Seat
    ///
    ///  - Parameter :  A string containing the comedians name
    ///  - Returns : An array of objjects of type Seat
    func getShows(withComedian name: String, completion: @escaping([Show]) -> Void) {
        db.collection(comedians_path).document(name).collection(shows_path).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            var shows = [Show]()
            for doc in snapshot!.documents {
                let id = doc.documentID
                let date = doc.data()["date"] as? String ?? "error"
                let day_of_week = doc.data()["day_of_week"] as? Int ?? 0
                let is_sold_out = doc.data()["is_sold_out"] as? Bool ?? true
                let location = doc.data()["location"] as? String ?? "error"
                let time = doc.data()["time"] as? String ?? "error"
                
                var seatsArray = [Seat]()
                let seats = doc.data()["seats"] as? [[String : Any]]
                if let seats = seats {
                    for seat in seats {
                        let row = seat["row"] as? Int ?? 0
                        let seat_number = seat["seat_number"] as? Int ?? 0
                        let price = seat["price"] as? Double ?? 0.0
                        let is_availble = seat["is_available"] as? Bool ?? false
                        seatsArray.append(Seat(row: row, seat_number: seat_number, price: price, is_availble: is_availble))
                    }
                }
                
                shows.append(Show(id: id, date: date, day_of_week: day_of_week, is_sold_out: is_sold_out, location: location, time: time, seats: seatsArray))

            }
            self.shows = shows
            completion(self.shows)
        }
    }
    
    func updateShow(with show: Show, with comedian:Comedian) {
        let dictData = Utils.seatsToArrayOfDict(from: show.seats)
        
        db.collection(comedians_path).document(comedian.name).collection(shows_path).document(show.id).updateData(["seats":dictData])
    }

}
