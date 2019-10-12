enum Color: String, CaseIterable {
    case Heart = "HEART"
    case Spade = "SPADE"
    case Club = "CLUB"
    case Diamond = "DIAMOND"
    static let allColors: [Color] = [Heart, Spade, Club, Diamond]
}
