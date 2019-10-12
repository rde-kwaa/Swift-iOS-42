import Foundation

class Deck: NSObject {
    static let allSpades: [Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
    static let allDiamonds: [Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
    static let allHearts: [Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
    static let allClubs: [Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
    
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func doTheShuffle() {
        var last = self.count - 1
        while last > 0 {
            let random = Int(arc4random_uniform(UInt32(last)))
            self.swapAt(last, random)
            last -= 1
        }
    }
    // You could also just do self.shuffle()...
}
