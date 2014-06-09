class NOCPickList extends NativeActionsPopUpView
{
	////////////////////////////////////////////////////////////////////////////
	NOCPickList(POCManager poc)
	{
		super(510, poc);
        PopUpSection actions = addSection("Add NOC(s)");
        actions.addNOC("Bowel Elimination", "test.png");
        actions.addNOC("Pain Level", "test.png");
        actions.addNOC("Comfortable Death", "test.png");
        actions.addNOC("Respiratory Status: Gas Exchange", "test.png");
        actions.addNOC("Mobility", "test.png");
        actions.addNOC("Coping", "test.png");
        actions.addNOC("Family Coping", "test.png");
        actions.addNOC("Grief Resolution", "test.png");
        actions.addNOC("Hydration", "test.png");
        actions.addNOC("Immobility Consequences", "test.png");
        actions.addNOC("Medication Response", "test.png");
        actions.addNOC("Nausea and Vomiting Control", "test.png");
        actions.addNOC("Nutrition Management", "test.png");
        actions.addNOC("Tissue Integrity Skin and Mucous Membranes", "test.png");
    }
}
