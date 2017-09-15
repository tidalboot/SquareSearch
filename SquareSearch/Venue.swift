
//  Created by Nick Jones on 04/09/2017.
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation

//We'll go for a class over a struct as any TelescopRecord objects will be initialised here and should never need to be copied anywhere for modification
class Venue {
    
    // MARK: - Global Properties 🌎
    //All properties should be read only, leaving the initialiser to do all of the work, the app is an image gallery and so by definition is read-only itself.
    let Name: String
    let Checkins: Int
    let CategoryName: String
    let ID: String
    
    
    // MARK: - Initialisers 🤖
    //We don't want this being accessed outside of this scope as
    private init(withName name: String,
                 checkins: Int,
                 categoryName: String,
                 andID id: String) {
        
        Name = name
        Checkins = checkins
        CategoryName = categoryName
        ID = id
    }
    
    // MARK: - Custom Methods 🔮
    //For ease of access and safety we always want this to return, at least, an empty typed array
    class func parseVenues(fromRawData rawData: Data?) -> [Venue] {
        var venues = [Venue]()
        
        guard let data = rawData else {
            return venues
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any] else {
                return venues
            }
            
            guard let response = json["response"] as? [String : Any] else {
                return venues
            }
            
            guard let rawVenues = response["venues"] as? [[String : Any]] else {
                return venues
            }
            
            for venue in rawVenues {
                
                //NAME
                let name = venue["name"] as? String ?? "N/A"
                //----------
                
                //CHECKINS
                var checkinsCount = 0
                if let stats = venue["stats"] as? [String : Int] {
                    checkinsCount = stats["checkinsCount"] ?? 0
                }
                //----------
                
                //CATEGORYNAME
                var categoryName = "N/A"
                if let categories = venue["categories"] as? [[String : Any]] {
                    if (!categories.isEmpty) {
                        categoryName = categories.first!["shortName"] as? String ?? "N/A"
                    }
                }
                //----------
                
                //ID
                let venueID = venue["id"] as? String ?? ""
                //----------
                
                venues.append(Venue(
                    withName: name,
                    checkins: checkinsCount,
                    categoryName: categoryName,
                    andID: venueID
                    )
                )
            }
            
            return venues
        } catch {
            return venues
        }
    }
}

