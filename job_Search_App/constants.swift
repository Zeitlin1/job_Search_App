//
//  constants.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation

let storageRoot = "gs://jobsearchapp-24a3d.appspot.com"

let firstChild = "/contactsFolder/"

let childFile = "contactstestdata.csv"

//let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestProperty.json?alt=media&token=f50891e2-a3a1-493c-a3ec-ee8edb293d33"

let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestPropertyShort.json?alt=media&token=a988194e-d27d-4830-ba01-17d7c4359cd6"

let hunterAPIkey = "5fe55320e40bcccebccd0dd88059a606e7baeadf"

///Get every email address found on the internet using a given domain name, with sources.

let hunterAPIkeyDOMAIN_Search = ("https://api.hunter.io/v2/domain-search?domain=stripe.com&api_key=\(hunterAPIkey)")

///Find the email address of someone from his first name, last name and domain name.

let hunterAPIkeyFirst_Last_Domain_Search = ("https://api.hunter.io/v2/email-finder?domain=asana.com&first_name=Dustin&last_name=Moskovitz&api_key=\(hunterAPIkey)")

///Check if a given email address is deliverable and has been found on the internet.

let hunterAPIkeyValidation = ("https://api.hunter.io/v2/email-verifier?email=steli@close.io&api_key=\(hunterAPIkey)")
