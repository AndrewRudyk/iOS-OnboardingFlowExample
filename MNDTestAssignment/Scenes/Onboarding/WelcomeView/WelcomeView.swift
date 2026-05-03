//
//  WelcomeView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to Diary")
                .font(.title)
                .fontWeight(.bold)
            
            Button("Start") {
                onStart()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .navigationTitle("Welcom")
    }
}

#Preview {
    WelcomeView(onStart: {})
}
