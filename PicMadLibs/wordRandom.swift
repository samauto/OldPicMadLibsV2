//
//  wordRandom.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation

extension PML_FormController{
    
    @IBAction func generateRandom(sender: AnyObject) {
        nounInput.text = randomWordGenerator("Noun")
        verbInput.text = randomWordGenerator("Verb")
        adverbInput.text = randomWordGenerator("Adverb")
        adjectiveInput.text = randomWordGenerator("Adjective")
    
    }
    //END OF FUNC: generateRandom
    
    
    func randWordGenButt(){
        if (nounInput.text == "") {
            nounInput.text = randomWordGenerator("Noun")
        }
    
        if (verbInput.text == "") {
            verbInput.text = randomWordGenerator("Verb")
        }
    
        if (adverbInput.text == "") {
            adverbInput.text = randomWordGenerator("Adverb")
        }
    
        if (adjectiveInput.text == "") {
            adjectiveInput.text = randomWordGenerator("Adjective")
        }
    }
    // END OF FUNC: randWordGenButt

    
    func randomWordGenerator(typeword: String) -> String {
        var randword=""
        var wordArray:[String]
    
        if (typeword == "Noun") {
            wordArray = WordConstants.NounInfo.wordExamples
        }
        
        else if (typeword == "Verb") {
            wordArray = WordConstants.VerbInfo.wordExamples
        }
        
        else if (typeword == "Adverb") {
            wordArray = WordConstants.AdverbInfo.wordExamples
        }
        
        else {
            wordArray = WordConstants.AdjectiveInfo.wordExamples
        }
    
    let wordCnt = wordArray.count
    let wrdRand = Int(arc4random_uniform(UInt32(wordCnt)))
    randword = wordArray[wrdRand]
    
    return randword
    
    }
    //END OF FUNC: randomWord

}
//END OF EXTENSION: wordRandom