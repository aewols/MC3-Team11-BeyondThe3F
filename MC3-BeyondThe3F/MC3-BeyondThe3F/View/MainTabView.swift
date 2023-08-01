//
//  MainTabView.swift
//  MC3-BeyondThe3F
//
//  Created by Seungui Moon on 2023/07/18.
//

import SwiftUI

struct MainTabView: View {
    @State private var showWelcomeSheet = false
    @AppStorage("isFirst") private var isFirst = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.custom(.gray200))
        UITabBar.appearance().backgroundColor = UIColor(Color.custom(.background))
    }
    
    var body: some View {
        TabView() {
                BucketView()
                    .tabItem {
                        Image(systemName: "tray.full.fill")
                        Text("보관함")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("지도")
                    }
        }
        .tint(.custom(.primary))
        .onAppear{
            if isFirst {
                showWelcomeSheet = true
            }
            Task{
                await insertDummy()
                await AuthManger.requestMusicAuth()
            }           
        }
        .sheet(isPresented: $showWelcomeSheet, onDismiss: {
            isFirst = false
        },content: {
            WelcomeSheetComponentView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
