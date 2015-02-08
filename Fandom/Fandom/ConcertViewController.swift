//
//  ConcertViewController.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos

class ConcertViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Motion detector
    let motionData:MotionDetection = MotionDetection();

    //Pictures
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!

    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var buttonStartMotion: UIButton!
    @IBOutlet weak var buttonStopMotion: UIButton!
    
    @IBAction func toggleStartMotion(sender: AnyObject) {
        //start - IFF the accelerometer is not running
        if(buttonStartMotion.titleLabel?.text == "Start") {
            if(!motionData.motionManager.accelerometerActive) {
                motionData.movement();
            }
            buttonStartMotion.setTitle("Pause", forState: UIControlState.Normal);
        } else {
            motionData.motionManager.stopAccelerometerUpdates();
            buttonStartMotion.setTitle("Start", forState: UIControlState.Normal);
        }
    }
    
    @IBAction func toggleStopMotion(sender: AnyObject) {
        motionData.motionManager.stopAccelerometerUpdates();
        
        buttonStartMotion.userInteractionEnabled = false;
        buttonStartMotion.alpha = 0.4;
    }
    
    /*
    // MARK: - Event Listeners
    */
    @IBAction func takePicture(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = false
            picker.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
        }
    }
    
    
    /*
    // MARK: - Delegates
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //this stops accelerometer from running duplicates
        if(!motionData.motionManager.accelerometerActive){
            motionData.movement();
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    /*
    // MARK: - Camera Delegate Methods
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary!) {
        NSLog("Received image from camera")
        let mediaType = info[UIImagePickerControllerMediaType] as String
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        let compResult:CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        
        if ( compResult == CFComparisonResult.CompareEqualTo ) {
            
            originalImage = info[UIImagePickerControllerOriginalImage] as UIImage?
            let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary
            imageToSave = originalImage
            
            //save image
            saveToAlbum(imageToSave!)
            /*
            let library = ALAssetsLibrary()
            library.writeImageToSavedPhotosAlbum(imageToSave?.CGImage,
                metadata: metadata,
                completionBlock: nil)
            */
        }
        
        //Send image to PictureView to take care of adding points
        var pictureView = self.storyboard?.instantiateViewControllerWithIdentifier("PictureView") as PictureViewController
        pictureView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        pictureView.captureImg = imageToSave;
            picker.dismissViewControllerAnimated(true, completion: {() -> Void in
                self.presentViewController(pictureView, animated: true, completion: nil)
                }
        );
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Saves photo to "Fandom" album
    func saveToAlbum(image: UIImage) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", "Fandom")
        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        //Checks if Fandom album exists
        if let first_obj: AnyObject = collection.firstObject {
            self.albumFound = true
            self.assetCollection = collection.firstObject as PHAssetCollection
        } else {
            //if not, creates an album
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                var createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("Fandom")
                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                }, completionHandler: { success, error in
                    self.albumFound = (success ? true: false)
                    
                    if (success) {
                        var collectionFetchResult = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([self.assetCollectionPlaceholder.localIdentifier], options: nil)
                        print(collectionFetchResult)
                        NSLog("created album")
                        self.assetCollection = collectionFetchResult?.firstObject as PHAssetCollection
                    }
            })
        }
        
        //Makes a request to save the photo to the album
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            let assetPlaceholder = assetRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset)
            albumChangeRequest.addAssets([assetPlaceholder])
            }, completionHandler: { success, error in
                print("added image to album")
                print(error)
        })
        //end
    }
    

}
