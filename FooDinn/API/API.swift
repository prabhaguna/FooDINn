//
//  API.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import Moya

let apiProvider = MoyaProvider<Api>(stubClosure: MoyaProvider.immediatelyStub)

public enum Api {
    case discount
    case category
    case menuItems
    case menuFilters
}

extension Api : TargetType {
    

    public var baseURL: URL { return URL(string: "https://fooDinn.com")! }
    
    public var path: String {
        switch self {
            case .discount:
                return "discount"
            case .category:
                return "category"
            case .menuItems:
                return "menuItems"
            case .menuFilters:
                return "menuFilters"
        }
    }
    
    public var method: Moya.Method {
        switch self {
            case .discount:
                return .get
            case .category:
                return .get
            case .menuItems:
                return .get
            case .menuFilters:
                return .get
        }
    }
    
    public var task: Task {
        switch self {
            case .discount:
                return .requestPlain
            case .category:
                return .requestPlain
            case .menuItems:
                return .requestPlain
            case .menuFilters:
                return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return getMockData()
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    func getMockData() -> Data {
        
        var jsonFileName = ""
        switch self {
            case .discount:
                jsonFileName = "discount"
            case .category:
                jsonFileName = "category"
            case .menuItems:
                jsonFileName = "menuItems"
            case .menuFilters:
                jsonFileName = "filterview"
        }
        
        if let path = Bundle.main.path(forResource:jsonFileName, ofType: "json") {
        do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
              return data
          } catch {
          }
        }
        return Data()
    }
}
