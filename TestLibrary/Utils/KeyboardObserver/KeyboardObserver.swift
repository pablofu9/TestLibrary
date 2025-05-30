//
//  KeyboardObserver.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation
import Combine
import UIKit

final class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var isKeyboardVisible: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }
            .receive(on: DispatchQueue.main) // 👈 Asegura main thread
            .sink { [weak self] height in
                self?.keyboardHeight = height
                self?.isKeyboardVisible = height > 0
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .receive(on: DispatchQueue.main) // 👈 También aquí
            .sink { [weak self] _ in
                self?.keyboardHeight = 0
                self?.isKeyboardVisible = false
            }
            .store(in: &cancellables)
    }
}
