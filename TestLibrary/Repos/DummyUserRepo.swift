//
//  CategoriesWebRepo.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 27/5/25.
//


import APIRestDI
import Foundation
import SwiftUI

protocol DummyUserRepo: WebRepository {
    
    func fetchUsers() async throws -> UserResponse
}


struct RealDummyUserRepo: DummyUserRepo {
    
    /// The URLSession used for network requests.
    var session: URLSession
    
    /// The base URL for the API.
    @BaseURLSlashed private(set) var baseURL: String
    
    /// Initializes a `RealEmergenciesWebRepository` instance.
    /// - Parameters:
    ///   - session: The URLSession to use for network requests.
    ///   - baseURL: The base URL for the API.
    init(session: URLSession, baseURL: String){
        self.session = session
        self.baseURL = baseURL
    }
    
    // MARK: - API endpoints
    /// Fetch Users
    func fetchUsers() async throws -> UserResponse {
        return try await call(endpoint: API.fetchUsers)
    }
}

/// A mock implementation of `EmergenciesWebRepository` for testing purposes.
struct MockDummyUserRepo: DummyUserRepo {
    
    /// The URLSession used for network requests.
    var session: URLSession = .mockedResponsesOnly
    
    /// The base URL for the mock API.
    var baseURL: String = "https://mockapi.io/api/v1/user/123"
    
    
    func fetchUsers() async throws -> UserResponse {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return UserResponse(users: [], total: 0, skip: 0, limit: 0)
    }
}

// MARK: - API endpoints
extension RealDummyUserRepo {
    enum API {
        case fetchUsers
    }
}

extension RealDummyUserRepo.API: APICall {
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUsers:
            return .get
        }
    }
    
    var authenticated: Bool {
        switch self {
        case .fetchUsers:
            return true
        }
    }
    
    func headers() async throws -> [String : String]? {
        switch self {
        case .fetchUsers:
            return [:]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .fetchUsers:
            return nil
        }
    }
}


