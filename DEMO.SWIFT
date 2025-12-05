//
//  DepartmentsRootView.swift
//  Medicare
//
//  Created by ChatGPT on 2025-11-29.
//  Multi-department screens: main department list -> per-department form screens.
//  Uses adult critical thresholds from uploaded thesis doc. :contentReference[oaicite:1]{index=1}
//

import SwiftUI

// MARK: - Models

struct TestFieldSpec: Identifiable {
    let id = UUID()
    let label: String          // Display name
    let key: String            // Internal key
    let normalRange: String?   // Displayed normal range text
    let thresholdLow: Double?  // Critical low (nil if none)
    let thresholdHigh: Double? // Critical high (nil if none)
    let placeholder: String?   // TextField placeholder
    // units not strictly required but could be used in UI
    let units: String?
}

// MARK: - Departments Root View

struct DepartmentListView: View {
    // Demo patient header (wire up to your patient model)
    @State private var patientName: String = "Michael Chen"
    @State private var patientID: String = "PD02 - 67y, Male"
    @State private var testsOrdered: String = "CBC, Lipid Panel, Basic Metabolic Panel"
    @State private var orderingPhysician: String = "Dr. Smith"

    // Departments enum for readability
    enum Department: String, CaseIterable {
        case chemistry = "Chemistry"
        case electrolytes = "Electrolytes"
        case hematology = "Hematology"
        case coagulation = "Coagulation"
        case abg = "Arterial Blood Gas (ABG)"
        case microbiology = "Microbiology"
        case radiology = "Radiology Alerts"
        case cytology = "Cytology"
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).ignoresSafeArea()

                VStack(spacing: 12) {
                    // Header card (matches screenshot style)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(patientName).font(.headline).foregroundColor(.black)
                                Text(patientID).font(.caption).foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("Tests Ordered").font(.caption2).foregroundColor(.gray)
                                Text(testsOrdered).font(.subheadline).foregroundColor(.black)
                            }
                        }
                        Divider()
                        HStack {
                            Text("Ordering Physician:").font(.caption2).foregroundColor(.gray)
                            Text(orderingPhysician).font(.subheadline).foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)

                    // Department buttons
                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(Department.allCases, id: \.self) { dept in
                                NavigationLink(destination: destinationView(for: dept)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(dept.rawValue)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            Text(subtitle(for: dept))
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 2)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                    }

                    Spacer()
                }
            }
            .navigationTitle("Departments")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
    }

    // Small descriptive subtitle per department
    private func subtitle(for d: Department) -> String {
        switch d {
        case .chemistry: return "Glucose, Lactate, Urea, Creatinine..."
        case .electrolytes: return "Na, K, Cl, Ca, Mg, Phosphate"
        case .hematology: return "Hgb, Hct, WBC, Platelets"
        case .coagulation: return "INR and coagulation parameters"
        case .abg: return "pH, pCO₂, pO₂"
        case .microbiology: return "Culture results & organism reports"
        case .radiology: return "Critical imaging findings"
        case .cytology: return "Malignant cells / urgent cytology"
        }
    }

    // Destination view builder
    @ViewBuilder
    private func destinationView(for d: Department) -> some View {
        switch d {
        case .chemistry:
            DepartmentFormView(
                title: d.rawValue,
                tests: DepartmentSpecs.chemistry
            )
        case .electrolytes:
            DepartmentFormView(
                title: d.rawValue,
                tests: DepartmentSpecs.electrolytes
            )
        case .hematology:
            DepartmentFormView(
                title: d.rawValue,
                tests: DepartmentSpecs.hematology
            )
        case .coagulation:
            DepartmentFormView(
                title: d.rawValue,
                tests: DepartmentSpecs.coagulation
            )
        case .abg:
            DepartmentFormView(
                title: d.rawValue,
                tests: DepartmentSpecs.abg
            )
        case .microbiology:
            // Microbiology uses a qualitative form
            QualitativeReportView(title: d.rawValue, description: "Report culture/Gram stain/organism details here.")
        case .radiology:
            QualitativeReportView(title: d.rawValue, description: "Report critical imaging findings (tension pneumothorax, massive PE, aortic dissection...).")
        case .cytology:
            QualitativeReportView(title: d.rawValue, description: "Report malignant cells or urgent cytology findings.")
        }
    }
}

