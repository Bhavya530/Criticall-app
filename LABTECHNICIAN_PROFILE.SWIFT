import SwiftUI
struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Card
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 90, height: 90)
                        Text("🧪")
                            .font(.system(size: 40))
                    }

                    Text("Alex Rodriguez")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Text("Lab Technician")
                        .font(.headline)
                        .foregroundColor(.green)

                    VStack(spacing: 4) {
                        Text("ID: LT2024003")
                        Text("Department: Clinical Laboratory")
                        Text("Shift: Day Shift (7AM – 3PM)")
                        Text("Supervisor: Dr. Patricia Johnson")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground).opacity(0.3))
                .cornerRadius(16)

                // Account Settings
                VStack(alignment: .leading, spacing: 16) {
                    Text("Account Settings")
                        .font(.headline)
                        .foregroundColor(.white)

                    SettingRow(icon: "lock", title: "Change Password", subtitle: "Update security credentials")
                    SettingRow(icon: "bell", title: "Notification Preferences", subtitle: "Manage alert settings")

                    SettingRow(icon: "arrow.right.square", title: "Logout", subtitle: "Sign out of your account", isDestructive: true)
                }
                .padding()
                .background(Color(.secondarySystemBackground).opacity(0.3))
                .cornerRadius(16)
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct SettingRow: View {
    var icon: String
    var title: String
    var subtitle: String
    var isDestructive: Bool = false

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(isDestructive ? Color.red.opacity(0.2) : Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(isDestructive ? .red : .white)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundColor(isDestructive ? .red : .white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 6)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
