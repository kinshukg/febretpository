///////////////////////////////////////////////////////////////////////////////////////////////////
class Patient
{
    // Patient id
    int id;
    
    // Patient demographics
    String name, dob, gender, allergies, codeStatus, poc, shft, room, medicalDX, mr, physician, other;

    POCManager pocManager;
    TrendView painTrendView;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void reset()
    {
        pocManager = new POCManager();
        pocManager.reset();
        
        if(id == 1)
        {
            // NANDA Constipation
            ColouredRowView NANDAConstipation = pocManager.addNANDA("Constipation", IMG_PLACEHOLDER);
            SecondLevelRowView NOCBowelElimination = pocManager.addNOC("Bowel Elimination", "", NANDAConstipation, IMG_PLACEHOLDER);
            NOCBowelElimination.setScores(2, 4);
            pocManager.addNIC("Bowel Management", "", NOCBowelElimination, IMG_PLACEHOLDER);
            pocManager.addNIC("Self-Care Assistance: Toileting", "", NOCBowelElimination, IMG_PLACEHOLDER);
            
            // NANDA Acute Pain section
            ColouredRowView NANDAAcutePain = pocManager.addNANDA("Acute Pain", IMG_ACUTE_PAIN);
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAAcutePain, IMG_PAIN_LEVEL);
            NOCPainLevel.setScores(2, 4);
            pocManager.addNIC("Medication Management", "", NOCPainLevel, IMG_MEDICATION_MANAGEMENT);
            pocManager.addNIC("Pain Management", "", NOCPainLevel, IMG_PAIN_MANAGEMENT);
            
            // NANDA Death anxiety
            ColouredRowView NANDADeathAnxiety = pocManager.addNANDA("Death Anxiety", IMG_DEATH_ANXIETY);
            SecondLevelRowView NOCComfortableDeath = pocManager.addNOC("Comfortable Death", "", NANDADeathAnxiety, IMG_COMFORTABLE_DEATH);
            NOCComfortableDeath.setScores(3, 5);
            pocManager.addNIC("Calming Technique", "", NOCComfortableDeath, IMG_CALMING_TECHNIQUE);
            pocManager.addNIC("Spiritual Support", "Family Priest to Visit 2am", NOCComfortableDeath, IMG_SPIRITUAL_SUPPORT);
        }
        
        if(!OPTION_NATIVE) setupPopup();
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
        ppw.trendView = painTrendView;
        ppw.reset();
        
        // Death Anxiety CDS
        SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
        DeathPopUpView dppw = new DeathPopUpView(600, comfortableDeath, pocManager);
    }
}

