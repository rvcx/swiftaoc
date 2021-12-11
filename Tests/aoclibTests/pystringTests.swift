import XCTest
@testable import aoclib

final class pystringTests: XCTestCase {
  func testSubscript() throws {
    XCTAssertEqual("abcde"[0], "a")
    XCTAssertEqual("abcde"[2], "c")
    XCTAssertEqual("abcde"[4], "e")
    XCTAssertEqual("abcde"[-1], "e")
    XCTAssertEqual("abcde"[-5], "a")
    // TODO: implement the magic to enable these tests
    // https://stackoverflow.com/questions/32873212/unit-test-fatalerror-in-swift
//        XCTAssertFatalError("abcde"[-1])
//        XCTAssertFatalError("abcde"[5])
  }
  func testSlice() throws {
    XCTAssertEqual("abcde".slice(0, 3), "abc")
    XCTAssertEqual("abcde".slice(2, 5), "cde")
    XCTAssertEqual("abcde".slice(2, 1), "")
    XCTAssertEqual("abcde".slice(2, 10), "cde")
    XCTAssertEqual("abcde".slice(0, 5), "abcde")
    XCTAssertEqual("abcde".slice(0, -1), "abcd")
    XCTAssertEqual("abcde".slice(0, -3), "ab")
    XCTAssertEqual("abcde".slice(0, -5), "")
    XCTAssertEqual("abcde".slice(0, -10), "")
    XCTAssertEqual("abcde".slice(-4, -1), "bcd")
    XCTAssertEqual("abcde".slice(-10, -1), "abcd")
    XCTAssertEqual("abcde".slice(-10, -11), "")
    XCTAssertEqual("abcde".slice(0, through: 2), "abc")
    XCTAssertEqual("abcde".slice(2, through: 4), "cde")
    XCTAssertEqual("abcde".slice(2, through: -1), "cde")
    XCTAssertEqual("abcde".slice(1, nil), "bcde")
    XCTAssertEqual("abcde".slice(1), "bcde")
  }
  func testFind() throws {
    let s = "abcdefghiabc"
    XCTAssertEqual(s.find("abc"), s.index(s.startIndex, offsetBy: 0))
    XCTAssertEqual(s.find("bcd"), s.index(s.startIndex, offsetBy: 1))
    XCTAssertEqual(s.find("cba"), nil)
  }
  func testFindAll() throws {
    let s = "abababababa"
    XCTAssertEqual(s.findAll("aba"),
                   [0, 2, 4, 6, 8].map { s.index(s.startIndex, offsetBy: $0) })
  }
  func testStripped() throws {
    XCTAssertEqual("foo".stripped(), "foo")
    XCTAssertEqual("  foo ".stripped(), "foo")
    XCTAssertEqual("".stripped(), "")
    XCTAssertEqual("   ".stripped(), "")
  }
  func testSplit() throws {
    XCTAssertEqual("fooandbar".split("and"), ["foo", "bar"])
    XCTAssertEqual("    foo bar  baz ".split(), ["foo", "bar", "baz"])
  }
//  func testPartition() throws {
//    XCTAssertEqual("fooandbar".partition("and"), ("foo", "and", "bar"))
//  }
  func testJoin() throws {
    XCTAssertEqual(" ".join(["foo", "bar", "baz"]), "foo bar baz")
  }
  func testReplaced() throws {
    XCTAssertEqual("foo and bar and baz".replaced(old: "and", new: "or"),
                   "foo or bar or baz")
  }
  func testLjust() throws {
    XCTAssertEqual("foo".ljust(5), "foo  ")
  }
  func testRjust() throws {
    XCTAssertEqual("foo".rjust(5), "  foo")
  }
  func testCenter() throws {
    XCTAssertEqual("foo".center(5), " foo ")
  }
}
