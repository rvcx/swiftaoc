public struct Heap<T> {
  var d = [T]()
  let cmp: (T, T) -> Bool  // elements that are "most true" are popped first
  
  public var isEmpty: Bool {
    return d.isEmpty
  }
  public mutating func push(_ e: T) {
    d.append(e)
    var i = d.count - 1
    while 0 < i && cmp(d[i], d[(i - 1) / 2]) {
      d.swapAt(i, (i - 1) / 2)
      i = (i - 1) / 2
    }
  }
  public mutating func pop() -> T? {
    guard !d.isEmpty else { return nil }
    d.swapAt(0, d.count - 1)
    let rv = d.removeLast()
    var i = 0
    while true {
      let l = i * 2 + 1, li = l < d.count && cmp(d[l], d[i]) ? l : i
      let r = i * 2 + 2, m = r < d.count && cmp(d[r], d[li]) ? r : li
      if m == i { break }
      d.swapAt(m, i)
      i = m
    }
    return rv
  }
}
