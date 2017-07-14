//
//  PostsViewController.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

struct Post {
  let id: String
  let authorID: String //id only
  let title: String
  let created: Date

  init?(_ id: String, payload: [String: Any]) {
    self.id = id
    self.authorID = payload["author"] as! String
    self.title = payload["title"] as! String
    self.created = ISO8601DateFormatter().date(from: payload["created"] as! String)!
  }
}

final class PostsViewController: UIViewController {

  var posts = [Post]() {
    didSet {
      myPosts = posts.filter { $0.authorID == Auth.auth().currentUser?.uid }
      otherPosts = posts.filter { $0.authorID != Auth.auth().currentUser?.uid }
//      postsTableView.reloadData()
    }
  }
  fileprivate var myPosts = [Post]() {
    didSet { postsTableView.reloadSections(IndexSet(integer: 0), with: .automatic) }
  }
  fileprivate var otherPosts = [Post]() {
    didSet { postsTableView.reloadSections(IndexSet(integer: 1), with: .automatic) }
  }

  // MARK: - UI

  @IBOutlet fileprivate weak var postsTableView: UITableView! {
    didSet {
      postsTableView.rowHeight = UITableViewAutomaticDimension
      postsTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    Database.database().reference(withPath: "posts")
      .observe(.value) { (snapshot: DataSnapshot) in
        guard let posts = snapshot.value as? [String: Any] else { return }
        self.posts = posts.flatMap({ (key: String, value: Any) -> Post? in
          return Post(key, payload: value as! [String: Any])
        })
//        print("============================================")
//        print("Some value = \(snapshot.children.allObjects)")
//        print("============================================")
    }
  }

  // MARK: - Add post

  @IBAction func addPost(_ sender: UIBarButtonItem) {
    Database.database().reference(withPath: "posts")
      .childByAutoId()
      .updateChildValues([
        "author": Auth.auth().currentUser!.uid,
        "title": UUID().uuidString,
        "created": ISO8601DateFormatter().string(from: Date()),
        "offers": []
      ])
  }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return myPosts.count
    case 1: return otherPosts.count
    default: return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
    switch indexPath.section {
    case 0: cell.textLabel?.text = myPosts[indexPath.row].title
    case 1: cell.textLabel?.text = otherPosts[indexPath.row].title
    default: break
    }
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0: return "My posts"
    case 1: return "Others"
    default: return "Undefined"
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

}
