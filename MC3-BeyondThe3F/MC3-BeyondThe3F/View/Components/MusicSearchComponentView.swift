//
//  MusicSearchView.swift
//  MC3-BeyondThe3F
//
//  Created by 한영균 on 2023/07/20.
//

import SwiftUI

struct MusicSearchComponentView: View {
//    @State private var textInput: String = ""
    @Binding var textInput: String
    @State private var onSearching = false
    
    var body: some View {
        HStack{
            HStack {
                SFImageComponentView(
                    symbolName: onSearching ? .chevronBack : .magnifyingGlass,
                    color: .white)
                Spacer()
                    .frame(width: 20)
                TextField("음악을 검색해보세요", text: $textInput)
//                    .onTapGesture {
//                        onSearching.toggle()
//                    }
                    
                    
                Spacer()
                SFImageComponentView(symbolName: .mic, color: .white)
            }
            .padding()
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: 350)
            .frame(height: 48)
            .background(Color.custom(.secondaryDark))
            .cornerRadius(4)
            .colorScheme(.dark)
            .accentColor(.white)
            
            Spacer()
            
            SFImageComponentView(symbolName: .gearShape, color: .white)
        }
    }
}


//struct MusicSearchComponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicSearchComponentView()
//    }
//}
