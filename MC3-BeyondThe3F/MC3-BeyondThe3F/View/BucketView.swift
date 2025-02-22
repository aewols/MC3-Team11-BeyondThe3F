//
//  BucketView.swift
//  MC3-BeyondThe3F
//
//  Created by Seungui Moon on 2023/07/18.
//

import SwiftUI

struct BucketView: View {
    @StateObject private var navigationHelper = BucketNavigationHelper.shared
    @StateObject private var musicItemUpdateViewModel = MusicItemUpdateViewModel.shared
    @State private var searchTerm = ""
    @State private var showSearchView = false
    @State private var showMusicPlayView = false
    @State private var showAddMusicView = false
        
    var body: some View {
        NavigationStack(path: $navigationHelper.path) {
            VStack {
                MusicSearchComponentView(searchTerm: $searchTerm, showSearchView: $showSearchView)
                    .padding()
                if showSearchView {
                    MusicSearchView(
                        searchTerm: $searchTerm,
                        isUpdate: $musicItemUpdateViewModel.isUpdate
                    )
                } else {
                    CarouselView()
                }
                Button {
                    showMusicPlayView = true
                } label: {
                    MusicPlayerComponentView()
                }
            }
            .background(Color.custom(.background))
            .sheet(isPresented: $showMusicPlayView) {
                MusicPlayView()
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $musicItemUpdateViewModel.isUpdate) {
                EditMapPositionView()
            }
        }
    }
}

struct BucketView_Previews: PreviewProvider {
    static var previews: some View {
        BucketView()
    }
}
