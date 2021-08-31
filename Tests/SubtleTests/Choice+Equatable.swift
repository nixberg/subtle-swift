import Subtle

extension Choice: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        Bool(Choice(lhs == rhs))
    }
}
