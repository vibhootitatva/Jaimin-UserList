//
//  ViewController.swift
//  UserList
//
//  Created by PCQ184 on 20/04/20.
//  Copyright © 2020 PCQ184. All rights reserved.
//

import UIKit
import Foundation
//extension UIImageView {
//    func downloadFrom(url:URL,contentMode mode :UIView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data,resposne,error in
//            let mimeType = resposne?.mimeType
//            let data = data
//            let image = UIImage(data : data!)
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }.resume()
//    }
//}
//func downloadfrom(link:String,conentMode mode:UIView.ContentMode = .scaleAspectFit) {
//    let url = URL(string:link)
//    downloadfrom(link:"http://sd2-hiring.herokuapp.com/api/users?offset=0&limit=10",conentMode: mode)
//}
class ViewController: UIViewController {
    var info : [UserListModel]?
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userlist() {(result,response,error) in
           
        }
        // Do any additional setup after loading the view.
    }
    func userlist(completionhandler : @escaping(_ Success:Bool,_ Response:[Data], _ Error:NSError?)->()) {
        let strurl = URL(string:"https://sd2-hiring.herokuapp.com/api/users?offset=0&limit=10")!
        var request = URLRequest(url: strurl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if  let userinfo = try? JSONDecoder().decode(UserListModel.self, from: data!) {
                    print(userinfo)
                    self.info = [userinfo]
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
                
            }
        
        }.resume()
            //            }catch (let error){
            //                print(error)
            //            }
            
    }
        //    }
//                func imagedownload(fileurl:String, completion: @escaping(_ imageData: Data?)-> ()) {
//                    URLSession.shared.dataTask(with: URL(string:"http://sd2-hiring.herokuapp.com/api/users?offset=0&limit=10")!) { (Image, response, error) in
//                        if error == nil {
//                            completion(Image)
//                        }
//                        else {
//                            completion(nil)
//                        }
//                    }
//                }
//
            }
        


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info?[section].data?.users?.count ?? 0
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "UserDataCollectionViewCell", for: indexPath) as! UserDataCollectionViewCell
        cell.userNameLabel.text = info?[indexPath.row].data?.users?[indexPath.row].name
//        cell.profileImage.contentMode = .scaleToFill
//        let defaultLink = "https://loremflickr.com/cache/resized/65535_49479726458_dd0df61760_300_300_nofilter.jpg"
//        let completeLink = defaultLink + (info![indexPath.row].data?.users?[indexPath.row].image)!
//        cell.profileImage.downloadFrom(url:  URL(string:" http://sd2-hiring.herokuapp.com/api/users?offset=0&limit=10")!)
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 21)/2
        let height = (collectionView.frame.height - 21)/2
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    
}


