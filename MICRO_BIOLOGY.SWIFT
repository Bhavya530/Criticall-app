//
//  MicrobiologyView.swift
//  Medicare
//
//  Created by sails mac on 11/11/25.
//

import SwiftUI

struct MicrobiologyView: View {
    @State private var selectedSections: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Microbiology")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Select test categories to perform")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("Available Test Groups")
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

                        // MARK: - Test Sections
                        MicroTestSection(
                            title: "Culture Tests",
                            description: "Bacterial and fungal cultures",
                            tests: ["Blood Culture", "CSF Culture/Gram Stain"],
                            isSelected: selectedSections.contains("Culture Tests")
                        ) {
                            toggleSelection(for: "Culture Tests")
                        }

                        MicroTestSection(
                            title: "Mycobacteria",
                            description: "TB detection tests",
                            tests: ["TB Smear", "TB Culture", "TB PCR"],
                            isSelected: selectedSections.contains("Mycobacteria")
                        ) {
                            toggleSelection(for: "Mycobacteria")
                        }

                        MicroTestSection(
                            title: "Rapid Diagnostic Tests",
                            description: "Quick pathogen detection",
                            tests: ["C. difficile Toxin", "Cryptococcal Antigen", "Influenza A/B", "+1 more"],
                            isSelected: selectedSections.contains("Rapid Diagnostic Tests")
                        ) {
                            toggleSelection(for: "Rapid Diagnostic Tests")
                        }

                        MicroTestSection(
                            title: "Select Pathogens",
                            description: "High-risk organism detection",
                            tests: ["Anthrax", "Plague", "Tularemia"],
                            isSelected: selectedSections.contains("Select Pathogens")
                        ) {
                            toggleSelection(for: "Select Pathogens")
                        }

                        // MARK: - Alert Section
                        MicrobiologyAlertView()
                            .padding(.top, 10)
                    }
                    .padding()
                    .padding(.bottom, 100)
                }

                // MARK: - Proceed Button
                if !selectedSections.isEmpty {
                    VStack {
                        Spacer()
                        NavigationLink(destination: MicrobiologyEntryFormView(selectedSections: selectedSections)) {
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

// MARK: - Test Section Component
struct MicroTestSection: View {
    var title: String
    var description: String
    var tests: [String]
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
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

// MARK: - Alert View (Renamed to avoid conflicts)
struct MicrobiologyAlertView: View {
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

// MARK: - Entry Form View (Unique name)
struct MicrobiologyEntryFormView: View {
    var selectedSections: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text("Microbiology Entry Form")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Selected Sections: \(selectedSections.joined(separator: ", "))")
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
    MicrobiologyView()
}

