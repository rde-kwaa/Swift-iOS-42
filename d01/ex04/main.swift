var deck = Deck(shuffle: false)

var card: Card

print("\n");
print("Initial Deck: \n\(deck)")
card = deck.draw()
card = deck.draw()
card = deck.draw()
print("\n");
print("After 3 Draws: \n\(deck)")
print("\n");
print("Outs Deck: \n\(deck.outs)")
print("\n");
deck.fold(c: deck.outs[0])
deck.fold(c: deck.outs[0])
print("Outs Deck: \n\(deck.outs)")
print("\n");
print("Discards Deck: \n\(deck.disards)")
