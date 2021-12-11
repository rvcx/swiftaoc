import Foundation

public func lines(file: String = "input.txt") -> [Substring] {
  return try! String(contentsOfFile: file).split(separator: "\n")
}

public func records(file: String = "input.txt") -> [[String]] {
  let lines = try! String(contentsOfFile: file)
                    .split(separator: "\n", omittingEmptySubsequences: false)
  var curRecord = [String]()
  var out = [[String]]()
  for l in lines {
    if l.isEmpty {
      out.append(curRecord)
      curRecord = [String]()
    } else {
      curRecord.append(String(l))
    }
  }
  return out
}

public func parseLines(_ pattern: String,
                       file: String = "input.txt") -> [[String?]] {
  let re = try! NSRegularExpression(pattern: pattern)
  var outs = [[String?]]()
  for s in try! String(contentsOfFile: file).split(separator: "\n") {
    let s = String(s)
    let allS = NSRange(s.startIndex..<s.endIndex, in: s)
    var out = [String?]()
    let match = re.firstMatch(in: s, range: allS)!
    for i in 1..<match.numberOfRanges {
      let nsr = match.range(at: i)
      if nsr.location != NSNotFound {
        let g = s[Range(nsr, in: s)!]
        out.append(String(g))
      } else {
        out.append(nil)
      }
    }
    outs.append(out)
  }
  return outs
}

public func digitGrid(_ lines: [String]) -> [[Int]] {
  return lines.map { $0.map { Int(String($0))! } }
}

public func numGrid(_ lines: [String]) -> [[Int]] {
  return lines.map { $0.split().map { Int($0)! } }
}
