//
//  BreathView.swift
//  Waffle
//
//  Created by MacBook Pro M1 on 2024/06/19.
//

import SwiftUI

struct BreathView: View {
    @State private var isAnimated = false
    var body: some View {
        if #available(iOS 18.0, *) {
            Image(systemName: "circle.dotted.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .foregroundStyle(Color.accentColor)
                .symbolEffect(.breathe.pulse.byLayer, options: .repeat(SymbolEffectOptions.RepeatBehavior.continuous), value: isAnimated)
                .onTapGesture {
                    isAnimated.toggle()
                }
        } else {
            // Fallback on earlier versions
            Image(systemName: "circle.dotted.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .foregroundStyle(Color.accentColor)
                .symbolEffect(.bounce, options: .repeating, value: isAnimated)
                .onTapGesture {
                    isAnimated.toggle()
                }
        }
    }
}

#Preview {
    BreathView()
}
