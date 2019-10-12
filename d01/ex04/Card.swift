import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description: String {
        return "\(value) of \(color)s"
    }
    
    override func isEqual(_ object: Any? ) -> Bool {
        if let obj = object as? Card {
        if (obj.color == self.color && obj.value == self.value) {
            return true
        } else {
            return false
        }
        }
        return false
    }
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return (lhs.color == rhs.color && lhs.value == rhs.value)
}
