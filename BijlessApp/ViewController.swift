//
//  ViewController.swift
//  BijlessApp
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var ref: DatabaseReference!
    
    var postData = [Post]()
    var onderwerpData = [String]()
    var naamData = [String]()
//    var onderwerpData = [String]()
//    var onderwerpData = [String]()
//    var onderwerpData = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference().child("Posts")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount>0{
                self.postData.removeAll()
//                self.naamData.removeAll()
//                self.onderwerpData.removeAll()

                
                for posts in snapshot.children.allObjects as![DataSnapshot]{
                    let postObject = posts.value as? [String: AnyObject]
                    
                    let postNaam = postObject?["postNaam"]
                    let postOnderwerp = postObject?["postOnderwerp"]
                    let postId = postObject?["id"]
                    
                    let post = Post(id: postId as! String?, onderwerp: postNaam as! String?, naam: postOnderwerp as! String?)
                    
                    self.postData.append(post)
                    self.onderwerpData.append(postOnderwerp as! String)
                    self.naamData.append(postNaam as! String)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
//        return naamData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let post: Post
        
        post = postData[indexPath.row]
        
        cell.lblNaam.text = post.naam
        cell.lblOnderwerp.text = post.onderwerp
        
//        cell.lblNaam.text = naamData[indexPath.row]
//        cell.lblOnderwerp.text = onderwerpData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.commonInit(onderwerpData[indexPath.item])
        vc.commonInit2(naam: naamData[indexPath.item], onderwerp: onderwerpData[indexPath.item])
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        print("postData: \(postData)")
        print("naamData: \(naamData)")
        print("onderwerpData: \(onderwerpData)")

    }
}

