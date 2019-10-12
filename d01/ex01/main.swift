//Jack O Diamonds
let c1: Card = Card(color: Color.Diamond, value: Value.Jack)
//3 A Spades
let c2: Card = Card(color: Color.Spade, value: Value.Three)
//Jack O Diamonds
let c3: Card = Card(color: Color.Diamond, value: Value.Jack)
//9 O Clubs
let c4: Card = Card(color: Color.Club, value: Value.Nine)

print("Card 1: \(c1)")
print("Card 2: \(c2)")
print("Card 3: \(c3)")
print("Card 4: \(c4)")

print("Func '==' override -> Card 1 = Card 3: \(c1 == c3)")
print("Func '==' override -> Card 2 = Card 4: \(c2 == c4)")
print("Func isEquals() -> Card 1 = Card 2: \(c1.isEqual(c2))")
print("Func isEquals() -> Card 1 = Card 3: \(c1.isEqual(c3))")
