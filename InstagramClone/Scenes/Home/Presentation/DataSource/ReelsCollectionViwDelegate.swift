//
//  ReelsCollectionViwDelegate.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import IGListKit
protocol ReelsCollectionViewDelegate:AnyObject{
    func numberOfItems()->Int
    func models()->[ListDiffable]
}
