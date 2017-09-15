
//  SquareSearchTests
//  Copyright © 2017 NickJones. All rights reserved.

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
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        XCTAssert(venues.count == 5, "Unable to parse the correct number of venues from the mocked data")
    }
    
    func testNameIsReturnedInTheCorrectFormat() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //We're safe to force unwrap the first object here because we've already checked that the array is not empty
        XCTAssertEqual(
            venues.first!.Name,
            "Prezzo",
            "Venue title is not being parsed to the correct format"
        )
    }
    
    func testDefaultNameValueIsCorrectWhenNameIsUnavailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.count < 2) {
            XCTFail("Incorrect number of venues are being parsed from the mocked data")
            return
        }
        
        //Again we're safe to force unwrap the first object here because we've already checked that the array contains two objects
        XCTAssertEqual(
            venues[1].Name,
            "N/A",
            "Venue name property is not being set to the correct default value when name is not available"
        )
    }
    
    func testCheckinsIsReturnedInTheCorrectFormat() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //We're safe to force unwrap the first object here because we've already checked that the array is not empty
        XCTAssertEqual(
            venues.first!.Checkins,
            186,
            "Venue checkins is not being parsed to the correct format"
        )
    }
    
    func testDefaultCheckinsValueIsCorrectWhenCheckinsIsUnavailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.count < 2) {
            XCTFail("Incorrect number of venues are being parsed from the mocked data")
            return
        }
        
        //Again we're safe to force unwrap the first object here because we've already checked that the array contains two objects
        XCTAssertEqual(
            venues[1].Checkins,
            0,
            "Venue checkins is not being set to the correct default value when checkins is not available"
        )
    }
    
    func testCategoryNameIsInTheCorrectFormatWhenAvailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //We're safe to force unwrap the first object here because we've already checked that the array is not empty
        XCTAssertEqual(
            venues.first!.CategoryName,
            "Italian",
            "CategoryName property is not being extracted when available"
        )
    }
    
    func testDefaultCategoryNameValueIsCorrectWhenCategoryNameIsUnavailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //Again we're safe to force unwrap the first object here because we've already checked that the array contains two objects
        if (venues.count < 2) {
            XCTFail("Incorrect number of venues are being parsed from the mocked data")
            return
        }
        
        XCTAssertEqual(
            venues[1].CategoryName,
            "N/A",
            "CategoryName property is not being set to the correct default value when CategoryName is not available"
        )
    }
    
    func testIDIsRetrievedWhenAvailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //We're safe to force unwrap the first object here because we've already checked that the array is not empty
        XCTAssertEqual(
            venues.first!.ID,
            "4c0a3a0e6071a593e629df32",
            "ID property is not being extracted when available"
        )
    }
    
    
    func testDefaultIDIsEmptyWhenIDIsUnavailable() {
        let venues = Venue.parseVenues(fromRawData: mockedVenuesData)
        
        if (venues.isEmpty) {
            XCTFail("No venues were found")
            return
        }
        
        //Again we're safe to force unwrap the first object here because we've already checked that the array contains two objects
        if (venues.count < 2) {
            XCTFail("Incorrect number of venues are being parsed from the mocked data")
            return
        }
        
        XCTAssertEqual(
            venues[1].ID,
            "",
            "ID property is not empty value when the ID is not available"
        )
    }
}
