import XCTest
@testable import AssetGen

final class IOSPlaceholderMapperTests: XCTestCase {
  func test_mapPlaceholders_returnsSameContent() {
    let givenContent = "test_content"
    let sut = IOSPlaceholderMapper()
    
    let expectedContent = sut.mapPlaceholders(givenContent)
    
    XCTAssertEqual(givenContent, expectedContent)
  }
}
