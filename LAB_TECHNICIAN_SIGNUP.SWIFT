import SwiftUI

struct LabTechnicianSignupScreen: View {
    
    // Form Fields
    @State private var userID: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var department: String = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 22) {
                
                // LOGO
                Image("criticall_stethoscope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.top, 20)
                
                Text("CritiCall Portal")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text("Lab Technician Sign Up")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                // CARD
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    groupField(title: "User ID (e.g., LAB001)", text: $userID)
                    groupField(title: "Full Name", text: $fullName)
                    groupField(title: "Password", text: $password, isSecure: true)
                    groupField(title: "Email", text: $email)
                    groupField(title: "Phone", text: $phone)
                    groupField(title: "Department (e.g., Clinical Lab)", text: $department)
                    
                    Button(action: {}) {
                        Text("Already have an account? Sign in")
                            .foregroundColor(.cyan)
                            .font(.subheadline)
                    }
                    .padding(.top, 6)
                    
                    // Create Account Button
                    Button(action: {}) {
                        Text("Create Lab Technician Account")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.top, 5)
                    
                }
                .padding()
                .background(Color(white: 0.08))
                .cornerRadius(18)
                .padding(.horizontal, 22)
                .padding(.top, 10)
                
                Spacer()
                
                Text("© 2024 CritiCall Portal. All rights reserved.")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 12)
            }
        }
    }
    
    // MARK: - Text Field Builder
    func groupField(title: String,
                    text: Binding<String>,
                    isSecure: Bool = false) -> some View {
        
        Group {
            if isSecure {
                SecureField(title, text: text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(white: 0.12))
                    .cornerRadius(10)
            } else {
                TextField(title, text: text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(white: 0.12))
                    .cornerRadius(10)
            }
        }
    }
}

struct LabTechnicianSignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        LabTechnicianSignupScreen()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 16 Pro")
    }
}

