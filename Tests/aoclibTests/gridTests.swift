import XCTest
@testable import aoclib

final class gridTests: XCTestCase {
  func testPt2() {
    var pts = Set<Pt2>()
    pts.insert(Pt2(1, 2))
    pts.insert(Pt2(1, 3))
    pts.insert(Pt2(2, 2))
    pts.insert(Pt2(1, 2))
    XCTAssertEqual(pts.count, 3)
  }
  func testSubscript() {
    var g = [["a", "b", "c", "d"],
             ["e", "f", "g", "h"],
             ["i", "j", "k", "l"]]
    XCTAssertEqual(g[Pt2(2, 2)], "k")
    g[Pt2(2, 2)] = "x"
    XCTAssertEqual(g, [["a", "b", "c", "d"],
                       ["e", "f", "g", "h"],
                       ["i", "j", "x", "l"]])
  }
  func testAsGrid() {
    let g = [["a", "b", "c", "d"],
             ["e", "f", "g", "h"],
             ["i", "j", "k", "l"]]
    var ps = [Pt2]()
    var vs = [String]()
    for (p, v) in g.asGrid() {
      ps.append(p)
      vs.append(v)
    }
    XCTAssertEqual(ps, [Pt2(0, 0),
                        Pt2(1, 0),
                        Pt2(2, 0),
                        Pt2(3, 0),
                        Pt2(0, 1),
                        Pt2(1, 1),
                        Pt2(2, 1),
                        Pt2(3, 1),
                        Pt2(0, 2),
                        Pt2(1, 2),
                        Pt2(2, 2),
                        Pt2(3, 2)])
    XCTAssertEqual(vs, ["a", "b", "c", "d", "e", "f", "g", "h",
                        "i", "j", "k", "l"])
  }
  func testNeighbors() {
    let grid = [[Character]](repeating: [Character](repeating: "x", count: 3),
                             count: 4)
    XCTAssertEqual(Pt2(0, 0).neighbors(grid),
                   [Pt2(1, 0), Pt2(0, 1), Pt2(1, 1)])
    let nf = { (x: Int, y: Int) in Pt2(x, y).neighbors(grid) }
    XCTAssertEqual(nf(1, 1).count, 8)
    XCTAssertEqual(nf(2, 3).count, 3)
    XCTAssertEqual(nf(2, 2).count, 5)
    XCTAssertEqual(nf(1, 3).count, 5)
  }
  func testMNeighbors() {
    let grid = [[Character]](repeating: [Character](repeating: "x", count: 3),
                             count: 4)
    XCTAssertEqual(Pt2(0, 0).mneighbors(grid),
                   [Pt2(1, 0), Pt2(0, 1)])
    let nf = { (x: Int, y: Int) in Pt2(x, y).mneighbors(grid) }
    XCTAssertEqual(nf(1, 1).count, 4)
    XCTAssertEqual(nf(2, 3).count, 2)
    XCTAssertEqual(nf(2, 2).count, 3)
    XCTAssertEqual(nf(1, 3).count, 3)
  }
  func testTNeighbors() {
    let grid = [[Character]](repeating: [Character](repeating: "x", count: 3),
                             count: 4)
    XCTAssertEqual(Pt2(0, 0).tneighbors(grid),
                   [Pt2(2, 3), Pt2(0, 3), Pt2(1, 3),
                    Pt2(2, 0), Pt2(1, 0),
                    Pt2(2, 1), Pt2(0, 1), Pt2(1, 1)])
    let nf = { (x: Int, y: Int) in Pt2(x, y).tneighbors(grid) }
    XCTAssertEqual(nf(1, 1).count, 8)
    XCTAssertEqual(nf(2, 3).count, 8)
    XCTAssertEqual(nf(2, 2).count, 8)
    XCTAssertEqual(nf(1, 3).count, 8)
  }
  
}