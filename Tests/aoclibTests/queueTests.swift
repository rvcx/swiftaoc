import XCTest
@testable import aoclib

final class queueTests: XCTestCase {
  func testPushPop() throws {
    var q = Queue<Int>()
    XCTAssertEqual(q.pop(), nil)
    q.push(1)
    XCTAssertEqual(q.pop(), 1)
    XCTAssertEqual(q.pop(), nil)
    q.push(2)
    q.push(3)
    q.push(4)
    XCTAssertEqual(q.pop(), 2)
    q.push(5)
    XCTAssertEqual(q.pop(), 3)
    XCTAssertEqual(q.pop(), 4)
    XCTAssertEqual(q.pop(), 5)
    XCTAssertEqual(q.pop(), nil)
  }
}    