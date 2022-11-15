//
//  HomeViewModelTests.swift
//  BookStore_AdrielFreireTests
//
//  Created by Adriel Freire on 14/11/22.
//

import Foundation
import XCTest
@testable import BookStore_AdrielFreire

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel?
    var volumesFactory = HomeVolumesFactory()
    
    override func setUp() {
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testRequestVolumesSuccess() {
        // Given
        let provider = NetworkMockProvider(volumesFactory.build(), requestSuccess: true)
        sut = HomeViewModel(provider)
        let spy = HomeViewModelSpy()
        sut?.delegate = spy
        
        // When
        sut?.requestVolumes()
        
        // Then
        XCTAssertTrue(spy.calledDidUpdateVolumes)
        XCTAssertEqual(spy.updatedVolumes.count, 2)
        XCTAssertEqual(sut?.getNumberOfVolumes(), spy.updatedVolumes.count)
    }
    
    func testRequestVolumesFailed() {
        // Given
        let provider = NetworkMockProvider(volumesFactory.build(), requestSuccess: false)
        sut = HomeViewModel(provider)
        let spy = HomeViewModelSpy()
        sut?.delegate = spy
        
        // When
        sut?.requestVolumes()
        
        // Then
        XCTAssertFalse(spy.calledDidUpdateVolumes)
        XCTAssertEqual(spy.updatedVolumes.count, 0)
    }
}


    final class HomeViewModelSpy: HomeViewModelDelegate {
        
        var calledDidUpdateVolumes = false
        var updatedVolumes = [Volume]()
        func homeViewModel(_ homeViewModel: BookStore_AdrielFreire.HomeViewModel, didUpdateVolumes volumes: [BookStore_AdrielFreire.Volume]) {
            calledDidUpdateVolumes = true
            updatedVolumes = volumes
        }
        
        
    }
