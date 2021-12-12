public struct PermutationIterator<T>: Sequence, IteratorProtocol {
  var p = [T]()
  var c = [Int]()
  var i = 0
  init<S>(_ s: S) where S: Sequence, S.Element == T {
    p = [T](s)
    c = [Int](repeating: 0, count: p.count)
  }
  public mutating func next() -> [T]? {
    // use Heap's algorithm to generate next permutation
    guard i < p.count else { return nil }
    defer {
      while i < p.count && c[i] >= i {
        c[i] = 0
        i += 1
      }
      if i < p.count {
        p.swapAt(i % 2 == 0 ? 0 : c[i], i)
        c[i] += 1
        i = 0
      }
    }
    return p
  }
}

extension Sequence {
  public func permutations() -> PermutationIterator<Element> {
    return PermutationIterator<Element>(self)
  }
}

public struct CombinationIterator<T>: Sequence, IteratorProtocol {
  var p: [T]
  var c: [Int]
  var i: Int
  init<S>(_ s: S, n: Int) where S: Sequence, S.Element == T {
    p = [T](s)
    c = [Int](0..<n)
    i = c.count - 1
  }
  public mutating func next() -> [T]? {
    // there is probably a constant-time algorithm for producing combinations,
    // but I don't know it, so merely advance the last position that can be
    // advanced, and build the output from scratch
    guard i >= 0 else { return nil }
    defer {
      while i >= 0 && c[i] == p.count - c.count + i {
        i -= 1
      }
      if i >= 0 {
        c[i] += 1
        for j in (i + 1)..<c.count {
          c[j] = c[j - 1] + 1
        }
        if c[c.count - 1] < p.count - 1 {
          i = c.count - 1
        }
      }
    }
    return c.map { p[$0] }
  }
}

extension Sequence {
  public func choose(_ n: Int) -> CombinationIterator<Element> {
    return CombinationIterator<Element>(self, n: n)
  }
}