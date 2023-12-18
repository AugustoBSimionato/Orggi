//
//  SettingsView.swift
//  Orggi
//
//  Created by Augusto Simionato on 10/12/23.
//

import SwiftUI
import Network

struct SettingsView: View {
    @AppStorage("active_icon") var activeAppIcon: String = "Compass"
    
    @Environment(\.modelContext) var context
    @Environment(\.openURL) var openURL
    @State private var connectionStatus: NWPath.Status = .requiresConnection
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private var email = SupportEmail(toAddress: "toodo4473@gmail.com")
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                            
                            Image(systemName: "app.fill")
                                .font(.system(size: 13))
                                .foregroundStyle(.settingsIcons)
                            Image(systemName: "app.dashed")
                                .font(.system(size: 20))
                                .foregroundStyle(.settingsIcons)
                        }
                        Text("app-icon")
                            .foregroundStyle(.accent)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        Picker("", selection: $activeAppIcon) {
                            Text("compass").tag("Compass")
                            Text("wallet").tag("Wallet")
                        }
                        .onChange(of: activeAppIcon) {
                            changeAppIcon(iconName: activeAppIcon)
                        }
                    }
                    
                    Button {
                        self.showAlert.toggle()
                    } label: {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.red)
                                
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                            Text("dele-all-da")
                                .foregroundStyle(.red)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("All data deleted"), message: Text("all-deleted"), dismissButton: .default(Text("OK")) {
                            do {
                                try context.delete(model: Expense.self)
                            } catch {
                                print("Falha ao deletar todos os dados.")
                            }
                        })
                    }
                } header: {
                    Text("quick-config")
                }

                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.settingsIcons)
                        }
                        Text("hate-orggi")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                            
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.settingsIcons)
                        }
                        ShareLink(item: URL(string: "https://toodo-suas-tarefas-concluidas-de-forma.webflow.io/")!, message: Text("Suas-tarefas-concluídas-de-forma-rápida-e-fácil!-Baixe-já!")) {
                            Text("share-orggi")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                            
                            Image(systemName: "message.badge.filled.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.settingsIcons)
                        }
                        Button {
                            email.send(openURL: openURL)
                        } label: {
                            Text("send-feedback")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                } header: {
                    Text("feedback-share")
                } footer: {
                    Text("feedback-share-footer")
                }
                
                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                            
                            Image(systemName: "hammer.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.settingsIcons)
                        }
                        Text("app-version")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        Spacer()
                        Text("1.0")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(connectionStatus == .satisfied ? .green : .red)
                            
                            Image(systemName: connectionStatus == .satisfied ? "checkmark.icloud.fill" : "exclamationmark.icloud.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                                .symbolEffect(.pulse, options: .repeating, value: connectionStatus)
                        }
                        Text(connectionStatus == .satisfied ? "all-update" : "without-net")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                    .onAppear {
                        let monitor = NWPathMonitor()
                        monitor.pathUpdateHandler = { path in
                            DispatchQueue.main.async {
                                self.connectionStatus = path.status
                            }
                        }
                        let queue = DispatchQueue(label: "Monitor")
                        monitor.start(queue: queue)
                    }
                } header: {
                    Text("dev-information")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                }
            }
            HStack {
                Text("Created by @gutobaroni")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
            }
        }
    }
    
    private func changeAppIcon(iconName: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            print("A mudança de ícone não é suportada neste dispositivo.")
            return
        }

        if UIApplication.shared.alternateIconName != iconName {
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if let error = error {
                    print("Erro ao tentar alterar o ícone: \(error.localizedDescription)")
                } else {
                    print("Ícone alterado com sucesso para \(iconName)")
                }
            }
        } else {
            print("O ícone já está definido como \(iconName)")
        }
    }
}

#Preview {
    SettingsView()
}
