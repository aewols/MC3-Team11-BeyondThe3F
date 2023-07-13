//
//  AustinView.swift
//  BaseTest
//
//  Created by Seungui Moon on 2023/07/12.
//

import SwiftUI

struct AustinView: View {
    var body: some View {
        TabView {
            AustinHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AustinTestMapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            AustinSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            AustinSettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
    }
}

struct AustinView_Previews: PreviewProvider {
    static var previews: some View {
        AustinView()
    }
}
