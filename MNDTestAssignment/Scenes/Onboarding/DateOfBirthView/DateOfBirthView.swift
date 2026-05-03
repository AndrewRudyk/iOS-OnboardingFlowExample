//
//  DateOfBirthView.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import SwiftUI

struct DateOfBirthView: View {
    @ObservedObject var viewModel: DateOfBirthViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Your date of birth")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("You must be at least \(AppConfig.Onboarding.minimumAgeYears) years old.")
                    .font(.subheadline)
                    .foregroundColor(viewModel.isNextButtonDisabled ? .red : .secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(uiColor: .secondarySystemBackground))
                
                DatePicker("", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
            }
            .frame(height: 220)
            
            Spacer()
            
            Button {
                viewModel.nextStep()
            } label: {
                Text("Next")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(viewModel.isNextButtonDisabled)
        }
        .padding(24)
        .navigationTitle("Date of Birth")
    }
}

#Preview {
    let vm = DateOfBirthViewModel(initialDate: Date(), onFinish: {_ in })
    DateOfBirthView(viewModel: vm)
}
