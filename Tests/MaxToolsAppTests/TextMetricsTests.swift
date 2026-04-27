import XCTest
@testable import MaxToolsApp

final class TextMetricsTests: XCTestCase {
    func testCountsEmptyText() {
        let metrics = TextMetrics("")

        XCTAssertEqual(metrics.characters, 0)
        XCTAssertEqual(metrics.words, 0)
        XCTAssertEqual(metrics.lines, 0)
    }

    func testCountsWordsAndLines() {
        let metrics = TextMetrics("hello world\nfrom MaxTools")

        XCTAssertEqual(metrics.characters, 25)
        XCTAssertEqual(metrics.words, 4)
        XCTAssertEqual(metrics.lines, 2)
    }
}
