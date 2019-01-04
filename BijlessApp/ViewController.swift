//
//  ViewController.swift
//  BijlessApp
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var currentUserChatId = String()

struct User {
    let username: String!
    let uid: String!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users = [User]()

    @IBOutlet weak var tableView: UITableView!

    var ref: DatabaseReference!
    
//    var postData = [Post]()
    
    var onderwerpData = [String]()
    var naamData = [String]()
    var taalData = [String]()
    var beschrijvingData = [String]()
    var datumData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //aanmaken user voor chat
        let uid = Auth.auth().currentUser?.uid
        let database = Database.database().reference()
        database.child("Users").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            
            let username = (snapshot.value as? NSDictionary)?["userNaam"] as? String ?? ""
            let uid = (snapshot.value as? NSDictionary)?["uid"] as? String ?? ""
            self.users.append(User(username: username, uid: uid))
            self.tableView.reloadData()
        })
        
        self.tableView.reloadData()

        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference().child("Posts")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount>0{
//                self.postData.removeAll()
                self.naamData.removeAll()
                self.onderwerpData.removeAll()
                self.taalData.removeAll()
                self.beschrijvingData.removeAll()
                self.datumData.removeAll()
                
                for posts in snapshot.children.allObjects as![DataSnapshot]{
                    let postObject = posts.value as? [String: AnyObject]
            
                    let postBeschrijving = postObject?["postBeschrijving"]
                    let postDatum = postObject?["postDatum"]
                    let postNaam = postObject?["postNaam"]
                    let postOnderwerp = postObject?["postOnderwerp"]
                    let postTaal = postObject?["postTaal"]
                    
//                    let post = Post(id: postId as! String?, onderwerp: postNaam as! String?, naam: postOnderwerp as! String?, beschrijving: postBeschrijving as! String?, datum: postDatum as! String?, taal: postTaal as! String?)
                    
//                    self.postData.append(post)
                    
                    self.onderwerpData.append(postOnderwerp as! String)
                    self.naamData.append(postNaam as! String)
                    self.datumData.append(postDatum as! String)
                    self.beschrijvingData.append(postBeschrijving as! String)
                    self.taalData.append(postTaal as! String)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postData.count
        return naamData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        let post: Post
        
//        post = postData[indexPath.row]
        
//        cell.lblNaam.text = post.naam
//        cell.lblOnderwerp.text = post.onderwerp
        
        cell.lblNaam.text = naamData[indexPath.row]
        cell.lblOnderwerp.text = onderwerpData[indexPath.row]
        cell.lblDatum.text = datumData[indexPath.row]
        cell.lblBeschrijving.text = beschrijvingData[indexPath.row]
        cell.lblTaal.text = taalData[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
//        vc.commonInit(postData[indexPath.item])
//        vc.commonInit2(naam: naamData[indexPath.item],
//                       onderwerp: onderwerpData[indexPath.item],
//                       datum: datumData[indexPath.item],
//                       taal: taalData[indexPath.item],
//                       beschrijving: beschrijvingData[indexPath.item]
//                      )
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.tableView.deselectRow(at: indexPath, animated: true)
//
////        print("postData: \(postData)")
//        print("naamData: \(naamData)")
//        print("onderwerpData: \(onderwerpData)")
//
        
        currentUserChatId = users[indexPath.row].uid
        
        let vcChat = ChatViewController()
        vcChat.commonInit(users[indexPath.row].username)
        vcChat.commonInit2(naam: naamData[indexPath.item],
                                onderwerp: onderwerpData[indexPath.item],
                                datum: datumData[indexPath.item],
                                taal: taalData[indexPath.item],
                                beschrijving: beschrijvingData[indexPath.item])
        print("users: \(users[indexPath.row].username!)")
//        print("onderwerp: \(onderwerpData[indexPath.item])")
//        print("taal : \(taalData[indexPath.item])")
    }
}

