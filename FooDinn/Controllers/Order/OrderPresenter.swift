//
//  OrderPresenter.swift
//  FooDinn
//
//  Created by devMac02 on 26/03/21.
//

import Foundation
import RxSwift
import RxCocoa


typealias OrderPresenterDependencies = (
    interactor: OrderInteractor,
    router: OrderRouterOutput
)

protocol OrderPresenterInputs {
 
}

protocol OrderPresenterOutputs {

}

protocol OrderPresenterInterface {
    var inputs: OrderPresenterInputs { get }
    var outputs: OrderPresenterOutputs { get }
}

class OrderPresenter: OrderPresenterInterface, OrderPresenterInputs, OrderPresenterOutputs {
    
    var inputs: OrderPresenterInputs { return self }
    var outputs: OrderPresenterOutputs { return self }
    
    var arrSelectedMenuItems : [MenuItems] = [MenuItems]()
    
    private let dependencies: OrderPresenterDependencies
    private let disposeBag = DisposeBag()

    
    init(entryEntity: OrderEntity,
         dependencies: OrderPresenterDependencies)
    {
        self.dependencies = dependencies
    }
   
}
