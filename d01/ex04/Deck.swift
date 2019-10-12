import Foundation

class Deck: NSObject {
    static let allCards     : [Card] = allSpades + allDiamonds + allHearts + allClubs
    static let allSpades    : [Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
    static let allDiamonds  : [Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
    static let allHearts    : [Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
    static let allClubs     : [Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
    
    var cards   : [Card] = allCards
    var disards : [Card] = []
    var outs    : [Card] = []
    
    init(shuffle: Bool) {
        self.cards = Deck.allCards
        if shuffle == true {
            self.cards.doTheShuffle()
        }
    }
    
    override var description: String {
        return self.cards.description
    }
    
    func draw() -> Card {
        var top: Card
        top = self.cards.first!
        self.outs.append(top)
        self.cards.remove(at: 0)
        return top
    }
    
    func fold(c: Card) {
        var i = 0
        for card in self.outs {
            if c == card {
                self.disards.append(card)
                self.outs.remove(at: i)
            }
            i = i + 1 
        }
    }
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
