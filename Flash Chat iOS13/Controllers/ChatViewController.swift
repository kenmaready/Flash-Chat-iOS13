//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = []
    var selectedrow: Int = 0
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = K.Title
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.Cells.NibName, bundle: nil), forCellReuseIdentifier: K.Cells.Identifier)
        
        loadMessages()
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                ErrorAlert.show(message: signOutError.localizedDescription, sender: self)
            }
      
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let body = messageTextfield.text, let sender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.CollectionName).addDocument(data: [K.FStore.SenderField: sender, K.FStore.BodyField: body, K.FStore.DateField: Date()]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore: \(e.localizedDescription)")
                } else {
                    print("Data successfully saved to firestore.")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    func loadMessages() {
        db.collection(K.FStore.CollectionName)
            .order(by: K.FStore.DateField)
            .addSnapshotListener { (querySnapshot, error) in
            if let e = error {
                print("There was an issue retrieving data from firestore: \(e.localizedDescription)")
            } else {
                if let documents = querySnapshot?.documents {
                    self.messages = []
                    for doc in documents {
                        let data = doc.data()
                        let message = Message(
                            sender: data[K.FStore.SenderField] as! String,
                            body: data[K.FStore.BodyField] as! String,
                            createdAt: Date(timeIntervalSince1970: TimeInterval((data[K.FStore.DateField] as! Timestamp).seconds))
                            )
                        self.messages.append(message)
                    }
                    // sort method (not needed b/c now using ordered retrieval from fb)
                    // self.messages = self.messages.sorted(by: {
                    //      $0.createdAt < $1.createdAt
                    // })
                }
            }
            print("messages: \(self.messages)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.Identifier, for: indexPath) as! MessageCell
        
        cell.label?.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youIcon.isHidden = true
            cell.meIcon.isHidden = false
            cell.bubble.backgroundColor = UIColor(named: K.BrandColors.LightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.Purple)
            cell.label.textAlignment = NSTextAlignment(CTTextAlignment.right)
        } else {
            cell.meIcon.isHidden = true
            cell.youIcon.isHidden = false
            cell.bubble.backgroundColor = UIColor(named: K.BrandColors.LightBlue)
            cell.label.textColor = UIColor(named: K.BrandColors.Blue)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedrow = indexPath.row
    }
}
