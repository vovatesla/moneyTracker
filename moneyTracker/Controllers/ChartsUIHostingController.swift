//
//  MainUIViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 18.07.2024.
//

import UIKit
import SwiftUI
import Charts
import CoreData

struct monthlyExpenses {
    var category: String
    var amount: Double
}

class ChartsUIHostingController: UIHostingController<ChartsUIView> {
    
    required init?(coder aDecoder: NSCoder) {
        let initialData = [monthlyExpenses(category: "Loading", amount: 0)]
        let initialRootView = ChartsUIView(data: initialData, todayExpenses: "0")
        super.init(coder: aDecoder, rootView: initialRootView)
        updateViewWithData()
    }
    
    func updateViewWithData() {
        let data = fetchMonthlyExpenses()
        let todayExpenses = calculateTodayExpenses(from: data)
        self.rootView = ChartsUIView(data: data, todayExpenses: todayExpenses)
    }

    func fetchMonthlyExpenses() -> [monthlyExpenses] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Purchase> = Purchase.fetchRequest()

        do {
            let purchases = try context.fetch(fetchRequest)
            let groupedPurchases = Dictionary(grouping: purchases, by: { $0.associatedCategory?.name ?? "Unknown" })
            return groupedPurchases.map { (category, purchases) in
                monthlyExpenses(category: category, amount: purchases.reduce(0) { $0 + $1.cost })
            }
        } catch {
            print("Failed to fetch data: \(error)")
            return []
        }
    }

    func calculateTodayExpenses(from data: [monthlyExpenses]) -> String {
        let todayExpenses = data.reduce(0) { $0 + $1.amount }
        return String(format: "%.2f", todayExpenses)
        
        // implement todayExpensesCounter
    }
}

struct ChartsUIView: View {
    var data: [monthlyExpenses]
    var todayExpenses: String
    
    
    var body: some View {
        VStack {
            Chart(data, id: \.category) { data in
                SectorMark(
                    angle: .value("Value", data.amount),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Product category", data.category))
            }
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    let frame = geometry[chartProxy.plotAreaFrame]
                    VStack {
                        Text("Spent in total")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(todayExpenses)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
//        .background(Color(red: 145 / 255, green: 221 / 255, blue: 207 / 255))
    }
}

#Preview {
    ChartsUIView(data: [
        .init(category: "A", amount: 5),
        .init(category: "B", amount: 9),
        .init(category: "C", amount: 7)
    
    ], todayExpenses: "300")
}




