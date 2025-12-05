import SwiftUI

struct HematologyTestsView: View {
    @State private var selectedTests: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hematology")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Select tests to perform")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("Available Tests")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            if !selectedTests.isEmpty {
                                Text("\(selectedTests.count) selected")
                                    .font(.caption)
                                    .foregroundColor(.teal)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.teal.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }

                        // MARK: - Test Rows
                        TestRow(
                            title: "Complete Blood Count (CBC)",
                            subtitle: "Full blood cell analysis",
                            tags: ["Hemoglobin", "Hematocrit", "Platelets", "+2 more"],
                            isSelected: selectedTests.contains("CBC")
                        ) {
                            toggleSelection(for: "CBC")
                        }

                        TestRow(
                            title: "ESR",
                            subtitle: "Erythrocyte sedimentation rate",
                            tags: ["ESR"],
                            isSelected: selectedTests.contains("ESR")
                        ) {
                            toggleSelection(for: "ESR")
                        }

                        TestRow(
                            title: "Blood Grouping",
                            subtitle: "ABO and Rh typing",
                            tags: ["ABO Group", "Rh Factor"],
                            isSelected: selectedTests.contains("Blood Grouping")
                        ) {
                            toggleSelection(for: "Blood Grouping")
                        }

                        // MARK: - Alert Section
                        HematologyAlertView()
                            .padding(.top, 10)
                    }
                    .padding()
                    .padding(.bottom, 100)
                }

                // MARK: - Bottom Proceed Button
                if !selectedTests.isEmpty {
                    VStack {
                        Spacer()
                        NavigationLink(destination: HematologyEntryFormView(selectedTests: selectedTests)) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                Text("Proceed to Entry Form (\(selectedTests.count) test\(selectedTests.count > 1 ? "s" : ""))")
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
                        .animation(.easeInOut, value: selectedTests)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }

    // MARK: - Selection Logic
    private func toggleSelection(for test: String) {
        if selectedTests.contains(test) {
            selectedTests.removeAll(where: { $0 == test })
        } else {
            selectedTests.append(test)
        }
    }
}

// MARK: - Individual Test Row
struct TestRow: View {
    var title: String
    var subtitle: String
    var tags: [String]
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected ? .teal : .gray)
                        .font(.title3)
                }

                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.gray.opacity(0.25))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? Color.teal : Color.gray.opacity(0.3), lineWidth: 1.5)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.gray.opacity(0.15)))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Alert Section
struct HematologyAlertView: View {
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

// MARK: - Entry Form View (Renamed to avoid conflicts)
struct HematologyEntryFormView: View {
    var selectedTests: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text("Entry Form")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Selected Tests: \(selectedTests.joined(separator: ", "))")
                .foregroundColor(.gray)

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
    HematologyTestsView()
}

