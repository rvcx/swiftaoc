import XCTest
@testable import aoclib

final class heapTests: XCTestCase {
  func testPushPop() throws {
    var h = Heap<Int>() { $0 < $1 }
    XCTAssertEqual(h.isEmpty, true)
    h.push(3)
    XCTAssertEqual(h.isEmpty, false)
    h.push(5)
    h.push(2)
    h.push(4)
    XCTAssertEqual(h.pop(), 2)
    h.push(6)
    h.push(1)
    h.push(5)
    XCTAssertEqual(h.pop(), 1)
    XCTAssertEqual(h.pop(), 3)
    XCTAssertEqual(h.pop(), 4)
    XCTAssertEqual(h.pop(), 5)
    XCTAssertEqual(h.pop(), 5)
    XCTAssertEqual(h.isEmpty, false)
    XCTAssertEqual(h.pop(), 6)
    XCTAssertEqual(h.isEmpty, true)
    XCTAssertEqual(h.pop(), nil)
    XCTAssertEqual(h.isEmpty, true)
  }
}