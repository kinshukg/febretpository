class RatingPopUpView extends PopUpViewBase
{
	PImage indicatorsImage;
	
	PopUpSection expectedRatingSection;
	PopUpSection currentRatingSection;

	ArrayList<CheckBox> currentRatings;
	ArrayList<CheckBox> expectedRatings;
	
	////////////////////////////////////////////////////////////////////////////
	RatingPopUpView(SecondLevelRowView parent, PImage image)
	{
		super(image.width > 650 ? image.width +50 : 700, parent);
		
		indicatorsImage = image;
		
		currentRatings = new ArrayList<CheckBox>();
		expectedRatings = new ArrayList<CheckBox>();
	}
	
	////////////////////////////////////////////////////////////////////////////
    void initRatingList(PopUpSection section, ArrayList<CheckBox> ratings)
    {
		for(int i = 1; i <= 5; i++)
		{
            String name = str(i) + ": ";
            
            if(parent.title == "Bowel Elimination" ||
                parent.title == "Comfortable Death" ||
                parent.title == "Mobility" ||
                parent.title == "Medication Response" ||
                parent.title == "Tissue Integrity Skin and Mucous Membranes" ||
                parent.title == "Hydration")
            {
                if(i == 1) name = name + "Severely compromised";
                else if(i == 2) name = name + "Substantially compromised";
                else if(i == 3) name = name + "Moderately compromised";
                else if(i == 4) name = name + "Mildly compromised";
                else if(i == 5) name = name + "Not compromised";
            }
            else if(parent.title == "Respiratory Status: Gas Exchange")
            {
                if(i == 1) name = name + "Severe deviation from normal range";
                else if(i == 2) name = name + "Substantial deviation from normal range";
                else if(i == 3) name = name + "Moderate deviation from normal range";
                else if(i == 4) name = name + "Mild deviation from normal range";
                else if(i == 5) name = name + "No deviation from normal range";
            }
            else if(parent.title == "Coping" ||
                    parent.title == "Family Coping" ||
                    parent.title == "Nausea and Vomiting Control" ||
                    parent.title == "Grief Resolution")
            {
                if(i == 1) name = name + "Never demonstrated";
                else if(i == 2) name = name + "Rarely demonstrated";
                else if(i == 3) name = name + "Sometimes demonstrated";
                else if(i == 4) name = name + "Often demonstrated";
                else if(i == 5) name = name + "Consistently demonstrated";
            }
            else
            {
                if(i == 1) name = name + "Severe";
                else if(i == 2) name = name + "Substantial";
                else if(i == 3) name = name + "Moderate";
                else if(i == 4) name = name + "Mild";
                else if(i == 5) name = name + "None";
            }
            
			CheckBox ratingCheckbox = new CheckBox(name, null, 0);
			section.addAction(ratingCheckbox);
			ratingCheckbox.radio = true;
			ratingCheckbox.textBoxEnabled = false;
			ratingCheckbox.w = 80;
			ratings.add(ratingCheckbox);
		}
		subviews.add(section);
    }
    
	////////////////////////////////////////////////////////////////////////////
	void reset()
	{
        // Add title + NNN icon to both native and CDS-based prototypes.
		//if(!OPTION_NATIVE)
		{
            PopUpSection title = new PopUpSection("");
            title.titleBox.setText("\n </b>   <h>  <- Click NOC icon for definition </h> \n" + " <h1> <b> " + parent.title + "\n");
            title.titleButtonMode = 1;
            title.titleButton = new Button(5, 16, 28, 28, secondLevelIcon);
            title.titleButton.tooltipOffsetX = - (indicatorsImage.width + 40);
            title.titleButton.tooltipImage = indicatorsImage;
            title.subviews.add(title.titleButton);
            subviews.add(title);
        }
		
		// Expected rating checkboxes
		expectedRatingSection = new PopUpSection("Expected Rating:");
		expectedRatingSection.layoutHorizontal = false;
		currentRatingSection = new PopUpSection("Current Rating:");
		currentRatingSection.layoutHorizontal = false;
        //expectedRatingSection.w = 600;

        initRatingList(expectedRatingSection, expectedRatings);
        initRatingList(currentRatingSection, currentRatings);
		
		// String expectedRatingTutorial =
			// "Setting an Expected NOC Rating: <l> \n " +
			// "1. <h> Review definition of <b> NOC </h> : " + parent.title + " </b> and current patient status. \n " +
			// "2. Identify the patient's expected rating where a rating of 5 is comparable to a healthy patient of similar age, gender, and cognition. \n " +
			// "3. Select a rating (1-5) that best represents patient's expected status at discharge from the unit. \n ";
			
		// String currentRatingTutorial =
			// "Setting a Current NOC Rating: <l> \n " +
			// "1. Review definition of <b> NOC: " + parent.title + " </b> and current patient status. \n " +
			// "2. Identify the patient's expected rating where a rating of 5 is comparable to a healthy patient of similar age, gender, and cognition. \n " +
			// "3. Select a rating (1-5) that best represents patient's expected status at the end of every shift. \n ";
		
		String expectedRatingTutorial =
			"<b> Rules for Setting an Expected NOC Rating: </b> <l> \n " +
			"1. Review the NOC <h> <b> Definition </b> </h> \n " +
			"2. Review the NOC <h> <b> Indicators </b> </h> \n " +
			"3. Select NOC rating (1-5) expected of patient at discharge from your unit <s1> \n " +
			"<s1> Consider <b> 5 </b> to be the rating that one would assign to a comparable healthy person (e.g. same age, mental capacity, gender) and <b> 1 </b> to be the lowest. \n " +
			"<s1> Please note that a 5 is <b> NOT </b> always a realistic discharge rating \n ";
			
		String currentRatingTutorial =
			"<b> Rules for Setting a Current NOC Rating: </b> <l> \n " +
			"1. Review the NOC <h> <b> Definition </b> </h> \n " +
			"2. Review the NOC <h> <b> Indicators </b> </h> \n " +
			"3. Select NOC rating (1-5) that reflects the patient current status <s1> \n " +
			"<s1> Consider <b> 5 </b> to be the rating that one would assign to a comparable healthy person (e.g. same age, mental capacity, gender) and <b> 1 </b> to be the lowest. \n ";
			
		if(!OPTION_NATIVE)
		{
            expectedRatingSection.setDescription(expectedRatingTutorial);
            currentRatingSection.setDescription(currentRatingTutorial);
            //expectedRatingSection.setInfoButton(expectedRatingTutorial);
            //currentRatingSection.setInfoButton(currentRatingTutorial);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
		for(int i = 1; i <= 5; i++)
		{
			CheckBox cb = currentRatings.get(i - 1);
			if(cb.selected)
			{
                if(parent.currentRatingButton != null)
                {
                    parent.currentRatingButton.t = str(i);
                }
                else
                {
                    parent.firstColumn = i;
                }
                log("NOCCurrentRating " + str(i) + " " + parent.title);
				break;
			}
		}
		for(int i = 1; i <= 5; i++)
		{
			CheckBox cb = expectedRatings.get(i - 1);
			if(cb.selected)
			{
				parent.secondColumn = i;
				parent.disableExpectedRatingButton();
				subviews.remove(expectedRatingSection);
                log("NOCExpectedRating " + str(i) + " " + parent.title);
				break;
			}
		}
		hide();
	}
}
