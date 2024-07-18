//
//  MainUIViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 18.07.2024.
//

import UIKit
import SwiftUI
import Charts

class ChartsUIHostingController: UIHostingController<ChartsUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ChartsUIView())
    }
}

struct monthlyExpenses {
    var category: String
    var amount: Double
}

let data: [monthlyExpenses] = [
    .init(category: "A", amount: 5),
    .init(category: "B", amount: 9),
    .init(category: "C", amount: 7)
]

let todayExpenses = "300"

struct ChartsUIView: View {
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
                        Text("Spend today")
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
    ChartsUIView()
}




