class ImpairedGasExchangePopup extends PopUpViewBase
{
    POCManager pocManager;
	
	PopUpSection recommendedActionSection;
	CheckBox gasExchangeCheck;
	CheckBox respiratoryMonitoringCheck;
	
    TrendView trendView;
    
	////////////////////////////////////////////////////////////////////////////
	ImpairedGasExchangePopup(int w_, SecondLevelRowView parent, POCManager poc)
	{
		super(w_, parent);
        cds = true;
        pocManager = poc;
        int alertButtonX = 460;
        // Tis is the image that appears in the long access bar button.
        PImage actionButtonImage = null;
        parent.setAlertButton(3, "Action required", alertButtonX, actionButtonImage);
        parent.actionPopUp = this;
        
        NANDAParent = parent.parent;
        NOCParent = parent;
	}
	
	////////////////////////////////////////////////////////////////////////////
	void reset()
	{
        PopUpSection title = new PopUpSection("");
        if(OPTION_CDS_TYPE != 1 && trendView != null) title.addTrendView(trendView);
        subviews.add(title);
        
        recommendedActionSection = new PopUpSection(
            "<info> This patient's profile suggests that monitoring <b> Impaired Gas Exchange </b> is no longer indicated.");
            
		gasExchangeCheck = new CheckBox("Remove NANDA: Impaired Gas Exchange", firstLevelIcon, 0);
		gasExchangeCheck.textBoxEnabled = false;
		gasExchangeCheck.owner = this;
		gasExchangeCheck.setIconTooltipImage(loadImage("impairedgasExchange.png"));
        recommendedActionSection.addAction(gasExchangeCheck);

		respiratoryMonitoringCheck = new CheckBox("Add NIC: Respiratory Monitoring to <nanda> Acute Pain", thirdLevelIcon, 0);
		respiratoryMonitoringCheck.textBoxEnabled = false;
		respiratoryMonitoringCheck.owner = this;
		respiratoryMonitoringCheck.setIconTooltipImage(loadImage("respiratoryMonitoring.png"));
        recommendedActionSection.addAction(respiratoryMonitoringCheck);
        
        subviews.add(recommendedActionSection);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
        if(gasExchangeCheck.selected)
        {
            gasExchangeCheck.selected = false;
            gasExchangeCheck.enabled = false;
            pocManager.deleteNANDA(NANDAParent);
            //pocManager.prioritizeNANDA(NANDAParent);
        }
        if(respiratoryMonitoringCheck.selected)
        {
            respiratoryMonitoringCheck.selected = false;
            respiratoryMonitoringCheck.enabled = false;
            SecondLevelRowView acutePainNOC = pocManager.getNOC("Acute Pain", "Pain Level");
            pocManager.addNIC("Respiratory Monitoring", "", acutePainNOC, loadImage("respiratoryMonitoring.png"));
        }
        
		parent.stopBlinking();
		hide();
        
        // If both actions are disabled, hide the popup.
        if(!gasExchangeCheck.enabled && !respiratoryMonitoringCheck.enabled)
        {
            parent.removeAlertButton();
        }
	}
    
	////////////////////////////////////////////////////////////////////////////
    void onNICAdded(ThirdLevelRowView nic)
    {
        super.onNICAdded(nic);
    }
    
	////////////////////////////////////////////////////////////////////////////
    void onNICRemoved(ThirdLevelRowView nic)
    {
        super.onNICRemoved(nic);
    }
}
