import XCTest
@testable import aoclib

final class permuationsTests: XCTestCase {
  func testPermutations() {
    var out = [[Character]]()
    for s in "abc".permutations() {
      out.append(s)
    }
    XCTAssertEqual(out, [["a", "b", "c"], ["b", "a", "c"], ["c", "a", "b"],
                         ["a", "c", "b"], ["b", "c", "a"], ["c", "b", "a"]])
  }
  func testChoose() {
    XCTAssertEqual([[Character]]("abcde".choose(0)), [])
    XCTAssertEqual([[Character]]("abcde".choose(2)),
                                 [["a", "b"], ["a", "c"], ["a", "d"],
                                  ["a", "e"], ["b", "c"], ["b", "d"],
                                  ["b", "e"], ["c", "d"], ["c", "e"],
                                  ["d", "e"]])
    XCTAssertEqual([[Character]]("abcde".choose(5)),
                                 [["a", "b", "c", "d", "e"]])
  }
}