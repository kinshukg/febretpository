///////////////////////////////////////////////////////////////////////////////////////////////////
class Patient
{
    // Patient id
    int id;
    
    // Patient demographics
    String name, dob, gender, allergies, codeStatus, poc, shft, room, medicalDX, mr, physician, other;

    POCManager pocManager;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void reset()
    {
        pocManager = new POCManager();
        pocManager.reset();
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
        int ppwidth = 705;
        
        PainPopUpView ppw = new PainPopUpView(ppwidth, pocManager.painLevelView, pocManager);
        ppw.reset();
        
        // Tis is the image that appears in the long access bar button.
        PImage painLevelActionButtonImage = null;
        
        int graphButtonX = 750;
        pocManager.painLevelView.actionPopUp = ppw;

        // alert button position, used for inter-row button alignment
        int alertButtonX;
        alertButtonX = 460;
        pocManager.painLevelView.setAlertButton(3, "Action required", alertButtonX, painLevelActionButtonImage);
        
        // Cycle 2 addition
        DeathPopUpView dppw = new DeathPopUpView(600, pocManager.anxietySelfControlView, pocManager);
        dppw.setupFull();
        pocManager.anxietySelfControlView.setAlertButton(3, "Action required", alertButtonX, null);
        pocManager.anxietySelfControlView.actionPopUp = dppw;
        
        // Cycle 3 addition
        MobilityPopupView mppw = new MobilityPopupView(400, pocManager.NOCMobility, pocManager);
        mppw.setupFull();
        pocManager.NOCMobility.setAlertButton(3, "Action required", alertButtonX, null);
        pocManager.NOCMobility.actionPopUp = mppw;
    }
}

