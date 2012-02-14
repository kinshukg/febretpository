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
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		scrollingView = new ScrollingView(0, 40+titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h, width, SCREEN_HEIGHT - 400);
		mainView.subviews.add(scrollingView);

		impairedGasExchange = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40,"Impaired Gas Exchange",firstLevelIcon);
		scrollingView.subs.add(impairedGasExchange);  

		anxietyLevelView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h,"Anxiety Level",secondLevelIcon,2,3,impairedGasExchange);
		impairedGasExchange.subs.add(anxietyLevelView);

		musicTherapyView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h,"Music Therapy", thirdLevelIcon);
		anxietyLevelView.subs.add(musicTherapyView);

		calmingTechniqueView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+musicTherapyView.h,"Calming Technique",thirdLevelIcon);
		anxietyLevelView.subs.add(calmingTechniqueView);

		deathAnxietyView = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+impairedGasExchange.h+anxietyLevelView.h+calmingTechniqueView.h+musicTherapyView.h,"Death Anxiety",firstLevelIcon);
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h,"Anxiety Self-Control",secondLevelIcon,5,5,deathAnxietyView);
		deathAnxietyView.subs.add(anxietySelfControlView);

		calmingTechniqueView_2 = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Calming Technique",thirdLevelIcon);
		anxietySelfControlView.subs.add(calmingTechniqueView_2);

		spiritualSupportView = new ThirdLevelRowView(0,calmingTechniqueView_2.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Spiritual Support",thirdLevelIcon);
		anxietySelfControlView.subs.add(spiritualSupportView);

		spiritualSupportView.comments.add("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView(0,  50+calmingTechniqueView_2.h+spiritualSupportView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+calmingTechniqueView.h+musicTherapyView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h,"Acute Pain",firstLevelIcon);
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h, "Pain Level",secondLevelIcon,1,5,acutePainView);
		acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Medical Management",thirdLevelIcon);
		painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView(0, 50+medicationManagementView.h+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Pain Management",thirdLevelIcon);
		painLevelView.subs.add(painManagementView);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNIC(String text, String comment,SecondLevelRowView parentNOC)
	{
		ThirdLevelRowView temp = new ThirdLevelRowView(0, parentNOC.y+parentNOC.h,text,thirdLevelIcon);
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                        tempo.comments.add(comment);
			tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNOC.subs.add(0,temp);
		scrollingView.rearrange();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNOC(String text,String comment, ColouredRowView parentNANDA)
	{
		SecondLevelRowView temp = new SecondLevelRowView(0, parentNANDA.y+parentNANDA.h, text, secondLevelIcon, 0, 0, parentNANDA);
		for(int k =0 ; k < parentNANDA.subs.size();k++)
		{
			SecondLevelRowView tempo = (SecondLevelRowView)parentNANDA.subs.get(k);
                        tempo.comment = comment;
			tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNANDA.subs.add(0,temp);
		pocManager.scrollingView.rearrange();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
