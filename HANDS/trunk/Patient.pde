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
        if(!OPTION_NO_SUGGESTIONS) setupPopup();
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
            pocManager.painLevelView.setInfoButton(645, 
                OPTION_TAILORED_MESSAGES ? MSG_PAIN_EVIDENCE_POPUP_TAILORED : MSG_PAIN_EVIDENCE_POPUP);
        }
        
        // Cycle 2 addition
        if(OPTION_BIG_INFORMATION)
        {
            DeathPopUpView dppw = new DeathPopUpView(600, pocManager.anxietySelfControlView, pocManager);
            dppw.setupFull();
            pocManager.anxietySelfControlView.setAlertButton(3, "Action required", alertButtonX, null);
            pocManager.anxietySelfControlView.actionPopUp = dppw;
        }
        else
        {
            DeathPopUpView dppw = new DeathPopUpView(500, pocManager.anxietySelfControlView, pocManager);
            dppw.setupConsultRefuse();
            
            if(OPTION_TAILORED_MESSAGES)
            {
                pocManager.anxietySelfControlView.enableQuickActionButton1(300, 300, MSG_ACTION_CONSULTATION, true, MSG_PALLIATIVE_CARE_INFO_TAILORED);
                pocManager.anxietySelfControlView.enableQuickActionButton2(300, 300, MSG_ACTION_COPING, false, MSG_FAMILY_COPING_TAILORED);
            }
            else
            {
                pocManager.anxietySelfControlView.enableQuickActionButton1(300, 300, MSG_ACTION_CONSULTATION, true, MSG_PALLIATIVE_CARE_INFO);
                pocManager.anxietySelfControlView.enableQuickActionButton2(300, 300, MSG_ACTION_COPING, false, MSG_FAMILY_COPING);
            }
            
            pocManager.anxietySelfControlView.qa1Text.tooltipImage = IMG_CONSULTATION;
            pocManager.anxietySelfControlView.qa2Text.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;
            pocManager.anxietySelfControlView.actionPopUp = dppw;
        }
        
        // Cycle 3 addition
        if(OPTION_BIG_INFORMATION)
        {
            MobilityPopupView mppw = new MobilityPopupView(400, pocManager.NOCMobility, pocManager);
            mppw.setupFull();
            pocManager.NOCMobility.setAlertButton(3, "Action required", alertButtonX, null);
            pocManager.NOCMobility.actionPopUp = mppw;
        }
        else
        {
            if(OPTION_TAILORED_MESSAGES)
            {
                pocManager.NOCMobility.enableQuickActionButton2(300, 300, MSG_ACTION_IMMOBILITY_CONSEQUENCES, false, MSG_IMMOBILITY_CONSEQUENCES_TAILORED);
            }
            else
            {
                pocManager.NOCMobility.enableQuickActionButton2(300, 300, MSG_ACTION_IMMOBILITY_CONSEQUENCES, false, MSG_IMMOBILITY_CONSEQUENCES_GENERIC);
            }
            pocManager.NOCMobility.qa2Text.tooltipImage = IMG_IMMOBILITY_CONSEQUENCES;
            MobilityPopupView mppw = new MobilityPopupView(400, pocManager.NOCMobility, pocManager);
            mppw.setupRefuseSection();
            pocManager.NOCMobility.actionPopUp = mppw;
        }
    }
}

