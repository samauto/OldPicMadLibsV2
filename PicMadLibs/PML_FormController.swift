//
//  ViewController.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PML_FormController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate   {

    
    // MARK: PROPERTIES

    // MARK: NOUN
    @IBOutlet weak var nounInfo: UIButton!
    @IBOutlet weak var nounInput: UITextField!
    
    // MARK: VERB
    @IBOutlet weak var verbInfo: UIButton!
    @IBOutlet weak var verbInput: UITextField!
    
    // MARK: ADVERB
    @IBOutlet weak var adverbInfo: UIButton!
    @IBOutlet weak var adverbInput: UITextField!
    
    // MARK: ADJECTIVE
    @IBOutlet weak var adjectiveInfo: UIButton!
    @IBOutlet weak var adjectiveInput: UITextField!
    
    // MARK: GENERATE
    @IBOutlet weak var generatePicMadLib: UIButton!
    @IBOutlet weak var generateRandom: UIBarButtonItem!
    
    // MARK: MESSAGE
    @IBOutlet weak var formMessage: UILabel!
    
    var madList: MadLib?
    
    
    // MARK: VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        formMessage.hidden = true

        // Set up views if editing an existing Meal.
        if let madList = madList {
            navigationItem.title = madList.madlibID as String
            nounInput.text = madList.nouns as String
            verbInput.text = madList.verbs as String
            adverbInput.text = madList.adverbs as String
            adjectiveInput.text = madList.adjectives as String
            generatePicMadLib.setTitle("UPDATE", forState: UIControlState.Normal)
        }

    }//END OF FUNC: viewDidLoad

    
    // MARK: CORE DATA ShareContext
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    // MARK: ACTION
    
    @IBAction func AdjectiveHelp(sender: AnyObject) {
        let whatisAdjective = "Adjectives describe, or modify, nouns and pronouns.\n"
        let exAdjective = "\n\nExample of Adjective:\n\n"+"THE WISE HANDSOME owl had ORANGE eyes\n";
        let adjectiveAlert = UIAlertController (title: "WHAT IS AN ADJECTIVE?\n",
            message: whatisAdjective+exAdjective, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        adjectiveAlert.addAction(closeAction)
        self.presentViewController(adjectiveAlert, animated: true, completion: nil)
        
    }// END OF ADJECTIVE HELP
    
    @IBAction func AdverbHelp(sender: AnyObject) {
        let whatisAdverb = "Adverbs modify verbs, adjectives and other adverbs.\n"
        let exAdverb = "\n\nExample of Adverbs:\n\n"+"the EXTREMELY cute kola hugged its mom VERY TIGHTLY\n";
        let adverbAlert = UIAlertController (title: "WHAT IS AN ADVERB?\n",
            message: whatisAdverb+exAdverb, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        adverbAlert.addAction(closeAction)
        self.presentViewController(adverbAlert, animated: true, completion: nil)
        
    }// END OF ADVERB HELP
    
    @IBAction func VerbHelp(sender: AnyObject) {
        let whatisVerb = "The verb signals an action, an occurance, or a state of being. Whether mental, physical, or mechanical, verbs always express activity.\n"
        let exVerb = "\n\nExample of Verbs:\n\n"+"the shuttle FLEW into space\n"
        let verbAlert = UIAlertController (title: "WHAT IS A VERB?\n",
            message: whatisVerb+exVerb, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        verbAlert.addAction(closeAction)
        self.presentViewController(verbAlert, animated: true, completion: nil)
        
    }// END OF VERB HELP
    
    @IBAction func NounHelp(sender: AnyObject) {
        let whatisNoun = "A noun is a word that identifies a person, animal, place, thing, or idea."
        let exNoun = "\n\nExample of Nouns:\n\n"+"a PEACOCK walked through our YARD\n"
        let nounAlert = UIAlertController (title: "WHAT IS A NOUN?\n",
            message: whatisNoun+exNoun, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        nounAlert.addAction(closeAction)
        self.presentViewController(nounAlert, animated: true, completion: nil)
        
    }// END OF NOUN HELP
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        let isPresentingInAddMadLibMode = presentingViewController is UINavigationController

        if isPresentingInAddMadLibMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }//END OF FUNC cancelPressed
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //DEBUG print("SENDER",sender!)
        let madlibDetail = segue.destinationViewController as! PML_ResultsController
        if (generatePicMadLib === sender) || (generateRandom === sender) {
            
            
            let randID = Int(arc4random_uniform(1000000) + 1)
            let tempID = "PicMadLib"+String(randID)
            
            if (nounInput.text == "") {
                nounInput.text = randomWord("Noun")
            }
           
            if (verbInput.text == "") {
                verbInput.text = randomWord("Verb")
            }
            
            if (adverbInput.text == "") {
                adverbInput.text = randomWord("Adverb")
            }
            
            if (adjectiveInput.text == "") {
                adjectiveInput.text = randomWord("Adjective")
            }
            
            //Add the new or updated MadLib to the List
            madList = MadLib(madID: tempID, noun: self.nounInput.text!, verb: self.verbInput.text!, adverb: self.adverbInput.text!, adjective: self.adjectiveInput.text!, context: self.sharedContext)
            CoreDataStackManager.sharedInstance().saveContext()
            
            self.findPhotos(madList!, noun: self.nounInput.text!,  verb: self.verbInput.text!,  adverb: self.adverbInput.text!,  adjective: self.adjectiveInput.text!)
        }
        
    }//END OF FUNC: prepareForSeque
    
    
    @IBAction func generatePressed(sender: AnyObject) {
    }//END OF FUNC: generatePressed
    
    @IBAction func generateRandom(sender: AnyObject) {
            nounInput.text = randomWord("Noun")
            verbInput.text = randomWord("Verb")
            adverbInput.text = randomWord("Adverb")
            adjectiveInput.text = randomWord("Adjective")
        
    }//END OF FUNC: generateRandom
    

    func randomWord(typeword: String) -> String {
        var randword=""
        var wordArray:[String]
    
        if (typeword == "Noun") {
            wordArray = ["people","history","way","art","world","information","map","two","family","government","health","system","computer","meat","year","thanks","music","person","reading","method","data","food","understanding","theory","law","bird","literature","problem","software","control","knowledge","power","ability","economics","love","internet","television","science","library","nature","fact","product","idea","temperature","investment","area","society","activity","story","industry","media","thing","oven","community","definition","safety","quality","development","language","management","player","variety","video","week","security","country","exam","movie","organization","equipment","physics","analysis","policy","series","thought","basis","boyfriend","direction","strategy","technology","army","camera","freedom","paper","environment","child","instance","month","truth","marketing","university","writing","article","department","difference","goal","news","audience","fishing","growth","income","marriage","user","combination","failure","meaning","medicine","philosophy","teacher","communication","night","chemistry","disease","disk","energy","nation","road","role","soup","advertising","location","success","addition","apartment","education","math","moment","painting","politics","attention","decision","event","property","shopping","student","wood","competition","distribution","entertainment","office","population","president","unit","category","cigarette","context","introduction","opportunity","performance","driver","flight","length","magazine","newspaper","relationship","teaching","cell","dealer","finding","lake","member","message","phone","scene","appearance","association","concept","customer","death","discussion","housing","inflation","insurance","mood","woman","advice","blood","effort","expression","importance","opinion","payment","reality","responsibility","situation","skill","statement","wealth","application","city","county","depth","estate","foundation","grandmother","heart","perspective","photo","recipe","studio","topic","collection","depression","imagination","passion","percentage","resource","setting","ad","agency","college","connection","criticism","debt","description","memory","patience","secretary","solution","administration","aspect","attitude","director","personality","psychology","recommendation","response","selection","storage","version","alcohol","argument","complaint","contract","emphasis","highway","loss","membership","possession","preparation","steak","union","agreement","cancer","currency","employment","engineering","entry","interaction","mixture","preference","region","republic","tradition","virus","actor","classroom","delivery","device","difficulty","drama","election","engine","football","guidance","hotel","owner","priority","protection","suggestion","tension","variation","anxiety","atmosphere","awareness","bath","bread","candidate","climate","comparison","confusion","construction","elevator","emotion","employee","employer","guest","height","leadership","mall","manager","operation","recording","sample","transportation","charity","cousin","disaster","editor","efficiency","excitement","extent","feedback","guitar","homework","leader","mom","outcome","permission","presentation","promotion","reflection","refrigerator","resolution","revenue","session","singer","tennis","basket","bonus","cabinet","childhood","church","clothes","coffee","dinner","drawing","hair","hearing","initiative","judgment","lab","measurement","mode","mud","orange","poetry","police","possibility","procedure","queen","ratio","relation","restaurant","satisfaction","sector","signature","significance","song","tooth","town","vehicle","volume","wife","accident","airport","appointment","arrival","assumption","baseball","chapter","committee","conversation","database","enthusiasm","error","explanation","farmer","gate","girl","hall","historian","hospital","injury","instruction","maintenance","manufacturer","meal","perception","pie","poem","presence","proposal","reception","replacement","revolution","river","son","speech","tea","village","warning","winner","worker","writer","assistance","breath","buyer","chest","chocolate","conclusion","contribution","cookie","courage","dad","desk","drawer","establishment","examination","garbage","grocery","honey","impression","improvement","independence","insect","inspection","inspector","king","ladder","menu","penalty","piano","potato","profession","professor","quantity","reaction","requirement","salad","sister","supermarket","tongue","weakness","wedding","affair","ambition","analyst","apple","assignment","assistant","bathroom","bedroom","beer","birthday","celebration","championship","cheek","client","consequence","departure","diamond","dirt","ear","fortune","friendship","funeral","gene","girlfriend","hat","indication","intention","lady","midnight","negotiation","obligation","passenger","pizza","platform","poet","pollution","recognition","reputation","shirt","sir","speaker","stranger","surgery","sympathy","tale","throat","trainer","uncle","youth"]
        }
            
        else if (typeword == "Verb") {
            wordArray = ["is","are","has","get","see","need","know","would","find","take","want","does","learn","become","come","include","thank","provide","create","add","understand","consider","choose","develop","remember","determine","grow","allow","supply","bring","improve","maintain","begin","exist","tend","enjoy","perform","decide","identify","continue","protect","require","occur","write","approach","avoid","prepare","build","achieve","believe","receive","seem","discuss","realize","contain","follow","refer","solve","describe","prefer","prevent","discover","ensure","expect","invest","reduce","speak","appear","explain","explore","involve","lose","afford","agree","hear","remain","represent","apply","forget","recommend","rely","vary","generate","obtain","accept","communicate","complain","depend","enter","happen","indicate","suggest","survive","appreciate","compare","imagine","manage","differ","encourage","expand","prove","react","recognize","relax","replace","borrow","earn","emphasize","enable","operate","reflect","send","anticipate","assume","engage","enhance","examine","install","participate","intend","introduce","relate","settle","assure","attract","distribute","overcome","owe","succeed","suffer","throw","acquire","adapt","adjust","argue","arise","confirm","encouraging","incorporate","justify","organize","ought","possess","relieve","retain","shut","calculate","compete","consult","deliver","extend","investigate","negotiate","qualify","retire","rid","weigh","arrive","attach","behave","celebrate","convince","disagree","establish","ignore","imply","insist","pursue","remaining","specify","warn","accuse","admire","admit","adopt","announce","apologize","approve","attend","belong","commit","criticize","deserve","destroy","hesitate","illustrate","inform","manufacturing","persuade","pour","propose","remind","shall","submit","suppose","translate"]
        }
        
        else if (typeword == "Adverb") {
            wordArray = ["not","also","very","often","however","too","usually","really","early","never","always","sometimes","together","likely","simply","generally","instead","actually","again","rather","almost","especially","ever","quickly","probably","already","below","directly","therefore","else","thus","easily","eventually","exactly","certainly","normally","currently","extremely","finally","constantly","properly","soon","specifically","ahead","daily","highly","immediately","relatively","slowly","fairly","primarily","completely","ultimately","widely","recently","seriously","frequently","fully","mostly","naturally","nearly","occasionally","carefully","clearly","essentially","possibly","slightly","somewhat","equally","greatly","necessarily","personally","rarely","regularly","similarly","basically","closely","effectively","initially","literally","mainly","merely","gently","hopefully","originally","roughly","significantly","totally","twice","elsewhere","everywhere","obviously","perfectly","physically","successfully","suddenly","truly","virtually","altogether","anyway","automatically","deeply","definitely","deliberately","hardly","readily","terribly","unfortunately","forth","briefly","moreover","strongly","honestly","previously"]
        }
            
        else {
            wordArray =
                ["bitter","lemon-flavored","spicy","bland","minty","sweet","delicious","pickled","tangy","fruity","salty","tasty","gingery","sour","yummy","auricular","fluffy","sharp","boiling","freezing","silky","breezy","fuzzy","slick","bumpy","greasy","slimy","chilly","hard","slippery","cold","hot","smooth","cool","icy","soft","cuddly","loose","solid","damaged","melted","steady","damp","painful","sticky","dirty","plastic","tender","dry","prickly","tight","dusty","rough","uneven","filthy","shaggy","warm","flaky","shaky","wet","blaring","melodic","screeching","deafening","moaning","shrill","faint","muffled","silent","hoarse","mute","soft","high-pitched","noisy","squealing","hissing","purring","squeaking","hushed","quiet","thundering","husky","raspy","voiceless","loud","resonant","whispering","azure","gray","pinkish","black","green","purple","blue","indigo","red","bright","lavender","rosy","brown","light","scarlet","crimson","magenta","silver","dark","multicolored","turquoise","drab","mustard","violet","dull","orange","white","gold","pink","yellow","abundant","jumbo","puny","big-boned","large","scrawny","chubby","little","short","fat","long","small","giant","majestic","tall","gigantic","mammoth","teeny","great","massive","thin","huge","miniature","tiny","immense","petite","vast","blobby","distorted","rotund","broad","flat","round","chubby","fluffy","skinny","circular","globular","square","crooked","hollow","steep","curved","low","straight","cylindrical","narrow","triangular","deep","oval","wide","annual","futuristic","rapid","brief","historical","regular","daily","irregular","short","early","late","slow","eternal","long","speed","fast","modern","speedy","first","old","swift","fleet","old-fashioned","waiting","future","quick","young","all","heavy","one","ample","hundreds","paltry","astronomical","large","plentiful","bountiful","light","profuse","considerable","limited","several","copious","little","sizable","countless","many","some","each","measly","sparse","enough","mere","substantial","every","multiple","teeming","few","myriad","ten","full","numerous","very","abrasive","embarrassed","grumpy","abrupt","energetic","kind","afraid","enraged","lazy","agreeable","enthusiastic","lively","aggressive","envious","lonely","amiable","evil","lucky","amused","excited","mad","angry","exhausted","manic","annoyed","exuberant","mysterious","ashamed","fair","nervous","bad","faithful","obedient","bitter","fantastic","obnoxious","bewildered","fierce","outrageous","boring","fine","panicky","brave","foolish","perfect","callous","frantic","persuasive","calm","friendly","pleasant","calming","frightened","proud","charming","funny","quirky","cheerful","furious","relieved","combative","gentle","repulsive","comfortable","glib","rundown","defeated","glorious","sad","confused","good","scary","cooperative","grateful","selfish","courageous","grieving","silly","cowardly","gusty","splendid","crabby","gutless","successful","creepy","happy","tedious","cross","healthy","tense","cruel","heinous","terrible","dangerous","helpful","thankful","defeated","helpless","thoughtful","defiant","hilarious","thoughtless","delightful","homeless","tired","depressed","hungry","troubled","determined","hurt","upset","disgusted","immoral","weak","disturbed","indignant","weary","eager","irate","wicked","elated","itchy","worried","embarrassed","jealous","zany","enchanting","jolly","zealous","aggressive","famous","restless","agoraphobic","fearless","rich","ambidextrous","fertile","righteous","ambitious","fragile","ritzy","amoral","frank","romantic","angelic","functional","rustic","brainy","gabby","ruthless","breathless","generous","sassy","busy","gifted","secretive","calm","helpful","sedate","capable","hesitant","shy","careless","innocent","sleepy","cautious","inquisitive","somber","cheerful","insane","stingy","clever","jaunty","stupid","common","juicy","super","complete","macho","swanky","concerned","manly","tame","crazy","modern","tawdry","curious","mushy","terrific","dead","naughty","testy","deep","odd","uninterested","delightful","old","vague","determined","open","verdant","different","outstanding","vivacious","diligent","perky","wacky","energetic","poor","wandering","erratic","powerful","wild","evil","puzzled","womanly","exuberant","real","wrong","ablaze","distinct","quirky","adorable","drab","ruddy","alluring","dull","shiny","attractive","elegant","skinny","average","embarrassed","sloppy","awkward","fancy","smiling","balanced","fat","sparkling","beautiful","filthy","spotless","blonde","glamorous","strange","bloody","gleaming","tacky","blushing","glossy","tall","bright","graceful","thin","clean","grotesque","ugly","clear","handsome","unattractive","cloudy","homely","unbecoming","clumsy","interior","uncovered","colorful","lovely","unsightly","confident","magnificent","unusual","cracked","murky","watery","crooked","old-fashioned","weird","crushed","plain","wild","curly","poised","wiry","cute","pretty","wooden","debonair","puffy","worried","dirty","quaint","zaftig","accidental","doubtful","main","achievable","elementarty","minor","advantageous","finger-printed","nasty","alcoholic","groundless","nutritious","animated","hard","obsolete","aquatic","harmful","optimal","aromatic","high","organic","aspiring","honest","premium","bad","horrible","quizzical","bawdy","illegal","rainy","biographical","illegible","redundant","bizarre","imperfect","remarkable","broken","impossible","simple","careful","internal","tangible","credible","inventive","tricky","creepy","jazzy","wholesale","cumbersome","juvenile","worse","disastrous","legal","wry","dismissive","logical","x-rated"]
        }
 
        let wrdCnt = wordArray.count
        let wrdRand = Int(arc4random_uniform(UInt32(wrdCnt)))
        randword = wordArray[wrdRand]
        return randword
        
    }//END OF FUNC: randomWord


    func findPhotos(madlib: MadLib, noun: String, verb: String, adverb: String, adjective: String) {
        
        FlickrAPI.sharedInstance().getPhotos(madlib, word: noun, type: "noun") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    print("Error can't find find Photos via Flickr")
                }
            }
        }
            
        FlickrAPI.sharedInstance().getPhotos(madlib, word: verb, type: "verb") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    print("Error can't find find Photos via Flickr")
                }
            }
        }
        
        FlickrAPI.sharedInstance().getPhotos(madlib, word: adverb, type: "adverb") { (success, results, errorString) in
                if success == false {
                    performOnMain {
                        print("Error can't find find Photos via Flickr")
                }
            }
        }
        
        FlickrAPI.sharedInstance().getPhotos(madlib, word: adjective, type: "adjective") { (success, results, errorString) in
                if success == false {
                    performOnMain {
                        print("Error can't find find Photos via Flickr")
                }
            }
        }
        
    }//END OF FUNC: findPhotos
    
}//END OF CLASS: PML_FormController

