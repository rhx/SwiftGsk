import XCTest
import CGsk
@testable import Gsk

final class GskTests: XCTestCase {
    func testNewTransformHasIdentityCategory() {
        guard let transform = gsk_transform_new() else {
            XCTFail("Could not create a Gsk transform")
            return
        }
        defer { gsk_transform_unref(transform) }

        XCTAssertEqual(gsk_transform_get_category(transform),
                       GSK_TRANSFORM_CATEGORY_IDENTITY)
    }
}
