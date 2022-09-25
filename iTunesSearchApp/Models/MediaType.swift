//
//  MediaType.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

enum MediaType:Int,CaseIterable {
    case Album = 0
    case Artist
    case Book
    case Movie
    case MusicVideo
    case Podcast
    case Song
    
    var title:String {
        switch self {
        case .Album:
            return "Album"
            
        case .Artist:
            return "Artist"
            
        case .Book:
            return "Book"
            
        case .Movie:
            return "Movie"
            
        case .MusicVideo:
            return "Music Video"
            
        case .Podcast:
            return  "Podcast"
            
        case .Song:
            return "Song"
        }
    }
}
