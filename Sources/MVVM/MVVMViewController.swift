//
//  MVVMViewController.swift
//  MVVM
//
//  Created by Noah Plützer on 20.05.24.
//

import UIKit

public protocol MVVMViewController: UIViewController {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}
