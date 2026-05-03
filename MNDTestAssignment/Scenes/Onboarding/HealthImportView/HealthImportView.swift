//
//  HealthImportView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct HealthImportView: View {
    @ObservedObject var viewModel: HealthImportViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 16) {
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                
                Text("Health App Import")
                    .font(.title)
                    .bold()
                
                Text("We can automatically import your weight, height, and date of birth to simplify the setup process.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
            VStack(spacing: 16) {
                if viewModel.isProcessing {
                    ProgressView()
                        .padding()
                } else {
                    Button {
                        viewModel.importData()
                    } label: {
                        Text("Import from Health App")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                
                Button {
                    viewModel.skip()
                } label: {
                    Text("Skip for now")
                        .foregroundColor(.blue)
                        .padding()
                }
                .disabled(viewModel.isProcessing)
            }
            .padding(.horizontal, 40)
        }
        .navigationTitle("Heath import")
    }
}

#Preview {
    let vm = HealthImportViewModel(healthService: HealthKitService())
    HealthImportView(viewModel: vm)
}
