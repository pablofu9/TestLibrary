//
//  User.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation

struct UserResponse: Codable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int
}

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let maidenName: String
    let age: Int
    let gender: String
    let email: String
    let phone: String
    let birthDate: String
    let bloodGroup: String
    let height: Double
    let weight: Double
    let eyeColor: String
    let hair: Hair
    let address: Address
    let image: String
}

struct Hair: Codable {
    let color: String
    let type: String
}

struct Address: Codable {
    let address: String
    let city: String
    let postalCode: String
}
