import SwiftUI

struct LabCategoryView: View {
    // Grid layout configuration
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let categories: [LabCategory] = [
        LabCategory(name: "Hematology", description: "Blood cell analysis and counts", icon: "flame.fill", color: Color.red.opacity(0.3)),
        LabCategory(name: "Biochemistry", description: "Chemical analysis of blood", icon: "testtube.2", color: Color.blue.opacity(0.3)),
        LabCategory(name: "Microbiology", description: "Bacterial and viral detection", icon: "allergens", color: Color.green.opacity(0.3)),
        LabCategory(name: "Coagulation Profile", description: "Blood clotting analysis", icon: "bolt.heart.fill", color: Color.purple.opacity(0.3)),
        LabCategory(name: "Cytology", description: "Cell examination and analysis", icon: "eye.circle.fill", color: Color.orange.opacity(0.3)),
        LabCategory(name: "ABG", description: "Arterial blood gas analysis", icon: "wind", color: Color.teal.opacity(0.3)),
        LabCategory(name: "Radiology", description: "Imaging and scan results", icon: "waveform.path", color: Color.indigo.opacity(0.3))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Choose Test Category")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    Text("Select the type of laboratory test to perform")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(categories) { category in
                            VStack(alignment: .leading, spacing: 8) {
                                Image(systemName: category.icon)
                                    .font(.system(size: 28))
                                    .foregroundColor(category.color)
                                    .frame(width: 50, height: 50)
                                    .background(category.color.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                Text(category.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(category.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.secondarySystemBackground).opacity(0.3))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    
                    // QUICK START GUIDE SECTION
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Quick Start Guide")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Select a category to view available tests. Each test will guide you through parameter entry with automatic critical value detection.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground).opacity(0.3))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Select Lab Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct LabCategory: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let color: Color
}

#Preview {
    LabCategoryView()
}