// MARK: - Department Specifications (test lists + thresholds)

// These use adult thresholds taken from the thesis document.
enum DepartmentSpecs {
    static let electrolytes: [TestFieldSpec] = [
        TestFieldSpec(label: "Sodium (Na)", key: "Sodium", normalRange: "Normal: 135-145 mmol/L", thresholdLow: 120, thresholdHigh: 160, placeholder: "Enter value", units: "mmol/L"),
        TestFieldSpec(label: "Potassium (K)", key: "Potassium", normalRange: "Normal: 3.5-5.0 mmol/L", thresholdLow: 3.5, thresholdHigh: 5.5, placeholder: "Enter value", units: "mmol/L"),
        TestFieldSpec(label: "Chloride (Cl⁻)", key: "Chloride", normalRange: "Normal: 98-107 mmol/L", thresholdLow: 70, thresholdHigh: 120, placeholder: "Enter value", units: "mmol/L"),
        TestFieldSpec(label: "Calcium (Total)", key: "CalciumTotal", normalRange: "Normal: 8.5-10.2 mg/dL", thresholdLow: 7.0, thresholdHigh: 12.0, placeholder: "Enter value", units: "mg/dL"),
        TestFieldSpec(label: "Calcium (Ionized)", key: "CalciumIonized", normalRange: "Normal: 1.12-1.3 mmol/L", thresholdLow: 0.8, thresholdHigh: 1.8, placeholder: "Enter value", units: "mmol/L"),
        TestFieldSpec(label: "Magnesium (Mg)", key: "Magnesium", normalRange: "Normal: 1.7-2.2 mg/dL", thresholdLow: 1.0, thresholdHigh: 5.0, placeholder: "Enter value", units: "mmol/L"),
        TestFieldSpec(label: "Phosphorus (P)", key: "Phosphorus", normalRange: "Normal: 2.5-4.5 mg/dL", thresholdLow: 1.0, thresholdHigh: 8.0, placeholder: "Enter value", units: "mg/dL")
    ]

    static let chemistry: [TestFieldSpec] = [
        TestFieldSpec(label: "Glucose (Blood)", key: "Glucose", normalRange: "Normal: 70-140 mg/dL", thresholdLow: 40, thresholdHigh: 450, placeholder: "Enter mg/dL", units: "mg/dL"),
        TestFieldSpec(label: "Lactate (Serum)", key: "Lactate", normalRange: "Normal: 0.5-2.2 mmol/L", thresholdLow: nil, thresholdHigh: 5.0, placeholder: "Enter mmol/L", units: "mmol/L"),
        TestFieldSpec(label: "Bicarbonate (HCO₃⁻)", key: "Bicarbonate", normalRange: "Normal: 22-28 mEq/L", thresholdLow: 10, thresholdHigh: 36, placeholder: "Enter mEq/L", units: "mEq/L"),
        TestFieldSpec(label: "Urea (BUN)", key: "Urea", normalRange: "Normal: 7-20 mg/dL", thresholdLow: nil, thresholdHigh: 100, placeholder: "Enter mg/dL", units: "mg/dL"),
        TestFieldSpec(label: "Creatinine", key: "Creatinine", normalRange: "Normal: 0.6-1.2 mg/dL", thresholdLow: nil, thresholdHigh: 10.0, placeholder: "Enter mg/dL", units: "mg/dL")
    ]

