//
//  HomePresenter.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import Foundation
import RxSwift
import RxCocoa

typealias HomePresenterDependencies = (
    interactor: HomeInteractor,
    router: HomeRouterOutput
)

protocol HomePresenterInputs {
    var viewDidLoadTrigger: PublishSubject<Void> { get }
    
    var selectedDiscount: PublishSubject<Int> { get }
    var selectedCategory: PublishSubject<Int> { get }
    var selectedFilter: PublishSubject<Int> { get }
    var filter: PublishSubject<Void> { get }
    var selectedMenuItems: PublishSubject<MenuItems> { get }
}

protocol HomePresenterOutputs {
    //var isLoading: Observable<Bool> { get }
    //var error: Observable<NSError> { get }
    
    var arrDiscount : PublishSubject<[Discount]> { get }
    var arrCategory : PublishSubject<[Category]> { get }
    var arrMenuFilters : PublishSubject<[MenuFilters]> { get }
    var arrMenuItems : PublishSubject<[MenuItems]> { get }
    var currentSelectedMenu : PublishSubject<Int> { get }
    var cartCount : PublishSubject<String> { get }
    var arrSelectedMenuItems : PublishSubject<MenuItems> {get}
    var isShowCartCount : PublishSubject<Bool> { get }
    
}

protocol HomePresenterInterface {
    var inputs: HomePresenterInputs { get }
    var outputs: HomePresenterOutputs { get }
}

class HomePresenter: HomePresenterInterface, HomePresenterInputs, HomePresenterOutputs,
                            DiscountViewProtocol,
                            CategoryViewProtocol,
                            FilterViewProtocol,
                            MenuItemsViewProtocol {


    var inputs: HomePresenterInputs { return self }
    var outputs: HomePresenterOutputs { return self }
    
    //Input
    var viewDidLoadTrigger = PublishSubject<Void>()
    var selectedDiscount = PublishSubject<Int>()
    var selectedCategory = PublishSubject<Int>()
    var selectedFilter =  PublishSubject<Int>()
    var filter = PublishSubject<Void>()
    var selectedMenuItems = PublishSubject<MenuItems>()
    var applyFilter = PublishSubject<Void>()

    var currentSelectedMenu = PublishSubject<Int>()
    var cartCount = PublishSubject<String>()


    //Output
    var arrDiscount = PublishSubject<[Discount]>()
    var arrCategory = PublishSubject<[Category]>()
    var arrMenuFilters = PublishSubject<[MenuFilters]>()
    var arrMenuItems = PublishSubject<[MenuItems]>()
    var arrSelectedMenuItems = PublishSubject<MenuItems>()
     
    var isShowCartCount = PublishSubject<Bool>()
    
    private let dependencies: HomePresenterDependencies
    private let disposeBag = DisposeBag()

    
    init(entryEntity: HomeEntity,
         dependencies: HomePresenterDependencies)
    {
  
        self.dependencies = dependencies
        
        dependencies.interactor.discountResponse
        .subscribe(onNext: { [weak self] discounts in
            self!.arrDiscount.onNext(discounts.items!)
        }).disposed(by: disposeBag)
        
        dependencies.interactor.categoryResponse
        .subscribe(onNext: { [weak self] category in
            self!.arrCategory.onNext(category.items!)
        }).disposed(by: disposeBag)
        
        dependencies.interactor.menuFiltersResponse
        .subscribe(onNext: { [weak self] discounts in
            self!.arrMenuFilters.onNext(discounts.items!)
        }).disposed(by: disposeBag)
        
        dependencies.interactor.menuItemsResponse
        .subscribe(onNext: { [weak self] discounts in
            self!.arrMenuItems.onNext(discounts.items!)
        }).disposed(by: disposeBag)
        
        dependencies.interactor.orderedMenuItems
        .subscribe(onNext: { [weak self] orderedMenuItems in
            self!.updateOrderCount(orderedItems: orderedMenuItems)
        }).disposed(by: disposeBag)
        
        viewDidLoadTrigger.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: fetcchData)
            .disposed(by: disposeBag)
            
        selectedMenuItems.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: dependencies.interactor.selectedMenuItems)
            .disposed(by: disposeBag)
            
        selectedCategory.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: dependencies.interactor.selectedCategory)
            .disposed(by: disposeBag)
            
        currentSelectedMenu.onNext(0)
    }
    
    private func fetcchData() {
        dependencies.interactor.fetchAll()
    }
    
    private func updateOrderCount(orderedItems : [MenuItems]){
        self.outputs.cartCount.onNext("\(orderedItems.count)")
        self.outputs.isShowCartCount.onNext( orderedItems.count > 0 ? true : false)
    }
    

}
