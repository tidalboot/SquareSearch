
//  Search
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation
import UIKit

//Going for Search rather than something like "SearchController" as I think the inheritance from UIViewController provides this information itself
class Search: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Local Properties 💻
    private var searchResults: UICollectionView!
    private var venues = [Venue]()
    
    // MARK: - Collection View Delegate Methods 📦
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let venueToUse = venues[indexPath.row]
        
        let searchItem = collectionView.dequeueReusableCell(withReuseIdentifier: "searchItem", for: indexPath) as! SearchItem
        searchItem.backgroundColor = .darkGray
        
        //Venue Name Label
        searchItem.nameLabel = UILabel(frame: CGRect(
            x: 10,
            y: searchItem.frame.size.height * 0.1,
            width: searchItem.frame.size.width * 0.6,
            height: searchItem.frame.size.height * 0.3
            )
        )
        searchItem.nameLabel.text = venueToUse.Name
        searchItem.nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        searchItem.nameLabel.textColor = .white
        searchItem.nameLabel.numberOfLines = 1
        //-----
        
        //Venue Checkins Label
        searchItem.checkinsLabel = UILabel(frame: CGRect(
            x: 10,
            y: searchItem.frame.size.height * 0.7,
            width: searchItem.frame.size.width,
            height: searchItem.frame.size.height * 0.3
            )
        )
        searchItem.checkinsLabel.text = "Checkins: \(venueToUse.Checkins)"
        searchItem.checkinsLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        searchItem.checkinsLabel.textColor = .white
        searchItem.checkinsLabel.numberOfLines = 1
        //-----
        
        //Venue Category Label
        searchItem.categoryLabel = UILabel(frame: CGRect(
            x: searchItem.frame.size.width * 0.6 + 10,
            y: searchItem.frame.size.height * 0.1,
            width: searchItem.frame.size.width * 0.4 - 20,
            height: searchItem.frame.size.height * 0.3
            )
        )
        searchItem.categoryLabel.text = venueToUse.CategoryName
        searchItem.categoryLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        searchItem.categoryLabel.textColor = .white
        searchItem.categoryLabel.numberOfLines = 1
        //-----
        
        return searchItem
    }
    
    // MARK: - UIView Delegate Methods 👑
    //Whilst we could move a lot of this out to builder methods or elsewhere since it's only being used it feels like a waste; Better to keep it here for now
    //If we had tests around any of this then we'd definitely need to move it out to allow it to be testable. But initially I'm only interested in ensuring that our data parsing is correct and working
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        //Collection View Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: view.frame.size.width,
            height: view.frame.size.width * 0.65
        )
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        //-----
        
        
        //Gallery Collection View
        let gallerySize = CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: view.frame.size.height
        )
        searchResults = UICollectionView(frame: gallerySize, collectionViewLayout: layout)
        searchResults.contentInset = .zero
        searchResults.delegate = self
        searchResults.dataSource = self
        searchResults.register(SearchItem.self, forCellWithReuseIdentifier: "searchItem")
        searchResults.backgroundColor = .white
        searchResults.alpha = 0
        searchResults.layoutMargins = .zero
        //-----
        
        view.addSubview(searchResults)
        
        getVenues()
    }
    
    // MARK: - Custom Methods 🔮
    private func showNewVenues() {
        searchResults.reloadData()
        searchResults.setContentOffset(.zero, animated: false)
    }
    
    private func getVenues() {
        if let mockedVenuesDataPath = Bundle.main.url(forResource: "ColchesterVenues", withExtension: "json") {
            do {
                let rawVenuesData = try Data(contentsOf: mockedVenuesDataPath)
                venues = Venue.parseVenues(fromRawData: rawVenuesData)
                showNewVenues()
            } catch {
                return
            }
        }
    }
}
