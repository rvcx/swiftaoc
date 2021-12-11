import XCTest
@testable import aoclib

final class inputTests: XCTestCase {
  func testLines() throws {
    let nums = lines(file: "Tests/data/nums.txt").map { Int($0) }
    XCTAssertEqual(nums, [2, -853, 1544])
  }
  func testRecords() throws {
    let rs = records(file: "Tests/data/records.txt")
    XCTAssertEqual(rs, [["Dave Waddler", "Engineer", "8899 West 82nd St"],
                        ["Madeleine Enschly", "CEO"],
                        ["Indigo the Bloodless", "The Wastelands"]])
  }
  func testParseLines() throws {
    let ts = parseLines(#"(.*) (?:(borrowed)|(lent)|(gave)) \$(\d+) (?:from|to) (.*).$"#,
                        file: "Tests/data/transactions.txt")
    XCTAssertEqual(ts, [["Arthur Dent", "borrowed", nil, nil, "20", "Ford Prefect"],
                        ["Zaphod", nil, "lent", nil, "8", "Marvin"],
                        ["Trillian", nil, nil, "gave", "50", "Zaphod"]])
    
  }
  func testDigitGrid() {
    XCTAssertEqual(digitGrid(["012", "345", "678"]),
                             [[0, 1, 2], [3, 4, 5], [6, 7, 8]])
  }
  func testNumGrid() {
    XCTAssertEqual(numGrid(["  1  234 23", "88   2 99     "]),
                   [[1, 234, 23], [88, 2, 99]])
  }
}