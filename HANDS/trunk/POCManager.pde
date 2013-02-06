///////////////////////////////////////////////////////////////////////////////////////////////////
class POCManager
{
	// NANDA lines
	ColouredRowView impairedGasExchange;
	ColouredRowView deathAnxietyView;
	ColouredRowView acutePainView;
	
	// NOC Lines
	SecondLevelRowView anxietyLevelView;
	SecondLevelRowView anxietySelfControlView;
	SecondLevelRowView painLevelView; 
	
	ThirdLevelRowView musicTherapyView;
	ThirdLevelRowView calmingTechniqueView;
	ThirdLevelRowView calmingTechniqueView_2; 
	ThirdLevelRowView spiritualSupportView;
	ThirdLevelRowView medicationManagementView;
	ThirdLevelRowView painManagementView;
	ScrollingView scrollingView;
	
	// Cycle 2
	
	// Family coping stuff
	ColouredRowView nandaInterruptedFamilyProcess;
	SecondLevelRowView nocFamilyCoping;
	ThirdLevelRowView nicFamilySupport;
	ThirdLevelRowView nicFamilyIntegrityPromotion;
	ThirdLevelRowView nicEducationEOL;

         RatingPopUpView rw;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
		mainView.subviews.add(scrollingView);

		impairedGasExchange = new ColouredRowView("Impaired Gas Exchange",firstLevelIcon);
		impairedGasExchange.iconButton.tooltipImage = IMG_IMP_GAS_EXC;
		scrollingView.subs.add(impairedGasExchange);  

		anxietyLevelView = new SecondLevelRowView("Anxiety Level",secondLevelIcon,1,5, impairedGasExchange);
		anxietyLevelView.iconButton.tooltipImage = IMG_ANXIETY_LEVEL;
		impairedGasExchange.subs.add(anxietyLevelView);

		musicTherapyView = new ThirdLevelRowView("Music Therapy", thirdLevelIcon,anxietyLevelView);
		musicTherapyView.iconButton.tooltipImage = IMG_MUSIC_THERAPY;
		anxietyLevelView.subs.add(musicTherapyView);

		calmingTechniqueView = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietyLevelView);
		calmingTechniqueView.iconButton.tooltipImage = IMG_CALMING_TECHNIQUE;
		anxietyLevelView.subs.add(calmingTechniqueView);

		deathAnxietyView = new ColouredRowView("Death Anxiety",firstLevelIcon);
		deathAnxietyView.iconButton.tooltipImage = IMG_DEATH_ANXIETY;
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView("Comfortable Death",secondLevelIcon,2,5,deathAnxietyView);
		anxietySelfControlView.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;
		deathAnxietyView.subs.add(anxietySelfControlView);

		calmingTechniqueView_2 = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietySelfControlView);
		calmingTechniqueView_2.iconButton.tooltipImage = IMG_CALMING_TECHNIQUE;
		anxietySelfControlView.subs.add(calmingTechniqueView_2);

		spiritualSupportView = new ThirdLevelRowView("Spiritual Support",thirdLevelIcon,anxietySelfControlView);
		spiritualSupportView.iconButton.tooltipImage = IMG_SPIRITUAL_SUPPORT;
		anxietySelfControlView.subs.add(spiritualSupportView);

		spiritualSupportView.addComment("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView("Acute Pain",firstLevelIcon);
		acutePainView.iconButton.tooltipImage = IMG_ACUTE_PAIN;
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView("Pain Level",secondLevelIcon,1,5,acutePainView);
		painLevelView.iconButton.tooltipImage = IMG_PAIN_LEVEL;
		acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView("Medication Management",thirdLevelIcon,painLevelView);
		medicationManagementView.iconButton.tooltipImage = IMG_MEDICATION_MANAGEMENT;
		painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView("Pain Management",thirdLevelIcon,painLevelView);
		painManagementView.iconButton.tooltipImage = IMG_PAIN_MANAGEMENT;
		painLevelView.subs.add(painManagementView);
		
		// Cycle 2 stuff
		nandaInterruptedFamilyProcess = new ColouredRowView("Interrupted Family Processes", firstLevelIcon);
		nandaInterruptedFamilyProcess.iconButton.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;

		nocFamilyCoping = new SecondLevelRowView("Family Coping", secondLevelIcon, nandaInterruptedFamilyProcess);
		nocFamilyCoping.iconButton.tooltipImage = IMG_FAMILY_COPING;
		nandaInterruptedFamilyProcess.subs.add(nocFamilyCoping);
		
		nicFamilySupport = new ThirdLevelRowView("Family Support", thirdLevelIcon, nocFamilyCoping);
		nicFamilySupport.iconButton.tooltipImage = IMG_FAMILY_SUPPORT;
		nocFamilyCoping.subs.add(nicFamilySupport);
		
		nicFamilyIntegrityPromotion = new ThirdLevelRowView("Family Integrity Promotion", thirdLevelIcon, nocFamilyCoping);
		nicFamilyIntegrityPromotion.iconButton.tooltipImage = IMG_FAMILY_INTEGRITY_PROMOTION;
		nocFamilyCoping.subs.add(nicFamilyIntegrityPromotion);
		
		nicEducationEOL = new ThirdLevelRowView("Health Education: End Of Life Process", thirdLevelIcon, nocFamilyCoping);
		nicEducationEOL.iconButton.tooltipImage = IMG_HEALTH_EDUCATION;
		nocFamilyCoping.subs.add(nicEducationEOL);



       rw = new RatingPopUpView(300,300,400,100,nocFamilyCoping);
       // mainView.subviews.add(rw);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNIC(String text, String comment,SecondLevelRowView parentNOC, PImage tooltip)
	{
		ThirdLevelRowView temp = new ThirdLevelRowView(text,thirdLevelIcon,parentNOC);
		temp.iconButton.tooltipImage = tooltip;
		if(comment.length() != 0) temp.addComment(comment);
				
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNOC.subs.add(temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNOC(String text,String comment, ColouredRowView parentNANDA, PImage tooltip)
	{
  System.out.println("Why no printing?");
		SecondLevelRowView temp = new SecondLevelRowView(text, secondLevelIcon, parentNANDA);
//SecondLevelRowView(String title,PImage logo, ColouredRowView parent)
		temp.iconButton.tooltipImage = tooltip;
		//GraphPopUpView gp = new GraphPopUpView(500, temp);
		//gp.reset(emptyTrend);
		//temp.setGraphButton(-1, emptySmallGraph, gp, 750); 
		
		if(comment.length() != 0) temp.addComment(comment);
					
		for(int k =0 ; k < parentNANDA.subs.size();k++)
		{
			SecondLevelRowView tempo = (SecondLevelRowView)parentNANDA.subs.get(k);
                       tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNANDA.subs.add(0,temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void deleteNANDA(ColouredRowView nanda)
	{
		nanda.markDeleted();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void prioritizeNANDA(ColouredRowView nanda)
	{
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(0, nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNANDA(ColouredRowView nanda)
	{
		scrollingView.subs.add(nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
