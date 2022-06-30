import Foundation


class ComediansViewModel {
    
    private let repository = DataRepository.shared
    
    var comedians : [Comedian] = []
    
    func getComedians(completion: @escaping(Bool) -> Void) {
        
        repository.getComedians { comediansResult in
            if comediansResult.count == 0 {
                completion(false)
                return
            }
            self.comedians = comediansResult
            completion(true)
        }
    }
    
    
}
