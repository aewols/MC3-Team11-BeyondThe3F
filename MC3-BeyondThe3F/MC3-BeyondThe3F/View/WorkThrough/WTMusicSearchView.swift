//
//  WTMusicSearchView.swift
//  MC3-BeyondThe3F
//
//  Created by Seungui Moon on 2023/07/29.
//

import SwiftUI

struct WTMusicSearchView: View {
    @AppStorage("isFirst") private var isFirst = false
    @State private var searchTerm = ""
    @State private var showSearchView = true
    @StateObject private var musicItemUpdateViewModel = MusicItemUpdateViewModel.shared
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                Text("안녕하세요!\n요즘 가장 많이 듣는 노래를 알려주세요.")
                    .lineSpacing(7)
                    .headline(color: .white)
                Spacer()
                    .frame(height: 16)
                Text("음악명으로 검색해주세요.")
                    .body2(color: .gray400)
                    .multilineTextAlignment(.leading)
                Spacer()
                    .frame(height: 32)
                MusicSearchComponentView(searchTerm: $searchTerm, showSearchView: $showSearchView)
                MusicSearchView(
                    searchTerm: $searchTerm,
                    isUpdate: $musicItemUpdateViewModel.isUpdate
                )
                Spacer()
                NavigationLink {
                    EditMapPositionView()
                } label: {
                    PrimaryButtonComponentView(buttonType: .forSave)
                }

                    
            }
            .padding(20)
          
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.custom(.background))
            
        }
    }
}


struct WTMusicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WTMusicSearchView()
    }
}
