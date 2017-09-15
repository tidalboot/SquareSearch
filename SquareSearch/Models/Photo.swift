
//  Photos
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation

class Photo {
    class func createPhotoURL(fromRawPhotoData rawPhotoData: Data) -> URL? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: rawPhotoData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any] else {
                return nil
            }
            
            guard let response = json["response"] as? [String : Any] else {
                return nil
            }
            
            guard let photos = response["photos"] as? [String : Any] else {
                return nil
            }
            
            guard let items = photos["items"] as? [[String : Any]] else {
                return nil
            }
            
            if (items.isEmpty) {
                return nil
            }
            
            //We need all of these to be available before we can get a fully formed URL string
            guard let prefix = items.first!["prefix"] as? String,
                let suffix = items.first!["suffix"] as? String,
                let width = items.first!["width"] as? Int,
                let height = items.first!["height"] as? Int else {
                return nil
            }
            
            return URL(string: "\(prefix)\(width)x\(height)\(suffix)") ?? nil
        } catch {
            return nil
        }
    }
}
