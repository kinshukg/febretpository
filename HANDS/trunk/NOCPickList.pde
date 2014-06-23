class NOCPickList extends NativeActionsPopUpView
{
	////////////////////////////////////////////////////////////////////////////
	NOCPickList(POCManager poc)
	{
		super(510, poc);
        PopUpSection actions = addSection("Add NOC(s)");
        actions.addNOC("Bowel Elimination", "NOCBowelElimination.png");
        actions.addNOC("Pain Level", "painLevel.PNG");
        actions.addNOC("Comfortable Death", "comfortableDeath.PNG");
        actions.addNOC("Respiratory Status: Gas Exchange", "NOCRespiratoryStatusGasExchange.png");
        actions.addNOC("Mobility", "NOCMobility.png");
        actions.addNOC("Coping", "coping.png");
        actions.addNOC("Family Coping", "familyCoping.PNG");
        actions.addNOC("Grief Resolution", "griefResolution.png");
        actions.addNOC("Hydration", "hydration.png");
        actions.addNOC("Immobility Consequences", "immobilityConsequences.png");
        actions.addNOC("Medication Response", "medicationResponse.png");
        actions.addNOC("Nausea and Vomiting Control", "nauseaVomitingControl.png");
        //actions.addNOC("Nutrition Management", "test.png");
        actions.addNOC("Tissue Integrity Skin and Mucous Membranes", "tissueIntegrity.png");
        CheckBox oth = actions.addNOC("Other", "tooltipPlaceholder.PNG");
        oth.showTextBox();
        oth.tb.suggestion = "Enter NOC Name";
    }
}
