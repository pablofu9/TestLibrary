//
//  HomeVM.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation
import APIRestDI


@Observable
class HomeVM {
    private(set) var users: UserResponse?
    
    func fetchUsers() async throws {
        @Inject var dummyRepo: DummyUserRepo
        do {
            users = try await dummyRepo.fetchUsers()
        } catch {
            print("Error getting data, \(error)")
        }
    }
}
