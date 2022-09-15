//
//  SpaceXTests.swift
//  FeedViewModelTest
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import XCTest
import Apollo
import Combine
@testable import SpaceX

enum MockError: Error {
    case error
}

class FeedViewModelTest: XCTestCase {
    
    private var viewModel: FeedViewModel!
    private var mockClient: MockService!
    private var mockCoordinator: MockCoordinator!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        
        mockCoordinator = MockCoordinator()
        mockClient = MockService()
        viewModel = FeedViewModel(httpClient: mockClient,
                                  coordinator: mockCoordinator)
    }

    override func tearDown() {
        mockCoordinator = nil
        mockClient = nil
        viewModel = nil
        cancellables = []
        
        super.tearDown()
    }
    
    func test_getLaunch_ShouldCallService() {
        //given
        viewModel.getLaunches()
        //then
        XCTAssertEqual(mockClient.getCallCounts, 1)
    }
    
    func test_willDisplay_ShouldPagination() {
        //given
        mockClient.result = .success(LaunchModel.generateMockLauncModel())
        //when
        viewModel.getLaunches()
        viewModel.onWillDisplay(indexPath: IndexPath(item: 0, section: 0))
        //then
        XCTAssertEqual(mockClient.getCallCounts, 2)
        XCTAssertEqual(viewModel.offset, 1)
    }
    
    func test_DidSelect_ShouldGoToDetail() {
        //given
        mockClient.result = .success(LaunchModel.generateMockLauncModel())
        //when
        viewModel.getLaunches()
        viewModel.onDidSelect(indexPath: IndexPath(item: 0, section: 0))
        //then
        XCTAssertEqual(mockCoordinator.isDetailOcuorred, true)
    }
    
    func test_getLaunch_givenServiceCallSucceeds_shouldUpdateLaunch() {
        //given
        mockClient.result = .success(LaunchModel.generateMockLauncModel())
        
        //when
        viewModel.getLaunches()
        
        //then
        XCTAssertEqual(mockClient.getCallCounts, 1)
        viewModel.$launchs
            .sink { XCTAssertEqual($0, LaunchModel.generateMockLauncModel())}
            .store(in: &cancellables)
        viewModel.$state
            .sink { XCTAssertEqual($0, .finishedLoading)}
            .store(in: &cancellables)
    }
    
    func test_getLaunch_givenServiceCallFails_shouldUpdateWithError() {
        //given
        mockClient.result = .failure(MockError.error)
        
        //when
        viewModel.getLaunches()
        
        //then
        XCTAssertEqual(mockClient.getCallCounts, 1)
        
        viewModel.$launchs
            .sink { XCTAssert($0.isEmpty)}
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { XCTAssertEqual($0, .error(ListViewModelError.launchFetch.localizedDescription))}
            .store(in: &cancellables)
    }

}
