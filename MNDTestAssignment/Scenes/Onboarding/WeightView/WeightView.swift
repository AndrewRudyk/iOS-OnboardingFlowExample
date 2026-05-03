//
//  WeightView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct WeightView: View {
    @ObservedObject var viewModel: WeightViewModel
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter your current weight")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                HStack {
                    TextField("0.0", text: $viewModel.weightInput)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                    
                    Text(viewModel.isMetric ? "kg" : "lb")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
            }
            
            Toggle(isOn: Binding(
                get: { viewModel.isMetric },
                set: { _ in viewModel.toggleUnit() }
            )) {
                VStack(alignment: .leading) {
                    Text("Use metric system")
                        .font(.body)
                        .bold()
                    Text("Kilograms and kJ")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .tint(.blue)
            .padding(.horizontal, 4)
            
            Spacer()
            
            Button {
                isInputActive = false
                viewModel.nextStep()
            } label: {
                Text("Next")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(viewModel.weightInput.isEmpty)
        }
        .padding(24)
        .navigationTitle("Weight")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
}

#Preview {
    let vm = WeightViewModel(initialWeightKg: 80, isMetricDefault: true) { _, _ in }
    WeightView(viewModel: vm)
}
