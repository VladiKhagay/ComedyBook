import Foundation

class ShowsViewModel {
    
    private let repository = DataRepository.shared
    
    var shows : [Show] = []
    
    /// Returns a boolean value thet indicates if the function scceeded or not.
    /// - Returns : A boolean value thet indicates if the function scceeded or not.
    ///
    func getShows(of: String, completion: @escaping(Bool) -> Void) {
        
        repository.getShows(withComedian: of) { shows in
            if shows.count == 0 {
                completion(false)
                return
            }
            
            self.shows = shows
            completion(true)
        }
    }
    
    func updateDatainRepository(with show:Show, with comedian:Comedian) {
        repository.updateShow(with: show, with: comedian)
    }
}
