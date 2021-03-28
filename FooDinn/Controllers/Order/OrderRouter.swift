//
//  OrderRouter.swift
//  FooDinn
//
//  Created by devMac02 on 26/03/21.
//

import Foundation
import UIKit

struct OrderEntity {
    
}

struct OrderRouterInput {

    func view(entryEntity: OrderEntity) -> OrderController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let view = st.instantiateViewController(withIdentifier: "OrderController") as! OrderController
        let interactor = OrderInteractor()
        let dependencies = OrderPresenterDependencies(interactor: interactor, router: OrderRouterOutput(view))
        let presenter = OrderPresenter(entryEntity: entryEntity, dependencies: dependencies)
        view.presenter = presenter
        return view
    }

    func push(from: Viewable, entryEntity: OrderEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }

    func present(from: Viewable, entryEntity: OrderEntity) {
        let nav = UINavigationController(rootViewController: view(entryEntity: entryEntity))
        from.present(nav, animated: true)
    }
}

final class OrderRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func transitionDetail() {
        //DetailRouterInput().push(from: view, entryEntity: DetailEntryEntity(gitHubRepository: gitHubRepository))
    }
}
