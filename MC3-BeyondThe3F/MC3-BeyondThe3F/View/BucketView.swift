//
//  BucketView.swift
//  MC3-BeyondThe3F
//
//  Created by Seungui Moon on 2023/07/18.
//

import SwiftUI

struct BucketView: View {
    
    @State private var searchTerm = ""
        
    var body: some View {
        VStack {
            MusicSearchComponentView()
                .padding()
            CarouselView()
            MusicPlayerComponentView()
        }
        .background(Color.custom(.background))
    }
}

struct BucketView_Previews: PreviewProvider {
    static var previews: some View {
        BucketView()
    }
}
