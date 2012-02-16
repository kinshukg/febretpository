class CommentRowView extends View {

  String comment;
  CommentRowView(float x_, float y_,String title)
  {
    super(x_, y_,width,25);
    this.comment = title;
  }

  void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(thirdLevelRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(10);
   text(comment,115,12);
  }
}