    static let hematology: [TestFieldSpec] = [
        TestFieldSpec(label: "Hemoglobin (Hgb)", key: "Hemoglobin", normalRange: "Normal: 13.5-17.5 g/dL (M)", thresholdLow: 7.0, thresholdHigh: 20.0, placeholder: "Enter g/dL", units: "g/dL"),
        TestFieldSpec(label: "Hematocrit (Hct)", key: "Hematocrit", normalRange: "Normal: 41-53% (M)", thresholdLow: 15.0, thresholdHigh: 60.0, placeholder: "Enter %", units: "%"),
        TestFieldSpec(label: "Platelets", key: "Platelets", normalRange: "Normal: 150-450 x10³/µL", thresholdLow: 20.0, thresholdHigh: 1000.0, placeholder: "Enter (x10³/µL)", units: "x10³/µL"),
        TestFieldSpec(label: "WBC Count", key: "WBC", normalRange: "Normal: 4.0-11.0 x10³/µL", thresholdLow: 2.0, thresholdHigh: 40.0, placeholder: "Enter (x10³/µL)", units: "x10³/µL")
    ]

    static let coagulation: [TestFieldSpec] = [
        TestFieldSpec(label: "INR", key: "INR", normalRange: "Normal: 0.8-1.2", thresholdLow: nil, thresholdHigh: 6.0, placeholder: "Enter INR", units: nil)
    ]

    static let abg: [TestFieldSpec] = [
        TestFieldSpec(label: "pH (arterial)", key: "pH", normalRange: "Normal: 7.35-7.45", thresholdLow: 7.20, thresholdHigh: 7.60, placeholder: "Enter pH", units: nil),
        TestFieldSpec(label: "pCO₂ (mmHg)", key: "pCO2", normalRange: "Normal: 35-45 mmHg", thresholdLow: 20, thresholdHigh: 60, placeholder: "Enter pCO₂", units: "mmHg"),
        TestFieldSpec(label: "pO₂ (mmHg)", key: "pO2", normalRange: "Normal: 75-100 mmHg", thresholdLow: 50, thresholdHigh: nil, placeholder: "Enter pO₂", units: "mmHg")
    ]
}

// MARK: - Reusable Department Form View

struct DepartmentFormView: View {
    let title: String
    let tests: [TestFieldSpec]

    // Bindings for values keyed by `key`
    @State private var values: [String: String] = [:]

    // For displaying an overall banner if any criticals exist
    @State private var showSubmitAlert: Bool = false
    @State private var submitMessage: String = ""

    var body: some View {
        VStack(spacing: 12) {
            // Header
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.largeTitle).fontWeight(.bold).foregroundColor(.black)
                Text("Enter values. Critical values (per thesis) will be highlighted.").font(.subheadline).foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 14) {
                    ForEach(tests) { test in
                        testRow(for: test)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }

            // Submit button
            Button(action: onSubmit) {
                HStack {
                    Image(systemName: "tray.and.arrow.up.fill")
                    Text("Submit \(title)")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.bottom, 12)
            .alert(isPresented: $showSubmitAlert) {
                Alert(title: Text("Submit Result"), message: Text(submitMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle(title)
        .onAppear {
            // initialize values dictionary keys
            for t in tests {
                if values[t.key] == nil { values[t.key] = "" }
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }

    // Single test row view
    @ViewBuilder
    private func testRow(for spec: TestFieldSpec) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(spec.label).font(.subheadline).foregroundColor(.black)
                    if let r = spec.normalRange {
                        Text(r).font(.caption).foregroundColor(.gray)
                    }
                }
                Spacer()
                HStack(spacing: 8) {
                    TextField(spec.placeholder ?? "Enter value", text: Binding(
                        get: { values[spec.key] ?? "" },
                        set: { values[spec.key] = $0 }
                    ))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 130)
                    .padding(8)
                    .background(fieldBackgroundColor(for: spec))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(fieldBorderColor(for: spec), lineWidth: 1.5))

                    if let state = criticalState(for: spec), state != .normal {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.red)
                            .help(state == .low ? "Below critical low" : "Above critical high")
                    }
                }
                .frame(minWidth: 160)
            }

            if let state = criticalState(for: spec), state != .normal {
                HStack(spacing: 8) {
                    Image(systemName: "bell.fill").foregroundColor(.red)
                    Text(state == .low ? "Critical LOW — notify immediately" : "Critical HIGH — notify immediately")
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(8)
                .background(Color.red.opacity(0.06))
                .cornerRadius(8)
            }
        }
    }

