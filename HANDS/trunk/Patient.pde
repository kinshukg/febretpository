///////////////////////////////////////////////////////////////////////////////////////////////////
class Patient
{
    // Patient id
    int id;
    
    // Patient demographics
    String name, dob, gender, allergies, codeStatus, poc, shft, room, medicalDX, mr, physician, other;

    POCManager pocManager;
    
    // List of trends 
    ArrayList trends = new ArrayList();;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void reset()
    {
        pocManager = new POCManager();
        pocManager.reset();
        
        // Variables used to populate the native HANDS action popup.
        NativeActionsPopUpView popup = null;
        PopUpSection actions = null;
        
        if(id == 1)
        {
            // NANDA Constipation
            ColouredRowView NANDAConstipation = pocManager.addNANDA("Constipation", IMG_PLACEHOLDER);
            SecondLevelRowView NOCBowelElimination = pocManager.addNOC("Bowel Elimination", "", NANDAConstipation, IMG_PLACEHOLDER);
            NOCBowelElimination.setScores(2, 4);
            pocManager.addNIC("Bowel Management", "", NOCBowelElimination, IMG_PLACEHOLDER);
            pocManager.addNIC("Self-Care Assistance: Toileting", "", NOCBowelElimination, IMG_PLACEHOLDER);
            // NATIVE HANDS actions for NOC Bowel Elimination
            popup = new NativeActionsPopUpView(505, NOCBowelElimination, pocManager);
            actions = popup.addSection("Add NICS for NOC Bowel Elimination");
            actions.addAction("Add NIC: Constipation/Impaction Management", "Constipation/Impaction Management", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Fluid Management", "Fluid Management", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Bowel Training", "Bowel Training", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Medication Management", "Medication Management", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Bowel Management", "Bowel Management", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Self-Care Assistance: Toileting", "Self-Care Assistance: Toileting", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Self-Care Assistance: Toileting", "Self-Care Assistance: Toileting", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            
            
            // NANDA Acute Pain section
            ColouredRowView NANDAAcutePain = pocManager.addNANDA("Acute Pain", IMG_ACUTE_PAIN);
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAAcutePain, IMG_PAIN_LEVEL);
            NOCPainLevel.setScores(2, 4);
            pocManager.addNIC("Medication Management", "", NOCPainLevel, IMG_MEDICATION_MANAGEMENT);
            pocManager.addNIC("Pain Management", "", NOCPainLevel, IMG_PAIN_MANAGEMENT);
            // NATIVE HANDS actions for NOC Pain Level
            popup = new NativeActionsPopUpView(505, NOCPainLevel, pocManager);
            actions = popup.addSection("Add NICS for NOC Pain Level");
            actions.addAction("Add NIC: Positioning", "Positioning", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Energy Conservation", "Energy Conservation", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Palliative Care Consult", "Palliative Care Consult", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Patient Controlled Analgesia", "Patient Controlled Analgesia", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Massage", "Massage", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Relaxation Therapy", "Relaxation Therapy", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            actions.addAction("Add NIC: Guided Imagery", "Guided Imagery", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);

            // We add the death anxiety section after the first shift.
            if(currentShift == 1)
            {
                // NANDA Death anxiety
                ColouredRowView NANDADeathAnxiety = pocManager.addNANDA("Death Anxiety", IMG_DEATH_ANXIETY);
                SecondLevelRowView NOCComfortableDeath = pocManager.addNOC("Comfortable Death", "", NANDADeathAnxiety, IMG_COMFORTABLE_DEATH);
                NOCComfortableDeath.setScores(3, 5);
                pocManager.addNIC("Calming Technique", "", NOCComfortableDeath, IMG_CALMING_TECHNIQUE);
                pocManager.addNIC("Spiritual Support", "Family Priest to Visit 2am", NOCComfortableDeath, IMG_SPIRITUAL_SUPPORT);
                // NATIVE HANDS actions for NANDA Death Anxiety
                popup = new NativeActionsPopUpView(505, NOCComfortableDeath, pocManager);
                actions = popup.addSection("Add NICS for NOC Comfortable Death");
                actions.addAction("Add NIC: Anxiety Reduction", "Anxiety Reduction", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
                actions.addAction("Add NIC: Caregiver Support", "Caregiver Support", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
                actions.addAction("Add NIC: Grief Work Facilitation", "Grief Work Facilitation", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
                actions.addAction("Add NIC: Active Listening", "Active Listening", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
                actions.addAction("Add NIC: Family Coping", "Family Coping", thirdLevelIcon, ADD_NIC, IMG_POSITIONING);
            }
        }
        
        if(!OPTION_NATIVE) setupPopup();
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    TrendView getTrend(String name)
    {
		for (int i = 0; i < trends.size(); i++ ) 
		{
			TrendView tw = (TrendView) trends.get(i);
            if(tw.title.equals(name)) return tw;
        }
        print("Patient::getTrend - could not find trend titled " + name);
        return null;
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void show()
    {
		mainView.subviews.add(pocManager.scrollingView);
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void hide()
    {
		mainView.subviews.remove(pocManager.scrollingView);
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void nextShift()
    {
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    public void setupPopup()
    {
        // Acute Pain CDS
        SecondLevelRowView painLevel = pocManager.getNOC("Acute Pain", "Pain Level");
        PainPopUpView ppw = new PainPopUpView(705, painLevel, pocManager);
        ppw.trendView = getTrend(painLevel.title);
        ppw.reset();
        
        // Death Anxiety CDS
        SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
        DeathPopUpView dppw = new DeathPopUpView(600, comfortableDeath, pocManager);
        dppw.trendView = getTrend(comfortableDeath.title);
        dppw.reset();
    }
}

