//
//  GenderView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct GenderView: View {
    let onSelect: (Gender) -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Select gender")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                ForEach(Gender.allCases, id: \.self) { item in
                    Button(action: {
                        onSelect(item)
                    }) {
                        Text(item.title)
                            .frame(width: 80)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .navigationTitle("Gender")
    }
}

#Preview {
    GenderView(onSelect: {_ in })
}
