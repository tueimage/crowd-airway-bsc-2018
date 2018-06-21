# Weekly meetings

Copy/paste and fill in the template below each week (most recent date on top, template at the bottom), commit and push your changes BEFORE coming to the weekly meeting with your supervisor.    
### Date: 11/06/2018

#### What did you achieve this week?
* Verslag afgeschreven met name resultaten en discussie
* Feedback verwerkt, heel bruikbaar allemaal!

#### What did you struggle with?
* 

#### What would you like to work on next week?
* Github project page nalopen zodat alles wat op de planning stond/ niet vergeten moest worden ook echt gedaan is. 
* Code nalopen

#### Where do you need help?
* Ik begreep de comment bij de onderzoeksvraag (inleiding) niet helemaal, dus hier in ieder geval even naar kijken.
* Abstract doorlezen.


#### Any other topic
* Hoe zit het met het inleveren van scripts?  --(github error nog oplossen met weekly meetings)
* Zijn de bronnen die in de tekst aangehaald nu juist? Bron direct 'na et al.'.
* Gebruik van afkortingen zoals KW etc, moet je die in de discussie nog eens volledig uitschrijven?
* Is het afwisselen van afkortingen met volledige uitdrukking storend en dus constant met een werken? 
* Moeten de vergelijkingen genummerd worden, maar in principe refereer ik nergens terug.
* Active voice nog meer gebruiken of alleen op punten waar het anders onnatuurlijk overkomt?   -our paper
* Mag je zinnen beginnen met 'But'? 


### Date: 11/06/2018

#### What did you achieve this week?
* I generated tables of which subjects had what amount of data on which point, e.g. 66 image slices were initially taken from subject ID 21. After filtering 53 image slices had one or more usable annotations. So, 19.7% of the images were discarded based on the filter criteria. 
A total of 53*20=1060 annotations were performed by the crowds on the slices that had usable annotations. But 497 annotations on those image slices were usable. 62.3% of all annotations of this subject's slices were discarded. Irrespective of the amount of image slices, the % of discarded annotations of all subjects was between 54.6 and 76.1. 
* Related work section
* Revised the introduction

#### What did you struggle with?
* I've invested a lot of time in the introduction, but it still seems to be incoherent in some way.  
* Sorting the boxes in the boxplot at which i didn't succeed.

#### What would you like to work on next week?
* First of all, I'd  like to make sure that there is a paper to hand in. 
* MAPE showed that outer area error is generally smaller than the inner area error. So based on this: investigate whether this depends on the size of the area or on the type of area. 
* MAPE smallest and largest airway per subject.   

#### Where do you need help?
* Is the related work section, kind of what is expected in a research paper?
* Sorting the boxplots would be great, since all data is divided in a CF and a healthy group.

#### Any other topic
* 

### Date: 04/06/2018

#### What did you achieve this week?
* Rewrote some scripts
* Clarified goal of function incl. read me
* Wrote on the report
* Retrieved some additional numbers

#### What did you struggle with?
* The structure of the paper.  

#### What would you like to work on next week?
* I want to know whether some subjects had almost no usable annotations
* The effect of the amount of usable annotations representing the crowd on the correlation coefficient.  

#### Where do you need help?
* One reference won't work with bibtex


#### Any other topic
* 

### Date: 28/05/2018

#### What did you achieve this week?
* Implemented wall area percentage to capture outer area and inner area in one parameter. The mean-WAP of the annotations and the tasks of one subject were determined.
* A figure with boxplots of the mean-WAP of the KW's over all healthy subjects, the mean-WAP of the KW's over all CF subjects and the same for the expert (Wieying).
* Computed the Mann-Whitney U test (which was done in an article), but the healthy and cf subjects didn't differ significantly (p>0.05) for both expert and kw.
* Mean absolute percentage error of all annotations as metric 
* Largest and smallest airway according to the experts data of the outerairway
* Had a look at overleaf
 
#### What did you struggle with?
* Some scripts and names of workspace variables are not clear enough, spend a lot of time organizing my thought instead of writing the 'read me'
* I want to do a lot, but I don't really finish anything. 

#### What would you like to work on next week?
* Use relative differences as a metric 
* Integrate the amount of annotations
* Write methods and discussion (so far) in article style


#### Where do you need help?
*


#### Any other topic
*

### Date: 21/05/2018

#### What did you achieve this week?
*Created 'separatingTasks.m' that creates the cell indexResultsTask in which the annotations of each task are organized. 
*Created 'boxplotGeneral.m' that can be used as draft for the boxplots that will be made. 
*Created 'selectTasksBasedOnCFStatus.m' which intends to select the tasks based on the CF status. The output can be used as input for boxplotGeneral.m. However, this script is not complete/correct. 

