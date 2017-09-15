
//  PhotoTests
//  Copyright © 2017 NickJones. All rights reserved.

import XCTest
@testable import SquareSearch

class PhotoTests: XCTestCase {
    private var mockedPhotosData: Data?
    
    override func setUp() {
        if let mockedPhotosDataPath = Bundle.main.url(forResource: "ColchesterPrezzoPhotos", withExtension: "json") {
            do {
                let rawPhotosData = try Data(contentsOf: mockedPhotosDataPath)
                
                mockedPhotosData = rawPhotosData
            } catch {
                print("Unable to load the mocked photos json files; Make sure all mocked data files are present and in the correct file locations!")
                return
            }
        }
        super.setUp()
    }
    
    func testMockedPhotoesDataHasLoaded() {
        XCTAssertNotNil(mockedPhotosData, "Mocked photos data was not loaded correctly")
    }
    
    func testCreatePhotoURLReturnsTheCorrectPath() {
        let completePhotoPath: String = Photo.createPhotoURL(fromRawPhotoData: mockedPhotosData)
        XCTAssert(completePhotoPath == "https://igx.4sqi.net/img/general/960x720//48882870_rDAmyLTluuMOCHviQ5C_3w_9ItfEsoEzoSthJmjlxRU.jpg", "Unable to parse the correct path from the mocked photo path data")
    }
    
}
