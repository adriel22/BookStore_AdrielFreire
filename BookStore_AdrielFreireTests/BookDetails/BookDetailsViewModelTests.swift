//
//  BookDetailsViewModelTests.swift
//  BookStore_AdrielFreireTests
//
//  Created by Adriel Freire on 15/11/22.
//

import Foundation
import XCTest
@testable import BookStore_AdrielFreire

final class BookDetailsViewModelTests: XCTestCase {
    var sut: BookDetailsViewModel?
    var volumesFactory = HomeVolumesFactory()
    
    override func tearDown() {
        sut = nil
    }
    
    func testAuthorsString() {
        // Given
        let volume = volumesFactory.build().items[0]
        let expectedString = "Jhon, Anna, Maria"
        sut = BookDetailsViewModel(volume)
        
        // When
        let authorsString = sut?.getVolumeDetails()[2].content
        
        // Then
        XCTAssertEqual(volume.volumeInfo.authors.count, 3)
        XCTAssertEqual(authorsString!, expectedString)
    }
    
    func testSaleLinkIncluded() {
        // Given
        let volume = volumesFactory.build().items[0]
        sut = BookDetailsViewModel(volume)
        
        // When
        let saleLink = sut?.getSaleLink()
        
        // Then
        XCTAssertEqual(saleLink, "TestLink")
    }
    
    func testSaleLinkMissing() {
        // Given
        let volume = volumesFactory.build().items[1]
        sut = BookDetailsViewModel(volume)
        
        // When
        let saleLink = sut?.getSaleLink()
        
        // Then
        XCTAssertEqual(saleLink, nil)
    }
}
