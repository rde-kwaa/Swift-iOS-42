//
//  APIController.swift
//  Tweet
//
//  Created by Ryan DE KWAADSTENIET on 2019/10/11.
//  Copyright © 2019 Ryan DE KWAADSTENIET. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func tweetBirdiesTweet(query: String, finished: () -> Void) {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let str = "https://api.twitter.com/1.1/search/tweets.json?q=\(q)&count=100&lang=en&result_type=recent"
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
            print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                /*  FORCE ERROR:
                 *  if var data = data {
                 *  data = data.base64EncodedData()
                 */
                if let data = data {
                    do {
                        var tweets: [Tweet] = []
                        let jData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let statuses: [NSDictionary] = (jData["statuses"] as? [NSDictionary])!
                        var count = 0
                        for elem in statuses {
                            let name = elem["user"] as! NSDictionary
                            let tweet = elem["text"]
                            let date = elem["created_at"]
                            tweets.append(Tweet(name: name.value(forKey: "name")! as! String, tweet: tweet! as! String, date: date! as! String))
                            count += 1
                        }
                        self.delegate?.ear(tweet: tweets)
                    } catch let err {
                        self.delegate?.exception(err: err as NSError)
                    }
                }
            }
        }
        finished()
        task.resume()
    }
}
