//
//  ViewController.swift
//  Discoveread
//
//  Created by Sondhayni Murmu on 6/11/16.
//  Copyright © 2016 Sondhayni Murmu. All rights reserved.
//

import UIKit
import SwiftyJSON
//XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

let googleBooksAPIKey = "AIzaSyBUcv5vi-Xcvzkj_WFdrGZ22aArd1nHteg"

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APItest("The Elegance of the Hedgehog")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func APItest(title: String){
        //check if the title has spaces, and if so replace it with + signs
        let fixedTitle = title.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        //search for something by title using my API key
        
        var jsonRes:AnyObject?

        let urlString: String = "https://www.googleapis.com/books/v1/volumes?q=" + "\(fixedTitle)" + "&key=\(googleBooksAPIKey)"
        
//        var request: NSMutableURLRequest = NSMutableURLRequest()
//        request.URL = NSURL(string: url)
//        request.HTTPMethod = "GET"
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet

        let urlEx: String = urlString.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)!
        
        //making that an NSURL object (?)
        let url = NSURL(string: urlEx);
        
        print("faksjdfkljsf \(urlString)")
        print(url)
        
        //url request
//        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        
        //creating a URLSession for networking
        let session = NSURLSession.sharedSession()

        print("are you getting HERE?")
        
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) in
            
            print("are you getting here?")
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200 {
                    print("PLS FOR THE LOVE OF ALL THAT IS GOOD")
                    do {
                        jsonRes = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                    }
                    catch let error as NSError {
                        print("json error: \(error.localizedDescription)")
                    }
                    
                }
                else{
                    print(error?.localizedDescription)
                }

            }
            
            let json = JSON(jsonRes!)
            let author: String? = json["items"][0]["volumeInfo"]["authors"][0].string
            
            print("The author of \(title) is \(author)")

        }
        
        task.resume()

        // In order to actually make the web request, we need to "resume"
    }
    
    
    }




