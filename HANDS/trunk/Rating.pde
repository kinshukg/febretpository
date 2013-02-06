class Rating extends View 
{
  
  String header;
  int numberOfChoices;
  int currentChoice;
  ArrayList<IndividualCheckBox> checkboxes;
 // ArrayList<String> texts;
  Rating(float x, float y, float w, String header){
  
    super(x,y,w,25);
    this.header = header;
    this.checkboxes = new ArrayList<IndividualCheckBox>();
    this.addRating("1");
    this.addRating("2");
    this.addRating("3");
    this.addRating("4");
    this.addRating("5");
   // this.texts = new ArrayList<String>();
  }
  
  void addRating(String choiceText){
  IndividualCheckBox i = new IndividualCheckBox((float)25, 25 + (float)25*checkboxes.size(), choiceText, checkboxes.size()+1,this);
   this.checkboxes.add(i);
   this.subviews.add(i);
   this.h = this.h+25;
  }
  
  void drawContent(){
  
    textFont(fbold);
    //textSize(12);
    text(header, header.length()*80/20,10);
  }
  void toggle(int id){
  
  for(int i = 0; i < checkboxes.size(); i++){
    if(id-1 != i){
      IndividualCheckBox ich =  checkboxes.get(i);
      ich.selected = false;
      currentChoice = id-1;
    }
    
  }
  }
}
