extension StringProtocol {
  public subscript(pos: Int) -> Character {
    let pos = pos >= 0 ? pos : count + pos
    return self[self.index(self.startIndex, offsetBy: pos)]
  }
    // TODO: the below is apparently *explicitly* disabled in the core
    // library, so isn't so easily re-added with an extension.
//  public subscript(r: Range<Int>) -> SubSequence {
  // Instead we'll use a named function:
  public func slice(_ from: Int? = nil, _ to: Int? = nil) -> SubSequence {
    let from = from ?? 0
    let l = Swift.max(0, from >= 0 ? from : count + from)
    let to = to ?? count
    let u = Swift.max(l, Swift.min(count, to >= 0 ? to : count + to))
    let lb = self.index(self.startIndex, offsetBy: l)
    let ub = self.index(self.startIndex, offsetBy: u)
    return self[lb..<ub]
  }
  public func slice(_ from: Int?, through: Int) -> SubSequence {
    return slice(from, through == -1 ? count : through + 1)
  }
  public func find<Str: StringProtocol>(_ sub: Str) -> Index? {
    precondition(!sub.isEmpty)
    for i in indices {
      var ai = i, bi = sub.startIndex
      while ai != endIndex && bi != sub.endIndex && self[ai] == sub[bi] {
        formIndex(after: &ai)
        sub.formIndex(after: &bi)
      }
      if bi == sub.endIndex { return i }
    }
    return nil
  }
  public func findAll<Str: StringProtocol>(_ sub: Str) -> [Index] {
    precondition(!sub.isEmpty)
    var rv = [Index]()
    for i in indices {
      var ai = i, bi = sub.startIndex
      while ai != endIndex && bi != sub.endIndex && self[ai] == sub[bi] {
        formIndex(after: &ai)
        sub.formIndex(after: &bi)
      }
      if bi == sub.endIndex { rv.append(i) }
    }
    return rv
  }
  public func stripped() -> SubSequence {
    let startPos = self.firstIndex { !$0.isWhitespace } ?? self.endIndex
    let endPos = self.lastIndex { !$0.isWhitespace } ?? self.endIndex
    return self[startPos...endPos]
  }
  public func split<Str: StringProtocol>(_ sep: Str) -> [SubSequence] {
    var rv = [SubSequence]()
    var start = self.startIndex
    for i in findAll(sep) {
      rv.append(self[start..<i])
      start = self.index(i, offsetBy: sep.count)
    }
    rv.append(self[start...])
    return rv
  }
  public func partition<Str: StringProtocol>(_ sep: Str, at: Int = 1)
      -> (SubSequence, SubSequence, SubSequence) {
    precondition(at > 0)
    let inds = findAll(sep)
    if at > inds.count { return (self[...], "", "") }
    let end = self.index(inds[at - 1], offsetBy: sep.count)
    return (self[..<inds[at - 1]],
            self[inds[at - 1]..<end],
            self[end...])
  }
  public func join<Str: StringProtocol>(_ ss: [Str]) -> String {
    if ss.isEmpty { return "" }
    var rv = String(ss[0])
    for s in ss[1...] {
      rv += self
      rv += s
    }
    return rv
  }
  public func replaced<S1: StringProtocol, S2: StringProtocol>
      (old: S1, new: S2, count: Int? = nil) -> String {
    var rv = ""
    var start = self.startIndex
    for i in count != nil ? findAll(old)[0..<count!] : findAll(old)[...] {
      rv += self[start..<i]
      rv += new
      start = self.index(i, offsetBy: old.count)
    }
    rv += self[start..<self.endIndex]
    return rv
  }
  public func ljust(_ width: Int, fill: Character = " ") -> String {
    precondition(width >= self.count)
    return String(self) + String(repeating: fill, count: width - self.count)
  }
  public func rjust(_ width: Int, fill: Character = " ") -> String {
    precondition(width >= self.count)
    return String(repeating: fill, count: width - self.count) + self
  }
  public func center(_ width: Int, fill: Character = " ") -> String {
    precondition(width >= self.count)
    var rv = String(repeating: fill, count: (width - self.count) / 2)
    rv += self
    rv += String(repeating: fill, count: (width - self.count + 1) / 2)
    return rv
  }
} // end extension StringProtocol
