//
//  HomeRouter.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import Foundation
import UIKit


struct HomeControllerEntity {
}

struct HomeRouterInput {

    func view(entryEntity: HomeEntity) -> HomeController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let view = st.instantiateViewController(withIdentifier: "HomeController") as! HomeController
        let interactor = HomeInteractor()
        let dependencies = HomePresenterDependencies(interactor: interactor, router: HomeRouterOutput(view))
        let presenter = HomePresenter(entryEntity: entryEntity, dependencies: dependencies)
        view.presenter = presenter
        return view
    }

    func push(from: Viewable, entryEntity: HomeEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }

    func present(from: Viewable, entryEntity: HomeEntity) {
        let nav = UINavigationController(rootViewController: view(entryEntity: entryEntity))
        from.present(nav, animated: true)
    }
}

final class HomeRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func transitionDetail() {
        //DetailRouterInput().push(from: view, entryEntity: DetailEntryEntity(gitHubRepository: gitHubRepository))
    }
}
