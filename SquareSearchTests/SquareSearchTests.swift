//
//  SquareSearchTests.swift
//  SquareSearchTests
//
//  Created by Nick Jones on 15/09/2017.
//  Copyright © 2017 NickJones. All rights reserved.
//

import XCTest
@testable import SquareSearch

class VenueTests: XCTestCase {
    
    private var mockedVenuesData: Data?
    
    override func setUp() {
        if let mockedVenuesDataPath = Bundle.main.url(forResource: "ColchesterVenues", withExtension: "json") {
            do {
                let rawVenuesData = try Data(contentsOf: mockedVenuesDataPath)
                
                mockedVenuesData = rawVenuesData
            } catch {
                print("Unable to load the mocked venues json files; Make sure all mocked data files are present and in the correct file locations!")
                return
            }
        }
        super.setUp()
    }
    
    func testMockedVenuesDataHasLoaded() {
        XCTAssertNotNil(mockedVenuesData, "Mocked venues data was not loaded correctly")
    }
    
    func testParseVenuesFromRawDataReturnsTheCorrectNumberOfVenues() {
        let venues = Venues.parse(fromRawData: mockedVenuesData)
        XCTAssert(venues.count == 5, "Unable to parse the correct number of venues from the mocked data")
    }
}
