//
//  SummaryView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 12) {
                Text("Your Daily Calorie Budget")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .lastTextBaseline, spacing: 8) {
                    Text(viewModel.budgetDisplayValue)
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                    
                    Text(viewModel.unitLabel)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(uiColor: .secondarySystemBackground))
            )
            
            Text("Based on your gender, age, weight, and height.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                viewModel.nextStep()
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(24)
        .navigationTitle("Result")
    }
}
