
import Foundation

struct User : Codable{
    var fullName: String
    var username: String
    var email: String
    
    init(fullName: String, username: String, email: String){
        self.fullName = fullName
        self.username = username
        self.email = email
    }
}
