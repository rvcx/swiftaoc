

public struct Pt2: Hashable {
  public let x: Int
  public let y: Int
  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

public struct GridIterator<T>: Sequence, IteratorProtocol
    where T: RandomAccessCollection, T.Index == Int,
          T.Element: RandomAccessCollection, T.Element.Index == Int {

  var p = Pt2(0, 0)
  let c: T
  public mutating func next() -> (Pt2, T.Element.Element)? {
    guard p.y < c.count else { return nil }
    defer {
      p = Pt2(p.x + 1, p.y)
      if p.x == c[p.y].count {
        p = Pt2(0, p.y + 1)
      }
    }
    return (p, c[p])
  }
}

extension RandomAccessCollection
    where Index == Int, Element: RandomAccessCollection, Element.Index == Int {
  public subscript(pos: Pt2) -> Element.Element {
    return self[pos.y][pos.x]
  }
  public func asGrid() -> GridIterator<Self> {
    return GridIterator<Self>(c: self)
  }
}
extension RandomAccessCollection
    where Self: MutableCollection, Index == Int, Element: RandomAccessCollection,
          Element: MutableCollection, Element.Index == Int {
  public subscript(pos: Pt2) -> Element.Element {
    get {
      return self[pos.y][pos.x]
    }
    set {
      self[pos.y][pos.x] = newValue
    }
  }
}
extension Pt2 {
  public func neighbors<T>(_ grid: [[T]]) -> [Pt2] {
    var out = [Pt2]()
    for y in (self.y - 1)...(self.y + 1) {
      if y < 0 || y >= grid.count { continue }
      for x in (self.x - 1)...(self.x + 1) {
        if x < 0 || x >= grid[y].count { continue }
        let newP = Pt2(x, y)
        if newP != self { out.append(newP) }
      }
    }
    return out
  }
  public func mneighbors<T>(_ grid: [[T]]) -> [Pt2] {
    var out = [Pt2]()
    if x > 0 { out.append(Pt2(x - 1, y)) }
    if y > 0 { out.append(Pt2(x, y - 1)) }
    if x < grid[y].count - 1 { out.append(Pt2(x + 1, y)) }
    if y < grid.count - 1 { out.append(Pt2(x, y + 1)) }
    return out
  }
  public func tneighbors<T>(_ grid: [[T]]) -> [Pt2] {
    var out = [Pt2]()
    for y in (self.y - 1)...(self.y + 1) {
      for x in (self.x - 1)...(self.x + 1) {
        let ny = (y + grid.count) % grid.count
        let newP = Pt2((x + grid[ny].count) % grid[ny].count, ny)
        if newP != self { out.append(newP) }
      }
    }
    return out
  }
}

// Ugh; duplicate the above for StringProtocols, which aren't
// RandomAccessCollections...

public struct SGridIterator<T>: Sequence, IteratorProtocol
    where T: RandomAccessCollection, T.Index == Int,
          T.Element: StringProtocol {

  var p = Pt2(0, 0)
  let c: T
  public mutating func next() -> (Pt2, T.Element.Element)? {
    guard p.y < c.count else { return nil }
    defer {
      p = Pt2(p.x + 1, p.y)
      if p.x == c[p.y].count {
        p = Pt2(0, p.y + 1)
      }
    }
    return (p, c[p])
  }
}
extension RandomAccessCollection
    where Index == Int, Element: StringProtocol {
  public subscript(pos: Pt2) -> Element.Element {
    return self[pos.y][pos.x]
  }
  public func asGrid() -> SGridIterator<Self> {
    return SGridIterator<Self>(c: self)
  }
}
extension Pt2 {
  public func neighbors<T: StringProtocol>(_ grid: [T]) -> [Pt2] {
    var out = [Pt2]()
    for y in (self.y - 1)...(self.y + 1) {
      if y < 0 || y >= grid.count { continue }
      for x in (self.x - 1)...(self.x + 1) {
        if x < 0 || x >= grid[y].count { continue }
        let newP = Pt2(x, y)
        if newP != self { out.append(newP) }
      }
    }
    return out
  }
  public func mneighbors<T: StringProtocol>(_ grid: [T]) -> [Pt2] {
    var out = [Pt2]()
    if x > 0 { out.append(Pt2(x - 1, y)) }
    if y > 0 { out.append(Pt2(x, y - 1)) }
    if x < grid[y].count - 1 { out.append(Pt2(x + 1, y)) }
    if y < grid.count - 1 { out.append(Pt2(x, y + 1)) }
    return out
  }
  public func tneighbors<T: StringProtocol>(_ grid: [T]) -> [Pt2] {
    var out = [Pt2]()
    for y in (self.y - 1)...(self.y + 1) {
      for x in (self.x - 1)...(self.x + 1) {
        let ny = (y + grid.count) % grid.count
        let newP = Pt2((x + grid[ny].count) % grid[ny].count, ny)
        if newP != self { out.append(newP) }
      }
    }
    return out
  }
}