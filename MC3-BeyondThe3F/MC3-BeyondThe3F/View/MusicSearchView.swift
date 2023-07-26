//
//  MusicSearchView.swift
//  MC3-BeyondThe3F
//
//  Created by 이연정 on 2023/07/24.
//

import SwiftUI
import MusicKit


struct MusicSearchView: View {
    @StateObject private var musicSearchViewModel = MusicSearchViewModel()
    @Binding var searchTerm: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 24)
                switch musicSearchViewModel.musicSearchState {
                case .notSearched:
                    ResentlySearchTitle
                    Spacer()
                        .frame(height: 16)
                    if musicSearchViewModel.resentlySearchList.isEmpty {
                        Spacer()
                            .frame(height: 16)
                        Text("최근 검색어 내역이 없습니다.")
                            .body2(color: .gray400)
                    } else {
                        ResentlySearchList
                    }
                    Spacer()
                case .searching:
                    HStack {
                        Spacer()
                        ProgressView("음악 검색 중")
                            .foregroundColor(Color.custom(.gray400))
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.custom(.gray400)))
                        Spacer()
                    }
                case .notFound:
                    HStack {
                        Spacer()
                        Text("해당하는 노래를 찾지 못했습니다")
                            .body2(color: .gray400)
                        Spacer()
                    }
                case .success:
                    ScrollView {
                        MusicSearchResultsList
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.custom(.background))
            .onChange(of: searchTerm, perform: musicSearchViewModel.requestUpdateSearchResults)
        }
    }
}

extension MusicSearchView {
    private var ResentlySearchTitle: some View {
        HStack {
            Text("최근 검색 목록")
                .headline(color: .white)
            Spacer()
            Button {
                musicSearchViewModel.resentlySearchList.removeAll()
            } label: {
                Text("모두 지우기")
                    .body2(color: .primary)
            }
        }
    }
    
    private var ResentlySearchList: some View {
        VStack {
            ForEach(0 ..< musicSearchViewModel.resentlySearchList.count, id: \.self) { index in
                HStack {
                    Text(musicSearchViewModel.resentlySearchList[index].searchText)
                        .body1(color: .white)
                    Spacer()
                    Text(musicSearchViewModel.resentlySearchList[index].stringDate)
                        .body2(color: .gray400)
                    Spacer()
                        .frame(width: 24)
                    SFImageComponentView(
                        symbolName: .cancel,
                        color: .white,
                        width: 16,
                        height: 16
                    )
                    .onTapGesture {
                        musicSearchViewModel.resentlySearchList.remove(at: index)
                    }
                }
                .frame(maxWidth: 390)
                .frame(height: 56)
                .onTapGesture {
                    musicSearchViewModel.searchHistoryTerm(historyTerm: musicSearchViewModel.resentlySearchList[index].searchText)
                    searchTerm = musicSearchViewModel.resentlySearchList[index].searchText
                }
            }
        }
    }

    private var MusicSearchResultsList: some View {
        VStack {
            Spacer()
                .frame(width: 390)
           
            ForEach(musicSearchViewModel.searchSongs, id: \.self) { item in
                HStack {
                    if let existingArtwork = item.artwork {
                        ArtworkImage(existingArtwork, width: 60)
                            .cornerRadius(8)
                    }
                    Spacer()
                        .frame(width: 16)
                    VStack(alignment: .leading){
                        Text(item.title)
                            .body1(color: .white)
                            .padding(.bottom, 4)
                        Text(item.artistName)
                            .body2(color: .gray500)
                    }
                    Spacer()
                    Button {
                        // TODO: 음악 추가하는 페이지로 이동 기능 구현
                    } label: {
                        SFImageComponentView(symbolName: .ellipsis, color: .white)
                            .rotationEffect(.degrees(90.0))
                    }
                }
            }
        
        }
    }
}


struct MusicSearchPreview: View {
    @State var searchTerm: String = ""
    var body: some View {
        VStack {
            TextField("음악을 검색하세요", text: $searchTerm)
            MusicSearchView(searchTerm: $searchTerm)
        }
    }
}


struct MusicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MusicSearchPreview()
    }
}
