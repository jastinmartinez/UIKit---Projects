//
//  RemoteCatLoaderMapper.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation


public enum RemoteCatLoaderMapper {
    
    private static var OK_200: Int {
        return 200
    }
    
    static func map(_ data: Data, response: HTTPURLResponse) -> CatLoaderResult {
        do {
            guard response.statusCode == OK_200 else {
                return .failure(RemoteCatLoader.Error.statusCode(response.statusCode))
            }
            let cats = try JSONDecoder().decode([RemoteCat].self, from: data)
            return .success(cats.toModels())
        } catch {
            return .failure(RemoteCatLoader.Error.data(error.localizedDescription))
        }
    }
}