#### What did you struggle with?
*First I struggled with grouping the boxplots, but this is solved. 
*I need to select all the tasks of the patients with or without CF, but the script only selects 12 tasks in total. So, for each patient one task, but there should be more tasks/patient. 


#### What would you like to work on next week?
*I would like to provide more insight into the actual CF/ no-CF relation. 
*To work out the plan with p-values et cetera. 
*Have a look at overleaf

#### Where do you need help?
*No help needed at the moment, I first need to elaborate my plan. 


#### Any other topics
*



### Date: 14/05/2018

#### What did you achieve this week?
* Deelvragen bedacht waardoor ik in principe ze nu stap voor stap kan afwerken. 
* Scatterplot gemaakt waarin iedere gewenste task een andere kleur heeft en waarin zowel inner als outer area van elke overgebleven annotatie na filteren te zien is waarbij expert en KW's tegen elkaar uitstaat. 
* Scatterplot outer vs. inner area van de KW annotaties, met elke task een andere kleur. Hierin valt op dat wanneer er een grotere area geannoteerd wordt dat hierbij grotere verschillen te zien zijn tussen de KW's. 
Daarnaast zie je dat er ook een groot aantal annotaties zijn met exact dezelfde oppervlakte, dit zal betekenen dat de 'basis' ellips niet veranderd is door de KW en dat wellicht de annotatie minder realistisch is.
* Teksten gelezen over statestiek, maar hier niet veel wijzer uit geworden.

#### What did you struggle with?
* Wanneer ik een plotje heb gemaakt, ben ik blij dat dat gelukt is. Maar uiteindelijk heeft zulk werk alleen waarde als het iets toevoegd of wanneer je er iets zinnigs over kunt zeggen.
Dus hierbij zal iets van statestiek nodig zijn of een andere maat om te kwantificeren. Met die stap die dus volgt heb ik moeite en weet ik niet hoe ik dat kan aanpakken.
* Heb het gevoel dat ik meer met losse flodders bezig ben, dus te werk ga zonder iets concreets (af) te maken.  
* Ik wilde iets met geslacht onderzoeken, maar kon deze parameter niet vinden en later bedacht ik mij ook dat dit helemaal niet handig of interessant is.

#### What would you like to work on next week?

* Volgende week zou ik graag data willen analyseren waarbij er ook echt getalwaarden uitkomen.
* Gelijktijdig netjes documenteren waarmee ik bezig ben. 
  

#### Where do you need help?

* Mening en idee??n over nieuwe onderzoeksvraag/ deelvragen
* Tips voor statistische onderbouwing / wat voor een methoden zijn er om data te analyseren. 


#### Any other topics

* Combineren van annotaties denk ik dat ik voorlopig gewoon via median laat. 



### Date: 07/05/2018

#### What did you achieve this week?

* Read multiple articles to get an understanding of crowdsourcing.
* Described a problem definition
* Created some milestones
* Tried to understand the scripts that I've got
* Created scatterplots of inner or outer area's of expert's and KW's annotations combined by median.
	* Added an gtTablePerTask as output of 'viewAndProcessResults.m' which is needed when only one annotation per task is analyzed. 
	* Created 'scatterplotPerImage.m' this script first filters the results of the knowledge workers and only keeps those with 2 annotations performed that were classified as usefull. 
	  Then it combines the expert's data and also the knowledge worker's data. The median area's of those groups will be visualized in a scatterplot.

#### What did you struggle with?

* To know where to start and what to look for.
* It took quite some time to get an create an overall picture of the data (e.g. which data is used and where to find the data) and to keep this overview clear.
* Working in an efficient way.

#### What would you like to work on next week?

* Add airway properties (wall thickness, wall thickness ratio)
* I'd like to find usefull articles on the defined problem.
* More specific work on the problem/ to work towards clearly defined milestones. 
 

#### Where do you need help?

* You suggested to think about other analyses that could be done. Did you mean something like wall thickness or ratio's or a kind of statistical analyse


#### Any other topics

* I thought this might be an interesting article, but I don't have access to it.  

Nowak, S., R??ger, S.
How reliable are annotations via crowdsourcing? A study about inter-annotator agreement for
multi-label image annotation
(2010) MIR 2010 - Proceedings of the 2010 ACM SIGMM International Conference on Multimedia
Information Retrieval, pp. 557-566. Cited 122 times.
DOI: 10.1145/1743384.1743478

* 'Solved' the merge problem by manually changing the additions in my local files. Don't know yet if this will give problems when pushing my files to github.
* When is the deadline of the paper?
* Is it okay if all issues, planning etc. on github are in dutch?  





### Credit
This template is partially derived from "Whitaker Lab Project Management" by Dr. Kirstie Whitaker and the Whitaker Lab team, used under CC BY 4.0. 
