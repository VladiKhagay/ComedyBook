
import Foundation

class Utils {
    
//    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> (result: Bool, error: String) {
        
        if password.isEmpty {
            return (false, "Password is empty")
        }
        
        if password.count < 6 {
            return (false, " Password must contain 6 charecters")
        }
        
        return (true, "valid password")
    }
    
    static func isValidExprDate(_ date: String) -> Bool {
        if date.isEmpty {
            return false
        }
        
        if date.count < 5 {
            return false
        }
        
        let exprDateRegEx = "(0[1-9]|1[0-2])\\/[0-9]{2}"
        let exprPred = NSPredicate(format: "SELF MATCHES %@", exprDateRegEx)
        
        return exprPred.evaluate(with: date)
    }
    
    static func seatsToArrayOfDict(from seats:[Seat]) -> [[String: Any]]{
        
        var result = [[String: Any]] ()
        
        for seat in seats {
            let dict: [String: Any] = [
                "is_available": seat.is_availble,
                "price": seat.price,
                "row": seat.row,
                "seat_number": seat.seat_number
            ]
            result.append(dict)
        }
        
        return result
    }
    
}


