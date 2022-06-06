import XCTest
@testable import AlertViewLibrary

final class AlertViewLibraryTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
       // XCTAssertEqual(AlertViewLibrary().text, "Hello, World!")
       // XCTAssertEqual(AlertViewLibrary().)
        let alert = AlertViewLibrary()
        alert.show { _ in
            
        }
    }
}
