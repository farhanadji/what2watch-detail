import XCTest
@testable import Detail

final class DetailTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Detail().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
