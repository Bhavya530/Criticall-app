import SwiftUI

struct AddNewPatientView: View {
    @State private var patientID = ""
    @State private var fullName = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var contactNumber = ""
    @State private var wardRoom = ""
    @State private var diagnosis = ""

    let genders = ["Male", "Female", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Patient ID *")) {
                    TextField("Enter patient ID", text: $patientID)
                        .autocapitalization(.none)
                }
                Section(header: Text("Full Name *")) {
                    TextField("Enter full name", text: $fullName)
                        .autocapitalization(.words)
                }
                Section(header: Text("Age *")) {
                    TextField("Enter age", text: $age)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Gender *")) {
                    Picker("Select gender", selection: $gender) {
                        ForEach(genders, id: \.self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Section(header: Text("Contact Number *")) {
                    TextField("Enter contact number", text: $contactNumber)
                        .keyboardType(.phonePad)
                }
                Section(header: Text("Ward/Room *")) {
                    TextField("Enter ward or room number", text: $wardRoom)
                }
                
                Section(header:
                            HStack {
                    Text("Diagnosis").fontWeight(.semibold)
                    Text("(Optional)").foregroundColor(.secondary)
                }) {
                    ZStack(alignment: .topLeading) {
                        if diagnosis.isEmpty {
                            Text("Enter diagnosis or medical notes")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $diagnosis)
                            .frame(minHeight: 80, maxHeight: 120)
                            .padding(4)
                            .background(Color(UIColor.secondarySystemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    // Save Patient button placed inside same section after diagnosis
                    Button(action: {
                        // Save action here
                    }) {
                        HStack {
                            Image(systemName: "tray.and.arrow.down")
                            Text("Save Patient")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .frame(height: 48)
                    .background(Color(UIColor.systemTeal))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Add New Patient")
        }
        .preferredColorScheme(.dark)
    }
}

struct AddNewPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPatientView()
            .preferredColorScheme(.dark)
    }
}

