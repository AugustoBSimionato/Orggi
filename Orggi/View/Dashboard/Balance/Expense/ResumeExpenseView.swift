//
//  ResumeChartView.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI
import Charts

struct ResumeExpenseView: View {
    @State private var isShowingItemSheet = false
    @State private var isShowingItemSheet2 = false
    
    var expenses: [Expense]
    
    var body: some View {
        let expenseColors: [String: Color] = ["Shopping": .red, "Trip": .blue, "Car": .green, "Grocery Store": .orange, "Health": .indigo, "Pharmacy": .cyan, "Pet": .brown]
        let expenseTotals = Dictionary(grouping: expenses.filter { $0.type == "Expense" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        
        if expenseTotals.isEmpty {
            VStack {
                EmptyExpenseView()
            }
        } else {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            Chart {
                                ForEach(expenseTotals.sorted(by: { $0.key < $1.key }), id: \.key) { category, total in
                                    BarMark(
                                        x: .value("Mês", category),
                                        y: .value("Valor", total)
                                    )
                                    .cornerRadius(5.0)
                                    .foregroundStyle(expenseColors[category] ?? .gray)
                                }
                            }
                            .frame(height: 250)
                        }
                        
                        Spacer()
                        
                        Text("Learn About")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                        
                        LearnMoreCell(image: "dollarsign.circle.fill",
                                      title: "How To Save More Money",
                                      subtitle: "Learn how to implement new habits to save your money", background: .green)
                        .padding(.horizontal, 3)
                        .padding(.bottom, 5)
                        .onTapGesture {
                            isShowingItemSheet.toggle()
                        }
                        LearnMoreCell(image: "chart.bar.xaxis",
                                      title: "Take care of your wallet",
                                      subtitle: "Learn how to take care of your precious money on each month", background: .indigo)
                        .padding(.horizontal, 3)
                        .onTapGesture {
                            isShowingItemSheet2.toggle()
                        }
                    }
                    .sheet(isPresented: $isShowingItemSheet) { SaveMoneyView() }
                    .sheet(isPresented: $isShowingItemSheet2) { TakeCareWalletView() }
                }
            }
        }
    }
    
    func formattedValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}

// Creating an extension for the View type in SwiftUI
extension View {
    // Function to add rounded corners to any SwiftUI view
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        // Using the clipShape modifier to apply the rounded corner shape
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
// Custom Shape to draw rounded corners for specified corners of a rectangle
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // Creating a UIBezierPath to draw the rounded corner shape
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        // Converting the UIBezierPath to a SwiftUI Path
        return Path(path.cgPath)
    }
}

#Preview {
    ResumeExpenseView(expenses: [Expense(name: "Açai", date: .now, value: 16.90, type: "Expense", category: "Trip", paymentType: "Cash", bankAccount: "Bradesco")])
}
