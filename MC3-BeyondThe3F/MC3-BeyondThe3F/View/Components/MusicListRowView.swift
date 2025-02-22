//
//  MusicListRowView.swift
//  MC3-BeyondThe3F
//
//  Created by 한영균 on 2023/07/20.
//

import SwiftUI

struct MusicListRowView: View {
    let imageName: String
    let songName: String
    let artistName: String
    enum MusicListRowType {
        case notSaved
        case saved
    }
    let musicListRowType : MusicListRowType
    var buttonPlayAction: () -> Void = { return }
    var buttonEllipsisAction: () -> Void = { return }
    
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                .foregroundColor(.white)
            Spacer()
                .frame(width: 16)
            VStack(alignment: .leading){
                Text("\(imageName)")
                    .body1(color: .white)
                    .padding(.bottom, 4)
                Text("\(artistName)")
                    .body2(color: .gray500)
            }
            Spacer()
            switch musicListRowType {
            case .saved:
                Button {
                    buttonEllipsisAction()
                } label: {
                    SFImageComponentView(symbolName: .ellipsis, color: .white)
                        .rotationEffect(.degrees(90.0))
                }
            case .notSaved:
                Button {
                    buttonPlayAction()
                } label: {
                    SFImageComponentView(symbolName: .play, color: .white)
                }
                Spacer()
                    .frame(width: 15)
                Button {
                    buttonEllipsisAction()
                } label: {
                    SFImageComponentView(symbolName: .ellipsis, color: .white)
                }
            }
        }
        .frame(maxWidth: 390)
        .frame(height: 88)
        
    }
}

struct MusicListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListRowView(imageName: "annotation0", songName: "BIG WAVE", artistName: "artist", musicListRowType: .notSaved)
    }
}
