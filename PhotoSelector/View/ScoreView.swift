//
//  ScoreView.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 23/04/2023.
//

import SwiftUI

struct ScoreView: View {
    
    @Binding var score: Int
    let maxScore = 5
    let markedColor = Color.yellow
    let unmarkedColor = Color.gray
    
    func updateRating(index: Int) {
        score = index
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< maxScore + 1) { i in
                
                Button(action: {
                    updateRating(index: i)
                }, label: {
                   
                    Image(systemName: i == 0 ? "star.slash" : "star.fill")
                        .foregroundColor(
                            i == 0 || i > score ? unmarkedColor : markedColor)
                })
                
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: .constant(3))
            .previewLayout(.sizeThatFits)
    }
}
