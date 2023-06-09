//
//  Extension.swift
//  PhotoSelector
//
//  Created by Maciej Rokiczan on 22/05/2023.
//

import SwiftUI

extension UIImage {
    func reduceToHeight(targetHeight: CGFloat) -> UIImage {
        let ratio = targetHeight / self.size.height
        if ratio < 1 {
            let targetWidth = self.size.width * ratio
            let targetSize = CGSize(width: targetWidth, height: targetHeight)
            let format = UIGraphicsImageRendererFormat()
            format.scale = 1
            let output = UIGraphicsImageRenderer(size: targetSize, format: format)
            return output.image { _ in
                self.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        }
        else {
            return self
        }
    }
}

extension Date {
    func formatted(as format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension View {
    @ViewBuilder func `conditionalModifier`<Modifier: ViewModifier>(_ condition: Bool, modifier: Modifier) -> some View {
        if condition {
            self.modifier(modifier)
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(_ condition: Bool, ifTrue trueContent: (Self) -> TrueContent, else falseContent: (Self) -> FalseContent) -> some View {
        if condition {
            trueContent(self)
        } else {
            falseContent(self)
        }
    }
}

