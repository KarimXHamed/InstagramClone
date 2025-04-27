//
//  ReelsCollectionViwDelegate.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
protocol ReelsCollectionViwDelegate:AnyObject{
    func numberOfItems(section:Int)->Int
    func numberOfSections()->Int
    func model(section:Int , index:Int)->ProductsCollectionViewCellModel?
    func getHeaderTitle(sectionIndex:Int)->String
}
