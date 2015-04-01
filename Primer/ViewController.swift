//
//  ViewController.swift
//  Primer
//
//  Created by Martin Nash on 3/31/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numberFormatter = NSNumberFormatter()
    let generator = PrimeNumberGenerator()
    var currentPrimeOrdinal: Int = 0
    var timer: NSTimer!
    
    private let fadeDuration = 0.5
    private let numberDisplayDuration = 2.0

    @IBOutlet weak var resultLabel: UILabel!

    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        incrementAndUpdate()
        
        // setup timer and initial view state
        timer = NSTimer.scheduledTimerWithTimeInterval(numberDisplayDuration, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // get rid of timer
        timer.invalidate()
        timer = nil
    }
    
    

    // MARK: - Event Handling
    
    func timerFired(theTimer: NSTimer) {
        incrementAndUpdate()
    }
    
    func incrementAndUpdate() {
        currentPrimeOrdinal++
        
        // calculate the next prime number on background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let prime = self.generator.nthPrime(self.currentPrimeOrdinal)

            // update UI on main queue
            dispatch_async(dispatch_get_main_queue(), {
                self.updateUIForNumber(prime)
            })
            
        })

    }
    

    
    // MARK: - UI
    
    func updateUIForNumber(num: Int) {

        // setup new values to animate from
        resultLabel.text = numberFormatter.stringFromNumber(num)
        resultLabel.alpha = 0
        
        // create snapshot to fade out
        let oldLabel = resultLabel.snapshotViewAfterScreenUpdates(false)
        oldLabel.frame = resultLabel.frame
        view.addSubview(oldLabel)

        // perform animation
        UIView.animateWithDuration(fadeDuration, animations: {
            oldLabel.alpha = 0
            self.resultLabel.alpha = 1
        }, completion: { _ in
            oldLabel.removeFromSuperview()
        })
        
    }

    

    // MARK: - Actions
    
    @IBAction func tappedResetButton(sender: AnyObject) {
        currentPrimeOrdinal = 0
    }


}
