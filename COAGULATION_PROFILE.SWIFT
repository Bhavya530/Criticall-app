import SwiftUI

struct CoagulationProfileView: View {
    @State private var selectedTests: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Select tests to perform")
                                .font(.subheadline)
                                .foregroundColor(.gray)
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
                        }

                        // MARK: - Basic Coagulation Section
                        CoagulationTestSection(
                            title: "Basic Coagulation",
                            description: "Essential clotting tests",
                            tests: ["PT", "INR", "APTT"],
                            isSelected: selectedTests.contains("Basic Coagulation")
                        ) {
                            if selectedTests.contains("Basic Coagulation") {
                                selectedTests.removeAll(where: { $0 == "Basic Coagulation" })
                            } else {
                                selectedTests.append("Basic Coagulation")
                            }
                        }

                        // MARK: - Alert Section
                        CoagulationAlertView()
                    }
                    .padding()
                    .padding(.bottom, 100) // space for bottom button
                }

                // MARK: - Proceed Button
                if !selectedTests.isEmpty {
                    VStack {
                        Spacer()
                        NavigationLink(destination: EntryFormView(selectedTests: selectedTests)) {
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
                            .shadow(color: .teal.opacity(0.5), radius: 6, x: 0, y: 4)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: selectedTests)
                    }
                }
            }
            .navigationTitle("Coagulation Profile")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Test Section Card
struct CoagulationTestSection: View {
    var title: String
    var description: String
    var tests: [String]
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected ? .teal : .gray)
                        .font(.title3)
                }

                HStack(spacing: 8) {
                    ForEach(tests, id: \.self) { test in
                        Text(test)
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.25))
                            .foregroundColor(.white)
                            .cornerRadius(8)
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

// MARK: - Alert Section
struct CoagulationAlertView: View {
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

// MARK: - Entry Form View
struct EntryFormView: View {
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
    CoagulationProfileView()
}

