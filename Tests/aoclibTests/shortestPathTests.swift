import XCTest
@testable import aoclib

final class shortestPathTests: XCTestCase {
  func testShortestPath() {
    let maze = [".....",
                "XXX..",
                "....."]
    let nf = { (p: Pt2) in p.neighbors(maze).filter {
                             maze[$0] != Character("X")
                           } }
    XCTAssertEqual(shortestPath(from: Pt2(0, 0), to: Pt2(0, 2), neighbors: nf),
                   [Pt2(0, 0), Pt2(1, 0), Pt2(2, 0), Pt2(3, 1),
                    Pt2(2, 2), Pt2(1, 2), Pt2(0, 2)])
  }
}