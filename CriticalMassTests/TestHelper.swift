//
//  TestHelper.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 5/12/19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

@testable import CriticalMaps
import XCTest

class MockLocationProvider: LocationProvider {
    func updateLocation(completion: ResultCallback<Location>?) {
        if let location = mockLocation {
            completion?(.success(location))
        } else {
            completion?(.failure(.noData(nil)))
        }
    }

    static var accessPermission: LocationProviderPermission = .authorized

    var mockLocation: Location?

    var currentLocation: Location? {
        mockLocation
    }
}

class MockNetworkLayer: NetworkLayer {
    var mockResponse: Decodable?
    var shouldReturnResponse = true
    var lastUsedPostBody: [String: Any]?
    var numberOfRequests: Int {
        numberOfGetCalled + numberOfPostCalled
    }

    var numberOfGetCalled = 0
    var numberOfPostCalled = 0

    func get<T: APIRequestDefining>(request _: T, completion: @escaping ResultCallback<T.ResponseDataType>) {
        numberOfGetCalled += 1
        if shouldReturnResponse {
            guard let response = mockResponse as? T.ResponseDataType else {
                completion(.failure(NetworkError.unknownError(message: "Should be ResponseDataType")))
                return
            }
            completion(.success(response))
        }
    }

    func post<T: APIRequestDefining>(request _: T, bodyData: Data, completion: @escaping ResultCallback<T.ResponseDataType>) {
        numberOfPostCalled += 1
        lastUsedPostBody = try! JSONSerialization.jsonObject(with: bodyData, options: []) as! [String: Any]
        if shouldReturnResponse {
            guard let response = mockResponse as? T.ResponseDataType else {
                completion(.failure(NetworkError.unknownError(message: "Should be ResponseDataType")))
                return
            }
            completion(.success(response))
        }
    }
}

class MockIDProvider: IDProvider {
    var token: String = "MockTocken"

    var mockID: String?
    var id: String {
        if let mockID = mockID {
            return mockID
        } else {
            return UUID().uuidString
        }
    }

    static func hash(id: String, currentDate _: Date) -> String {
        id
    }
}

class MockDataStore: DataStore {
    func remove(friend: Friend) {
        guard let index = friends.firstIndex(of: friend) else {
            return
        }
        friends.remove(at: index)
    }

    func add(friend: Friend) {
        friends.append(friend)
    }

    var friends: [Friend] = []
    var userName: String = "Jan Ullrich"

    var storedData: ApiResponse?
    func update(with response: ApiResponse) {
        storedData = response
    }
}

class MockNetworkObserver: NetworkObserver {
    var status: NetworkStatus = .none
    var statusUpdateHandler: ((NetworkStatus) -> Void)?

    func update(with status: NetworkStatus) {
        self.status = status
        statusUpdateHandler?(status)
    }
}

extension XCTestCase {
    func wait(interval: TimeInterval, completion: @escaping () -> Void) {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            completion()
        }
    }

    func execute(times: UInt, _ function: @autoclosure () -> Void) {
        (0 ..< times).forEach { _ in
            function()
        }
    }
}
