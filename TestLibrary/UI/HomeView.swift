//
//  HomeView.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var homeVM = HomeVM()
    @StateObject private var keyboard = KeyboardObserver()
    @State var text = ""
    var body: some View {
        VStack {
            TextField("Escribe algo...", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.bottom, keyboard.keyboardHeight)
                .padding(.horizontal, 20)
        }
        .padding(.bottom, Constants.safeAreaInset.bottom)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeOut(duration: 0.5), value: keyboard.keyboardHeight)
        
        
        //        UIKitTableView(
        //            users: homeVM.users?.users ?? [],
        
        //            onRefresh: {
        //                Task { try? await homeVM.fetchUsers() }
        //            },
        //            onSelectUser: { user in
        //                print("Selected user: \(user.firstName)")
        //            },
        //            onDeleteUser: { index in
        //                // homeVM.users?.users.remove(at: index)
        //            }, homeVM: homeVM
        //        )
        //        .ignoresSafeArea()
        //        .task {
        //            try? await homeVM.fetchUsers()
        //        }
    }
}

#Preview {
    HomeView()
}

