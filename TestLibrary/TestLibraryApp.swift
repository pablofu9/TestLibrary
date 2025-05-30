//
//  TestLibraryApp.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 27/5/25.
//

import SwiftUI
import APIRestDI

@main
struct TestLibraryApp: App {

    init() {
        // 1. Registra un configurador con dependencias dinámicas
        Dependencies.shared.registerConfigurator { testMode in
            // Usa el session y baseURL directamente desde Dependencies
            let session = Dependencies.shared.session
            let baseUrl = "https://dummyjson.com"

            if testMode {
                @Provider var dummyUserRepo = MockDummyUserRepo() as DummyUserRepo
            } else {
                @Provider var dummyUserRepo = RealDummyUserRepo(session: session, baseURL: baseUrl) as DummyUserRepo
            }
        }

        // 2. Llama a `provideDependencies` según el entorno
        Dependencies.shared.provideDependencies(testMode: false)
    }

    var body: some Scene {
        WindowGroup {
            LoginMock()
        }
    }
}

