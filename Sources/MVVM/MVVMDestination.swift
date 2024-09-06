//
//  MVVMDestination.swift
//  MVVM
//
//  Created by Noah Plützer on 20.05.24.
//

import UIKit

public protocol MVVMDestination {
    associatedtype Dependencies
    func createModule(with dependencies: Dependencies, coordinator: MVVMCoordinator<Dependencies>) -> UIViewController
}
