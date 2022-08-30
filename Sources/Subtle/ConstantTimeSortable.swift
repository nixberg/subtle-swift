public protocol ConstantTimeSortable {
    mutating func sortInConstantTime()
}

extension MutableCollection
where
    Self: RandomAccessCollection,
    Element: ConstantTimeGreaterThan & ConditionallyReplaceable,
    Index == Int
{
    @inline(__always)
    public mutating func sortInConstantTime() {
        guard let top = sequence(first: 1, next: { 2 * $0 })
            .prefix(while: { $0 < count }).last else {
            return
        }
        
        sequence(first: top) { $0 >> 1 }.prefix { $0 > 0 }.forEach { p in
            for i in 0..<(count - p) where i & p == 0 {
                self.minmaxAt(i, i + p)
            }
            _ = sequence(first: top, next: { $0 >> 1 })
                .prefix(while: { $0 > p })
                .reduce(0) { offset, q in
                    for i in offset..<(count - q) where i & p == 0 {
                        self[i + p] = sequence(first: q) {
                            $0 >> 1
                        }.prefix {
                            $0 > p
                        }.reduce(self[i + p]) { (a, r) in
                            self.minmax(a, i + r)
                        }
                    }
                    return count - q
            }
        }
    }
    
    @inline(__always)
    private mutating func minmaxAt(_ i: Index, _ j: Index) {
        var a = self[i]
        var b = self[j]
        a.swap(with: &b, if: a > b)
        self[i] = a
        self[j] = b
    }
    
    @inline(__always)
    private mutating func minmax(_ a: Element, _ j: Index) -> Element {
        var a = a
        var b = self[j]
        a.swap(with: &b, if: a > b)
        self[j] = b
        return a
    }
}

extension RangeReplaceableCollection
where
    Self: MutableCollection & RandomAccessCollection,
    Element: ConstantTimeGreaterThan & ConditionallyReplaceable,
    Index == Int
{
    @inline(__always)
    public func sortedInConstantTime() -> Self {
        var copy: Self = .init(self)
        copy.sortInConstantTime()
        return copy
    }
}

extension Array: ConstantTimeSortable
where Element: ConstantTimeGreaterThan & ConditionallyReplaceable {}

extension ArraySlice: ConstantTimeSortable
where Element: ConstantTimeGreaterThan & ConditionallyReplaceable {}

extension ContiguousArray: ConstantTimeSortable
where Element: ConstantTimeGreaterThan & ConditionallyReplaceable {}

extension Slice: ConstantTimeSortable
where Base: MutableCollection & RandomAccessCollection,
      Element: ConstantTimeGreaterThan & ConditionallyReplaceable,
      Index == Int {}