    // MARK: - Critical logic

    private enum CriticalState { case normal, low, high }

    private func parseDouble(_ s: String?) -> Double? {
        guard let s = s?.trimmingCharacters(in: .whitespacesAndNewlines), !s.isEmpty else { return nil }
        let normalized = s.replacingOccurrences(of: ",", with: ".")
        return Double(normalized)
    }

    private func criticalState(for spec: TestFieldSpec) -> CriticalState? {
        guard let txt = values[spec.key], let v = parseDouble(txt) else { return nil }
        if let low = spec.thresholdLow, v < low { return .low }
        if let high = spec.thresholdHigh, v > high { return .high }
        return .normal
    }

    private func fieldBorderColor(for spec: TestFieldSpec) -> Color {
        if let state = criticalState(for: spec) {
            switch state {
            case .low, .high: return .red
            case .normal: return Color.gray.opacity(0.35)
            }
        }
        return Color.gray.opacity(0.35)
    }

    private func fieldBackgroundColor(for spec: TestFieldSpec) -> Color {
        if let state = criticalState(for: spec) {
            switch state {
            case .low, .high: return Color.red.opacity(0.06)
            case .normal: return Color(UIColor.systemGray6)
            }
        }
        return Color(UIColor.systemGray6)
    }

    // MARK: - Submit handling

    private func onSubmit() {
        var provided: [String: Double] = [:]
        var criticals: [String: (value: Double, reason: String)] = [:]

        for spec in tests {
            if let vStr = values[spec.key], let v = parseDouble(vStr) {
                provided[spec.key] = v
                if let low = spec.thresholdLow, v < low {
                    criticals[spec.label] = (v, "Below critical low (\(low))")
                } else if let high = spec.thresholdHigh, v > high {
                    criticals[spec.label] = (v, "Above critical high (\(high))")
                }
            }
        }

        // Build a user-facing submit message
        if criticals.isEmpty {
            submitMessage = "Submitted \(title). No critical values detected."
        } else {
            var lines: [String] = []
            for (k, info) in criticals {
                lines.append("\(k): \(info.value) — \(info.reason)")
            }
            submitMessage = "Critical values detected:\n" + lines.joined(separator: "\n")
            // TODO: trigger true alerting/notification workflow
        }

        showSubmitAlert = true

        // In production: send 'provided' to API and trigger notifications if 'criticals' not empty.
        print("Submit \(title) - values:", provided)
        if !criticals.isEmpty { print("CRITICALS:", criticals) }
    }
}

// MARK: - Qualitative / Non-numeric report view (for Microbiology, Radiology, Cytology)

struct QualitativeReportView: View {
    let title: String
    let description: String

    @State private var positive: Bool = false
    @State private var organism: String = ""
    @State private var notes: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.largeTitle).fontWeight(.bold).foregroundColor(.black)
                Text(description).font(.subheadline).foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal)

            Form {
                Toggle("Preliminary Positive", isOn: $positive)
                TextField("Organism (e.g. Staphylococcus aureus)", text: $organism)
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 140)
                }
                Section {
                    Button(action: submit) {
                        HStack {
                            Image(systemName: "tray.and.arrow.up.fill")
                            Text("Submit Report")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .cornerRadius(12)
        }
        .navigationTitle(title)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Submission"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }

    private func submit() {
        // Example behavior: if positive or organism provided, this is a critical-style notification per thesis
        if positive || !organism.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Positive/organism reported. Notify treating team immediately."
        } else {
            alertMessage = "Report submitted (no positive/organism noted)."
        }
        showAlert = true
        print("Qualitative submit for \(title): positive=\(positive), organism=\(organism), notes=\(notes)")
    }
}

// MARK: - Previews

struct DepartmentsRootView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentListView()
    }
}
//
//  demo.swift
//  Medicare
//
//  Created by sails mac on 29/11/25.
//

