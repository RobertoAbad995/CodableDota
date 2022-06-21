//
//  Extension+UserDefaults.swift
//  CodableDota
//
//  Created by Consultant on 6/20/22.
//

import Foundation
import UIKit

extension UserDefaults {
    
    var favorites: [Int]{
        
        get{
            let data = array(forKey: userDefaulKeys.favorites.rawValue)
            
            if data == nil {
                return [Int]()
            }
            
            return data as! [Int]
        }
        set{
            setValue(newValue, forKey: userDefaulKeys.favorites.rawValue)
        }
    }
    
    private enum userDefaulKeys:String{
        case favorites
    }

    
    func cacheImage(urlString: String, img: UIImage){
        
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String: String]()
        }
        
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
        
    }
    
    static func reloadImage(urlString: String, completion: @escaping (String,UIImage?)->Void) {
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        {
            if let path = dict[urlString]{
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    let img = UIImage(data: data)
                    completion(urlString, img)
                }
            }
        }
    }
    
    
}
