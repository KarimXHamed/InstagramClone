//
//  ReelsCollectionViewCellModel.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import IGListKit
class ReelsCollectionViewCellModel: ListDiffable{
    let url:String
    let thumbnail:String
    let userName:String
    init(url: String, thumbnail: String, userName: String) {
        self.url = url
        self.thumbnail = thumbnail
        self.userName = userName
    }
    func diffIdentifier() -> NSObjectProtocol {
        return url as NSString
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? ReelsCollectionViewCellModel else { return false } 
        return url == other.url && thumbnail == other.thumbnail && userName == other.userName
    }
}
