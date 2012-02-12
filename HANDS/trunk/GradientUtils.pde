class GradientUtils
{
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawBox(int x, int y, int width, int height, int dx, color c, int sa)
  {
    strokeWeight(1);
    stroke(c, sa);
    line(x, y - dx, x + width, y - dx);
    line(x, y + height + dx, x + width, y + height + dx);
    line(x - dx, y, x - dx, y + height);
    line(x + width + dx, y, x + width + dx, y + height);
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawGradient(int x, int y, int width, int height, color start, int sa, color end, int ea)
  {
    noStroke();
    beginShape(QUADS);
    
    fill(start, sa);
    vertex(x, y);
    vertex(x + width, y);
    
    fill(end, ea);
    vertex(x + width, y + height);
    vertex(x, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawVGradient(float x, float y, float width, float height, color start, int sa, color end, int ea, float pc)
  {
    noStroke();
    fill(start, sa);
    
    float h1 = int(height * pc);
    
    rect(x, y, width, h1);
    y += h1;
    height -= h1;
    
    beginShape(QUADS);
    
    vertex(x, y);
    vertex(x + width, y);
    
    fill(end, ea);
    vertex(x + width, y + height);
    vertex(x, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawHGradient(float x, float y, float width, float height, color start, int sa, color end, int ea, float pc)
  {
    noStroke();
    fill(start, sa);
    
    float w1 = int(width * pc);
    
    rect(x, y, w1, height);
    x += w1;
    width -= w1;
    
    beginShape(QUADS);
    
    vertex(x, y + height);
    vertex(x, y);

    fill(end, ea);
    vertex(x + width, y);
    vertex(x + width, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawGradient2(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, color start, int sa, color end, int ea)
  {
    noStroke();
    beginShape(QUADS);
    
    fill(start, sa);
    vertex(x1, y1);
    vertex(x2, y2);
    
    fill(end, ea);
    vertex(x3, y3);
    vertex(x4, y4);
    
    endShape(); 
  }
}
