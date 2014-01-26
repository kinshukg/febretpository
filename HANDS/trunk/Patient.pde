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
        int ppwidth = 570;
        if(OPTION_GRAPH_IN_MAIN_POPUP) ppwidth = 705;
        if(OPTION_ALERT_INFO_BUTTON) ppwidth = 570;
        
        PainPopUpView ppw = new PainPopUpView(ppwidth, pocManager.painLevelView, pocManager);
        ppw.reset();
        
        GraphPopUpView gp1 = new GraphPopUpView(500, pocManager.respiratoryStatusView);
        gp1.reset(anxietyLevelTrend);

        GraphPopUpView gp2 = new GraphPopUpView(500, pocManager.anxietySelfControlView);
        gp2.reset(anxietySelfControlTrend);
        
        GraphPopUpView gp3 = new GraphPopUpView(500, pocManager.painLevelView);
        gp3.reset(painLevelTrend);

        GraphPopUpView gp4 = new GraphPopUpView(500, pocManager.nocFamilyCoping);
        gp4.reset(emptyTrend);
        
        // Tis is the image that appears in the long access bar button.
        PImage painLevelActionButtonImage = null;
        
        if(OPTION_GRAPH_IN_MAIN_POPUP)
        {
            if( OPTION_NUMBER != 3 &&  OPTION_NUMBER !=4)
            {
                int graphButtonX = 750;
                pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
                pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
                pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
                pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
                //painLevelActionButtonImage = smallGraph3;
                pocManager.painLevelView.actionPopUp = ppw;
            }
            else
            {
                int graphButtonX = 750;
                pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
                pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
                pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
                pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
                graphButtonX = 750;
                //painLevelActionButtonImage = smallGraph3;
                pocManager.painLevelView.actionPopUp = ppw;
            }
        }
        else
        {
            // Default
            int graphButtonX = 750;
            pocManager.painLevelView.actionPopUp = ppw;
            pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
            pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
            pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
            pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
        }

        // alert button position, used for inter-row button alignment
        int alertButtonX;
        if(OPTION_LONG_ALERT_BUTTON)
        {
            alertButtonX = 360;
            pocManager.painLevelView.setAlertButton(3, "Mrs. Taylor's Pain Level is not controlled.", alertButtonX, painLevelActionButtonImage);
        }
        else 
        {
            alertButtonX = 575;
            pocManager.painLevelView.setAlertButton(3, "Actions", alertButtonX, painLevelActionButtonImage);
            pocManager.painLevelView.message = "Mrs. Taylor's Pain Level is not controlled.";
        }
        
        if(OPTION_ALERT_INFO_BUTTON)
        {
            pocManager.painLevelView.setInfoButton(645, MSG_PAIN_EVIDENCE_POPUP);
        }
        
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

