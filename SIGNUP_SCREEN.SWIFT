import SwiftUI

struct SignupScreen: View {
    @State private var selectedRole = ""
    let roles = ["Doctor", "Lab Technician"]
    @State private var userID = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 18/255, green: 18/255, blue: 18/255)]),
                //
                //  RadiologyView.swift
                //  Medicare
                //
                //  Created by sails mac on 12/11/25.
                //

                import SwiftUI

                struct RadiologyView: View {
                    @State private var selectedSections: [String] = []

                    var body: some View {
                        NavigationView {
                            ZStack {
                                Color.black.ignoresSafeArea()

                                ScrollView {
                                    VStack(alignment: .leading, spacing: 20) {
                                        // MARK: - Header
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Radiology")
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

                                        // MARK: - Emergency Findings Section (with all 5 items)
                                        RadiologyTestSection(
                                            title: "Emergency Findings",
                                            titleBadge: Image(systemName: "exclamationmark.triangle.fill"),
                                            description: "Critical radiological alerts",
                                            tests: [
                                                "Tension Pneumothorax",
                                                "Large Pulmonary Embolism",
                                                "Aortic Dissection/Rupture",
                                                "Intracranial Hemorrhage",
                                                "Bowel Perforation"
                                            ],
                                            isSelected: selectedSections.contains("Emergency Findings")
                                        ) {
                                            toggleSelection(for: "Emergency Findings")
                                        }

                                        // MARK: - Alert Box
                                        RadiologyAlertView()
                                            .padding(.top, 10)
                                    }
                                    .padding()
                                    .padding(.bottom, 100)
                                }

                                // MARK: - Proceed Button
                                if !selectedSections.isEmpty {
                                    VStack {
                                        Spacer()
                                        NavigationLink(destination: RadiologyEntryFormView(selectedSections: selectedSections)) {
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

                // MARK: - Radiology Test Section
                struct RadiologyTestSection: View {
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
                struct RadiologyAlertView: View {
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
                struct RadiologyEntryFormView: View {
                    var selectedSections: [String]

                    var body: some View {
                        VStack(spacing: 20) {
                            Text("Radiology Entry Form")
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
                    RadiologyView()
                }

                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                // Updated logo name — replace with your CritiCall asset if needed
                Image("criticall_stethoscope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 32)

                // Updated title
                Text("CritiCall Portal")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 12)

                Text("Secure Healthcare Management System")
                    .font(.footnote)
                    .foregroundColor(Color(white: 0.7))

                // Role Picker
                Picker("Select Role", selection: $selectedRole) {
                    ForEach(roles, id: \.self) { role in
                        Text(role).tag(role)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color(.darkGray))
                .cornerRadius(8)
                .tint(Color(.systemTeal))
                .padding(.horizontal)

                // User ID TextField
                TextField("User ID", text: $userID)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                // Sign Up Button
                Button(action: {
                    // Signup logic here
                }) {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemTeal))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
        }
    }
}
struct SignupScreenPreview: PreviewProvider {
    static var previews: some View {
        SignupScreen()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 16")
    }
}

