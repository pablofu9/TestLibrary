//
//  LoginMock.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import SwiftUI

struct LoginMock: View {
    
    @StateObject var keyBoardManager = KeyboardObserver()
    
    private var imageHeight: CGFloat {
        keyBoardManager.isKeyboardVisible ? 150 : 300
    }
    
    private var bottomPadding: CGFloat {
        keyBoardManager.isKeyboardVisible ?  keyBoardManager.keyboardHeight + 15 : UIApplication.shared.keyWindowSafeAreaInsets.bottom
    }
    
    private var bottomInset: CGFloat {
        keyBoardManager.isKeyboardVisible ?  keyBoardManager.keyboardHeight : 30
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Image(.mock)
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageHeight)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: keyBoardManager.isKeyboardVisible)
                ScrollView {
                    LazyVStack(spacing: 30) {
                        Group {
                            TextField("Email", text: .constant("Email"))
                            TextField("Email", text: .constant("Email"))
                            TextField("Email", text: .constant("Email"))
                            TextField("Email", text: .constant("Email"))
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        
                    }
                    .safeAreaInset(edge: .bottom) {
                        EmptyView()
                            .frame(height: bottomInset)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                   
                    
                }
                .background(.white)
                .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                .offset(y: -50)
                .animation(.easeInOut, value: keyBoardManager.keyboardHeight)
                
                VStack {
                    Spacer()
                    Button {
                        // Acción de login
                    } label: {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.blue)
                            .frame(height: 30)
                            .overlay(
                                Text("LOGIN")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                    }
                    .padding(.horizontal, 30)
                    .animation(.easeInOut(duration: 0.3), value: bottomPadding)
                }
                .background(.red)
                .frame(height: 40)
                .offset(y:  -bottomPadding)
                
            }
        }
        .ignoresSafeArea()
        
    }
}


#Preview {
    LoginMock()
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
