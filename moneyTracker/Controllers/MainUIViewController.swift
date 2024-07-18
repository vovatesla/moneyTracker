//
//  MainUIViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 18.07.2024.
//

import UIKit
import SwiftUI
import Charts


class MainUIViewController: UIHostingController<ChartsUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ChartsUIView())
    }
}
