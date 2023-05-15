//
//  ScoreView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 23/04/2023.
//

import SwiftUI

struct ScoreView: View {
    
    let score = 3
    let maxScore = 5
    let markedColor = Color.yellow
    let unmarkedColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1 ..< maxScore + 1) { i in
                Image(systemName: "star.fill")
                    .foregroundColor(
                        i > score ? unmarkedColor : markedColor)
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .previewLayout(.sizeThatFits)
    }
}
