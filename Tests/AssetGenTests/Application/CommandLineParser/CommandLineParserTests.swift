import XCTest
@testable import AssetGen

final class CommandLineParserTests: XCTestCase {
  private lazy var sut: CommandLineParser = {
    return makeSUT()
  }()
  
  func test_parse_throwsNotEnoughArgumentsError_forNotEnoughArguments() {
    let arguments = ["AssetGen"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.notEnoughArguments.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidAssetGenerationTypeError_forInvalidAssetGenerationType() {
    let arguments = ["AssetGen", "invalid:ios", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidAssetGenerationType.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidAssetGenerationTypeError_forInvalidAssetGenerationTypeAndPlaform() {
    let arguments = ["AssetGen", "", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidAssetGenerationType.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidPlatformError_forInvalidPlatform() {
    let arguments = ["AssetGen", "localization:invalid", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidPlatform.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidConfigFilePathError_forInvalidConfigFilePath() {
    let arguments = ["AssetGen", "localization:ios", "config.txt"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidConfigFilePath.localizedDescription)
    }
  }
  
  func test_parse_parsesArgumentsCorrectly_forValidArguments() throws {
    let arguments = ["AssetGen", "localization:ios", "config.json"]
        
    let commandLineArguments = try sut.parse(arguments: arguments)
    
    XCTAssertEqual(commandLineArguments.generationType, .localization)
    XCTAssertEqual(commandLineArguments.platform, .ios)
    XCTAssertEqual(commandLineArguments.configFilePath, "config.json")
  }
}

private extension CommandLineParserTests {
  func makeSUT() -> CommandLineParser {
    CommandLineParser()
  }
}
