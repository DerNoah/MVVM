//
//  MVVMViewModel.swift
//  MVVM
//
//  Created by Noah Plützer on 20.05.24.
//

public protocol MVVMViewModel: AnyObject {
    associatedtype View
    var view: View! { get }
}
