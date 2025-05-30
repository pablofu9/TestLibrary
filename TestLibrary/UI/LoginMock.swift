//
//  LoginMock.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import SwiftUI

enum Field: String {
    case email
    case pass
    case name
}

struct LoginMock: View {
    
    @StateObject var keyBoardManager = KeyboardObserver()
    @State var email = ""
    @State var pass = ""
    @State var name = ""
    @FocusState private var field: Field?
    
    private var imageHeight: CGFloat {
        keyBoardManager.isKeyboardVisible ? 100 : 300
    }
    
    private var bottomPadding: CGFloat {
        keyBoardManager.isKeyboardVisible ?  keyBoardManager.keyboardHeight  : UIApplication.shared.keyWindowSafeAreaInsets.bottom
    }
    
    private var bottomInset: CGFloat {
        keyBoardManager.isKeyboardVisible ?  keyBoardManager.keyboardHeight + 60 : 30
    }
    
    private var bottomPaddingbasedOnSize: CGFloat {
        switch UIScreen.main.deviceScreenType {
        case .iPhoneSE, .iPhoneMini:
            return keyBoardManager.isKeyboardVisible ? 0 : 20
        case .iPhoneStandard, .iPhonePlus, .iPad:
            return 0
        case .unknown:
            return 0
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                imageTop
                ZStack(alignment: .bottom) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 30) {
                              formView
                                    .onChange(of: field) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation {
                                                proxy.scrollTo(field?.rawValue, anchor: .top)
                                            }
                                        }
                                    }
                                
                            }
                            .safeAreaInset(edge: .bottom) {
                                EmptyView()
                                    .frame(height: bottomInset )
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 40)
                        }
                        .background(.white)
                        .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                        .offset(y: -30)
                        .animation(.easeInOut, value: keyBoardManager.keyboardHeight)
                    }
                 
                    loginBtton
                }
 
            }

        }
        .onChange(of: bottomPadding) {
            print("Bottom padding, \(bottomPadding)")
        }
        
        .ignoresSafeArea()
        
    }
    
    @ViewBuilder
    private var loginBtton: some View {
        Button {
            // Acción de login
        } label: {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.blue)
                .frame(height: 40)
                .overlay(
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .bold()
                )
        }
        .padding(.vertical, keyBoardManager.isKeyboardVisible ? 10 : 0)
        .padding(.horizontal, 30)
        .animation(.easeInOut(duration: 0.3), value: bottomPadding)
        .background(
            Color.white
                .opacity(keyBoardManager.isKeyboardVisible ? 1 : 0)
                .animation(.easeInOut(duration: 0.4), value: keyBoardManager.isKeyboardVisible)
        )
        .offset(y: -bottomPadding)
        .padding(.bottom, bottomPaddingbasedOnSize)
     
    }
    
    @ViewBuilder
    private var imageTop: some View {
        Image(.mock)
            .resizable()
            .scaledToFill()
            .frame(height: imageHeight)
            .clipped()
            .animation(.easeInOut(duration: 0.25), value: keyBoardManager.isKeyboardVisible)
    }
    
    @ViewBuilder
    private var formView: some View {
        Group {
            TextField("Email", text: $email)
                .id(Field.email.rawValue)
                .focused($field, equals: .email)
            TextField("Email", text: $name)
                .id(Field.pass.rawValue)
                .focused($field, equals: .pass)
            TextField("Email", text: $pass)
                .id(Field.name.rawValue)
                .focused($field, equals: .name)
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
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
