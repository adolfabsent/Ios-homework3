//
//  Post.swift
//  Navigation
//
//  Created by Максим Зиновьев on 10.08.2023.
//

import UIKit


    public struct bookPost {
       public var author : String
        public var image: String
        public var description: String
        public var likes: Int
        public var views: Int
        public var id : Int

    }



public var post : [bookPost] = [
    bookPost(author: "best-books", image: "Marcel Proust", description: "Valentin Louis Georges Eugène Marcel Proust (/pruːst/ PROOST,[1] French: [maʁsɛl pʁust]; 10 July 1871 – 18 November 1922) was a French novelist, literary critic.", likes: 207, views: 987,id: 0),
    bookPost(author: "books must read", image: "James Joyce", description: "James Augustine Aloysius Joyce (2 February 1882 – 13 January 1941) was an Irish novelist, poet, and literary critic. ", likes: 515, views: 1245, id: 1),
    bookPost(author: "classic literature", image: "Miguel de Cervantes",  description: "Miguel de Cervantes Saavedra (Spanish: [miˈɣel de θeɾˈβantes saaˈβeðɾa]; 29 September 1547 (assumed) – 22 April 1616) was an Early Modern Spanish writer widely regarded as the greatest writer in the Spanish language and one of the world's pre-eminent novelists." , likes: 505, views: 1312, id: 2),
    bookPost(author: "most famous poet", image: "Vladimir Nabokov", description: "Vladimir Vladimirovich Nabokov[b] (Russian: Владимир Владимирович Набоков [vlɐˈdʲimʲɪr vlɐˈdʲimʲɪrəvʲɪtɕ nɐˈbokəf] (listen); 22 April [O.S. 10 April] 1899[a] – 2 July 1977)", likes: 456, views: 1130, id: 3),
    bookPost(author: "classic novel", image: "Emily Brontë", description: "Emily Jane Brontë (/ˈbrɒnti/, commonly /-teɪ/;[2] 30 July 1818 – 19 December 1848)[3] was an English novelist and poet.", likes: 209, views: 889, id: 4),
]
