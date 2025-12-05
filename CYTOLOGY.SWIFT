//
//  CytologyView.swift
//  Medicare
//
//  Created by sails mac on 12/11/25.
//

import SwiftUI

struct CytologyView: View {
    @State private var selectedSections: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Cytology")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Select tests to perform")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        // MARK: - Available Tests Header
                        HStack {
                            Text("Available Tests")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            if !selectedSections.isEmpty {
                                Text("\(selectedSections.count) selected")
                                    .font(.caption)
                                    .foregroundColor(.teal)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.teal.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }

                        // MARK: - Fluid Cytology Section
                        CytologyTestSection(
                            title: "Fluid Cytology",
                            titleBadge: Image(systemName: "exclamationmark.triangle.fill"),
                            description: "Malignant cell detection",
                            tests: ["Malignant Cells in Sterile Fluid"],
                            isSelected: selectedSections.contains("Fluid Cytology")
                        ) {
                            toggleSelection(for: "Fluid Cytology")
                        }

                        // MARK: - Pathogen Detection Section
                        CytologyTestSection(
                            title: "Pathogen Detection",
                            titleBadge: Image(systemName: "exclamationmark.triangle.fill"),
                            description: "Organisms on cytology",
                            tests: ["Bacteria on Smear", "Fungi on Smear", "Pneumocystis"],
                            isSelected: selectedSections.contains("Pathogen Detection")
                        ) {
                            toggleSelection(for: "Pathogen Detection")
                        }

                        // MARK: - High-Grade Malignancy Section
                        CytologyTestSection(
                            title: "High-Grade Malignancy",
                            titleBadge: Image(systemName: "exclamationmark.triangle.fill"),
                            description: "Unexpected cancer detection",
                            tests: ["High-Grade Malignancy"],
                            isSelected: selectedSections.contains("High-Grade Malignancy")
                        ) {
                            toggleSelection(for: "High-Grade Malignancy")
                        }

                        // MARK: - Alert Box
                        CytologyAlertView()
                            .padding(.top, 10)
                    }
                    .padding()
                    .padding(.bottom, 100)
                }

                // MARK: - Proceed Button
                if !selectedSections.isEmpty {
                    VStack {
                        Spacer()
                        NavigationLink(destination: CytologyEntryFormView(selectedSections: selectedSections)) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                Text("Proceed to Entry Form (\(selectedSections.count) test\(selectedSections.count > 1 ? "s" : ""))")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.teal)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .shadow(color: .teal.opacity(0.4), radius: 6, x: 0, y: 4)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: selectedSections)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }

    // MARK: - Selection Logic
    private func toggleSelection(for section: String) {
        if selectedSections.contains(section) {
            selectedSections.removeAll(where: { $0 == section })
        } else {
            selectedSections.append(section)
        }
    }
}

// MARK: - Cytology Test Section
struct CytologyTestSection: View {
    var title: String
    var titleBadge: Image? = nil
    var description: String
    var tests: [String]
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(spacing: 8) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                        if let badge = titleBadge {
                            badge
                                .foregroundColor(.yellow)
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected ? .teal : .gray)
                        .font(.title3)
                }

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(tests, id: \.self) { test in
                            Text(test)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.25))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.teal : Color.gray.opacity(0.3), lineWidth: 1.5)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.15)))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Alert Info Box
struct CytologyAlertView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.title3)
            VStack(alignment: .leading, spacing: 4) {
                Text("Critical Alert System")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Tests marked with alert icons will automatically trigger notifications for positive findings or critical values.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Entry Form Screen
struct CytologyEntryFormView: View {
    var selectedSections: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text("Cytology Entry Form")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Selected Tests: \(selectedSections.joined(separator: ", "))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Entry Form")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    CytologyView()
}

