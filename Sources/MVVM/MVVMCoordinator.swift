//
//  MVVMCoordinator.swift
//  MVVM
//
//  Created by Noah Plützer on 20.05.24.
//

import UIKit

public typealias MVVMCoordinatorStackModificationBlock = ([UIViewController]) -> [UIViewController]

public final class MVVMCoordinator<Dependencies> {
    public let navigationController: UINavigationController
    private let dependencies: Dependencies
    
    public var currentStack: [UIViewController] {
        navigationController.viewControllers
    }
    
    public init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func pushDestination<Destination: MVVMDestination>(_ destination: Destination, animated: Bool = true) where Destination.Dependencies == Dependencies {
        let viewController = destination.createModule(with: dependencies, coordinator: self)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
	public func pushDestination<Destination: MVVMDestination>(
		_ destination: Destination,
		usingDelegate navigationDelegate: UINavigationControllerDelegate?,
		animated: Bool = true
	) where Destination.Dependencies == Dependencies {
        let viewController = destination.createModule(with: dependencies, coordinator: self)
		
		navigationController.delegate = navigationDelegate
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func pushDestination<Destination: MVVMDestination>(
        _ destination: Destination,
        animated: Bool = true,
        modifyStack block: MVVMCoordinatorStackModificationBlock
    ) where Destination.Dependencies == Dependencies {
        let viewController = destination.createModule(with: dependencies, coordinator: self)
        
        modifyStack(animated: false, block)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func pop(animated: Bool = true, modifyStack block: MVVMCoordinatorStackModificationBlock) {
        modifyStack(animated: false, block)
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    public func modifyStack(animated: Bool, _ block: MVVMCoordinatorStackModificationBlock) {
        let newViewControllers = block(navigationController.viewControllers)
        navigationController.setViewControllers(newViewControllers, animated: animated)
    }
    
    public func present<Destination: MVVMDestination>(_ destination: Destination, animated: Bool = true) where Destination.Dependencies == Dependencies {
        let viewController = destination.createModule(with: dependencies, coordinator: self)
        navigationController.present(viewController, animated: animated)
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        navigationController.visibleViewController?.dismiss(animated: true, completion: completion)
    }
}
