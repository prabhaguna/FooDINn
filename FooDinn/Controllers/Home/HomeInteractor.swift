//
//  HomeInteractor.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper
import Moya_ObjectMapper

class HomeInteractor {
    
    let discountResponse = PublishSubject<DiscountResponse>()
    let categoryResponse  = PublishSubject<CategoryResponse>()
    let menuItemsResponse =  PublishSubject<MenuItemsResponse>()
    let menuFiltersResponse = PublishSubject<MenuFiltersResponse>()
    let orderedMenuItems = PublishSubject<[MenuItems]>()
    
    var orderedItems = [MenuItems]()

    init() {
      
    }
    
    func selectedDiscount(index: Int) {
        
    }
    
    func selectedCategory(index: Int) {
        fetchMenuItems()
    }
    
    func selectedFilter(index: Int) {
        
    }
    
    func selectedMenuItems(menuItem : MenuItems) {
    
        menuItem.OrderedCount += 1
        if !orderedItems.contains(menuItem)  {
            orderedItems.append(menuItem)
        }
        orderedMenuItems.onNext(orderedItems)
        //self.outputs.cartCount.onNext("\(orderedMenuItems.count)")
        //self.outputs.isShowCartCount.onNext( orderedMenuItems.count > 0 ? true : false)
    }

    
    func fetchAll() {
        fetchDiscount()
        fetchCategory()
        fetchFilters()
        fetchMenuItems()
    }
    
    func fetchDiscount() {
        _ = apiProvider.rx.request(.discount)
            .mapString()
            .subscribe { event in
            switch event {
            case .success(let response):
                if let dResponse = DiscountResponse(JSONString: response) {
                    self.discountResponse.onNext(dResponse)
                }
            case .error(let error):
                print("error\(error) ")
            }
        }
    }
    
    func fetchCategory() {
        _ = apiProvider.rx.request(.category)
            .mapString()
            .subscribe { event in
            switch event {
            case .success(let response):
                print("success \(response)")
                if let mResponse = CategoryResponse(JSONString: response) {
                    self.categoryResponse.onNext(mResponse)
                }
            case .error(let error):
                print("error\(error) ")
            }
        }
    }
    
    func fetchFilters() {
        _ = apiProvider.rx.request(.menuFilters)
            .mapString()
            .subscribe { event in
            switch event {
            case .success(let response):
                print("success \(response)")
                if let mResponse = MenuFiltersResponse(JSONString: response) {
                    self.menuFiltersResponse.onNext(mResponse)
                }
            case .error(let error):
                print("error\(error) ")
            }
        }
    }
    
    func fetchMenuItems() {
      _ = apiProvider.rx.request(.menuItems)
            .mapString()
            .subscribe { event in
            switch event {
            case .success(let response):
                print("success \(response)")
                if let mResponse = MenuItemsResponse(JSONString: response) {
                    self.menuItemsResponse.onNext(mResponse)
                }
            case .error(let error):
                print("error\(error) ")
            }
        }
    }

}
