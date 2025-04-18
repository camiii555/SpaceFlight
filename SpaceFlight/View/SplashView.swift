//
//  SplashView.swift
//  SpaceFlight
//
//  Created by Juan Camilo  Mejia Soto on 18/04/25.
//

import SwiftUI
import AVKit

struct SplashView: View {
    @State private var isActive = false
    @State private var isVisible = false

    
    var body: some View {
        if isActive {
            articlesListView()
        } else {
            ZStack {
                
                Color.init(hex: "#0d1d2d")
                    .ignoresSafeArea()
                
                VStack {
                    Image("Icon")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .scaleEffect(isVisible ? 1 : 0.8)
                        .animation(.linear(duration: 4), value: isVisible)
                    Text("SpaceFlight")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .scaleEffect(isVisible ? 1 : 0.8)
                        .animation(.linear(duration: 4), value: isVisible)
                }
            }
            .transition(.opacity)
            .onAppear {
                isVisible.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    withAnimation(.easeOut, {
                        self.isActive.toggle()
                    })
                })
            }
        }
    }
}

#Preview {
    SplashView()
}
