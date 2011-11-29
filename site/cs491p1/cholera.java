import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class cholera extends PApplet {



////////////////////////////////////////////////////////////////////////////////////////////////////
class StreetDataItem
{
  public int id;
  public String name;
  public float[] segs;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class DeathDataItem
{
  public float x;
  public float y;
  public boolean male;
  public int age;
  public int d;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class DayDataItem
{
  public int f;
  public int m;
  public int[] age = new int[7];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class PumpDataItem
{
  public float x;
  public float y;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class LegendButton
{
  public int x;
  public int y;
  public String label;
  public int c;
  
  public LegendButton(int x, int y, String label, int c)
  {
    this.x = x;
    this.y = y;
    this.label = label;
    this.c = c;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Constants
int width = 1024;
int height = 630;
int mapSize = 800;

////////////////////////////////////////////////////////////////////////////////////////////////////
// Dataset
int streetNum = 0;
StreetDataItem[] streetData;
int dayOffset = 300;
int[] deathDays;
int maxDeaths; // The maximum number of deaths per day.
DeathDataItem[] deathData;
DayDataItem[] dayData;
PumpDataItem[] pumpData;

////////////////////////////////////////////////////////////////////////////////////////////////////
// View config.
float xofs = PApplet.parseFloat(width) * 0.05f;
float yofs = PApplet.parseFloat(height) * 1.50f;
float zoom = 1;
float angle = PI + 0.02f;
// Plot stuff.
float yScale;
float[] xScale;
int curMaxDeaths;

int clusterX = 20;
int clusterY = height - 100;
boolean clusteringEnabled = false;
int clusterSize = 100;
int clusterOfs = width / clusterSize;
int[] clusterDeaths = new int[width / clusterSize * height / clusterSize + clusterOfs];
float[] clusterVal = new float[width / clusterSize * height / clusterSize + clusterOfs];

PFont fnt;
PFont fnt2;

// Current time window.
int dayStart;
int dayLength;
int dragMode;

// Legend buttons positions.
LegendButton[] legendButton;
int filterMode;

////////////////////////////////////////////////////////////////////////////////////////////////////
public String streetName(int id)
{
  if(id == 1) return "";
  if(id == 764 || id == 699 || id == 659 || id ==  624 || id == 603 || id == 574) return "Broad St.";
  if(id == 702) return "Dufours Pl.";
  if(id == 652 || id == 767 || id == 906) return "Marshall St.";
  if(id == 738 || id == 683) return "Cross St.";
  if(id == 792) return "Little Windowmill St.";
  if(id == 729 || id == 844) return "New St.";
  if(id == 627 || id == 451 || id == 385) return "Poland St.";
  if(id == 284 || id == 275 || id == 262 || id ==  263 || id == 241 || id == 229 || id == 217 || id == 205 || id == 159 || id == 67 || id == 344) return "Oxford St.";
  if(id == 520 || id ==  484 || id == 433) return "Great Malborough St.";
  if(id == 568 || id == 555) return "Argyll Place";
  if(id == 636 || id == 696 || id == 800) return "Hopkins St.";
  if(id == 844 || id == 797) return "Hubbard St.";
  if(id == 693 || id == 885 || id == 854 || id ==  789) return "Silver St.";
  if(id == 726 || id == 1513) return "Regent St.";
  if(id == 1081 || id == 1129 || id == 1214 || id ==  1217 || id == 1214) return "Golden Square";
  if(id == 1318 || id == 1232 || id == 1120 || id ==  1032 || id == 939) return "Brewer St.";
  if(id == 1124) return "Great Pulteney St.";
  if(id == 1179) return "Bridle St.";
  /*if(id == 89) return "Little Windowmill Street";
  if(id == 55) return "Poland Street";
  if(id == 69) return "Broad Street";
  if(id == 87) return "New Street";
  if(id == 10) return "Marshall Street";*/
  return ""; //str(id);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initMapData()
{
  String[] streetDataLines = loadStrings("streets.txt");
  
  streetData = new StreetDataItem[600];
  
  int j = 0;
  int i = 0;
  while(i < streetDataLines.length)
  {
    streetData[j] = new StreetDataItem();
    
    String[] args1 = split(streetDataLines[i++], '\t');
    streetData[j].id = PApplet.parseInt(args1[0]);
    if(streetData[j].id != 1) streetData[j].id = i;
    streetData[j].name = streetName(streetData[j].id);
    streetData[j].segs = new float[PApplet.parseInt(args1[1]) * 2];
    
    for(int k = 0; k < PApplet.parseInt(args1[1]); k++)
    {
      String[] args2 = split(streetDataLines[i++], '\t');
      float x = 1 - PApplet.parseFloat(args2[0]) / 20 * mapSize;
      float y = PApplet.parseFloat(args2[1]) / 20 * mapSize;
      streetData[j].segs[k * 2] = x * cos(angle) - y * sin(angle);
      streetData[j].segs[k * 2 + 1] = y * cos(angle) + x * sin(angle);
    }
    j++;
  }
  streetNum = j;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initDeathDays()
{
  String[] deathDaysLines = loadStrings("deathdays.txt");
  
  deathDays = new int[deathDaysLines.length];

  int i = 0;
  while(i < deathDaysLines.length)
  {
    String[] args = split(deathDaysLines[i], '\t');
    deathDays[i] = PApplet.parseInt(args[1]);
    if(maxDeaths < deathDays[i]) maxDeaths = deathDays[i];
    i++;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initDeaths()
{
  String[] deathLines = loadStrings("deaths.age.mf");
  
  deathData = new DeathDataItem[deathLines.length];
  
  int k = 0;
  int curD = deathDays[k];

  int i = 0;
  while(i < deathLines.length)
  {
    String[] args = split(deathLines[i], '\t');
    deathData[i] = new DeathDataItem();
    float x = 1 - PApplet.parseFloat(args[0]) / 20 * mapSize;
    float y = PApplet.parseFloat(args[1]) / 20 * mapSize;
    deathData[i].x = x * cos(angle) - y * sin(angle);
    deathData[i].y = y * cos(angle) + x * sin(angle);
    deathData[i].age = PApplet.parseInt(args[2]);
    deathData[i].male = false;
    curD--;
    while(curD <= 0 && k < deathDays.length - 1)
    {
      k++;
      curD = deathDays[k];
    }
    deathData[i].d = k;
    if(PApplet.parseInt(args[3]) == 0)
    {
      deathData[i].male = true;
    }
    i++;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initDayData()
{
  dayData = new DayDataItem[deathDays.length];
  int k = 0;
  for(int i = 0; i < deathDays.length; i++)
  {
    dayData[i] = new DayDataItem();    
    for(int j = 0; j < deathDays[i]; j++)
    {
      if(filterMode == -1 ||
         (filterMode == 0 && deathData[k].male) ||
         (filterMode == 1 && !deathData[k].male) ||
         (deathData[k].age == 7 - filterMode))
      {
        if(deathData[k].male)
        {
          dayData[i].m++;
        }
        else 
        {
          dayData[i].f++;
        }
        dayData[i].age[deathData[k].age]++;
      }
      k++;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initPumps()
{
  String[] pumpLines = loadStrings("pumps.txt");
  
  pumpData = new PumpDataItem[pumpLines.length];

  int i = 0;
  while(i < pumpLines.length)
  {
    String[] args = split(pumpLines[i], '\t');
    pumpData[i] = new PumpDataItem();
    float x = 1 - PApplet.parseFloat(args[0]) / 20 * mapSize;
    float y = PApplet.parseFloat(args[1]) / 20 * mapSize;
    pumpData[i].x = x * cos(angle) - y * sin(angle);
    pumpData[i].y = y * cos(angle) + x * sin(angle);
    i++;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
int maleColor = color(140, 140, 255);
int femaleColor = color(255, 50, 255);
int age1Color = color(250, 250, 0);
int age2Color = color(250, 200, 0);
int age3Color = color(250, 150, 0);
int age4Color = color(250, 100, 0);
int age5Color = color(250, 50, 0);
int age6Color = color(250, 0, 0);
public void initLegendButtons()
{
  legendButton = new LegendButton[8];
  legendButton[0] = new LegendButton(0, 0, "Male", maleColor);
  legendButton[1] = new LegendButton(0, 0, "Female", femaleColor);
  legendButton[2] = new LegendButton(0, 0, "0-10", age1Color);
  legendButton[3] = new LegendButton(0, 0, "11-20", age2Color);
  legendButton[4] = new LegendButton(0, 0, "21-40", age3Color);
  legendButton[5] = new LegendButton(0, 0, "41-60", age4Color);
  legendButton[6] = new LegendButton(0, 0, "61-80", age5Color);
  legendButton[7] = new LegendButton(0, 0, ">80", age6Color);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void initPlotData()
{
  yScale = 1 / PApplet.parseFloat(maxDeaths);
  xScale = new float[deathDays.length];
  for(int i = 0; i < deathDays.length; i++)
  {
    xScale[i] = 1 / PApplet.parseFloat(deathDays.length);
  } 
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawMap()
{
  stroke(160);
  strokeWeight(zoom);
  
  for(int i = 0; i < streetNum; i++)
  {
    int x1 = -1;
    int y1 = -1;
    int x2 = 0;
    int y2 = 0;
    for(int j = 0; j < streetData[i].segs.length; j+= 2)
    {
      x2 = PApplet.parseInt(streetData[i].segs[j] + xofs);
      y2 = PApplet.parseInt(streetData[i].segs[j + 1] + yofs);
      
      x2 -= zoom * mapSize / 4;
      y2 -= zoom * mapSize / 4;
      
      x2 *= zoom;
      y2 *= zoom;
      
      if(x1 != -1)
      {
        line(x1, y1, x2, y2);
        int x = (x1 + x2) / 2;
        int y = (y1 + y2) / 2;
        float l = dist(x1, y1, x2, y2);
        if(l > 80 /*80*/ && j % 2 == 0)
        {
          textFont(fnt2, 14);
          float angle = atan2(abs(x1 - x2), abs(y1 - y2));
          if(angle > PI / 4) angle = PI - angle;
          pushMatrix();
          translate(x, y);
          rotate(- angle + PI / 2);
          fill(255, 255, 255, 255);
          textAlign(CENTER);
          text(streetData[i].name, 0, 0);
          popMatrix();
        }
      }
      x1 = x2;
      y1 = y2;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawDeaths()
{
  noStroke();
  fill(255, 190, 0);
  
  float r = zoom * 3;
  
  for(int i = 0; i < deathData.length; i++)
  {
    if(deathData[i].d >= dayStart && deathData[i].d <= dayStart + dayLength)
    {
      int x = PApplet.parseInt(deathData[i].x + xofs);
      int y = PApplet.parseInt(deathData[i].y + yofs);
      
      x -= zoom * mapSize / 4;
      y -= zoom * mapSize / 4;
      
      x *= zoom;
      y *= zoom;
      
      if(filterMode != -1)
      {
        if(filterMode == 0 || filterMode == 1)
        {
          if(deathData[i].male) fill(maleColor);
          else fill(femaleColor);
          ellipse(x, y, r, r);
        }
        else if(filterMode > 1 )
        {
          switch(deathData[i].age)
          {
            case 0:
              fill(age1Color);
              break;
            case 1:
              fill(age2Color);
              break;
            case 2:
              fill(age3Color);
              break;
            case 3:
              fill(age4Color);
              break;
            case 4:
              fill(age5Color);
              break;
            case 5:
              fill(age6Color);
              break;
          }
          ellipse(x, y, r, r);
        }
      }
      else
      {
        ellipse(x, y, r, r);
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawClusteredDeaths()
{
  noStroke();
  
  float r = zoom * 3;
  
  int md = 1;

  for(int i = 0; i < clusterDeaths.length; i++)
  {
    clusterDeaths[i] = 0;
    clusterVal[i] = 0;
  }
  
  for(int i = 0; i < deathData.length; i++)
  {
    if(deathData[i].d >= dayStart && deathData[i].d <= dayStart + dayLength)
    {
      int x = PApplet.parseInt(deathData[i].x + xofs);
      int y = PApplet.parseInt(deathData[i].y + yofs);
      
      x -= zoom * mapSize / 4;
      y -= zoom * mapSize / 4;
      
      x *= zoom;
      y *= zoom;
      
      if(x > 0 && x < width && y > 0 && y < height)
      {
        x = x / clusterSize;
        y = y / clusterSize;
        
        int id = x  + y * clusterOfs;
        clusterDeaths[id]++;
        
        if(md < clusterDeaths[id]) md = clusterDeaths[id];
        
        if(filterMode != -1)
        {
          if(filterMode == 0 || filterMode == 1)
          {
            if(deathData[i].male) clusterVal[id]++;
          }
          else if(filterMode > 1 )
          {
            clusterVal[id] += deathData[i].age;
          }
        }
      }
    }
  }
  
  for(int i = 0; i < clusterDeaths.length; i++)
  {
    int x = i % clusterOfs;
    int y = i / clusterOfs;
    
    if(filterMode != -1)
    {
      if(filterMode == 0 || filterMode == 1)
      {
        fill(lerpColor(femaleColor, maleColor, clusterVal[i] / clusterDeaths[i]), clusterDeaths[i] * 255 / md);
        rect(x * clusterSize, y * clusterSize, clusterSize, clusterSize);
      }
      else if(filterMode > 1 )
      {
        fill(lerpColor(age1Color, age6Color, clusterVal[i] / clusterDeaths[i] / 5), clusterDeaths[i] * 255 / md);
        rect(x * clusterSize, y * clusterSize, clusterSize, clusterSize);
      }
    }
    else
    {
        fill(255, 190, 0, clusterDeaths[i] * 255 / md);
        rect(x * clusterSize, y * clusterSize, clusterSize, clusterSize);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawPumps()
{
  stroke(255);
  strokeWeight(1);
  fill(150, 150, 255);
  
  float radius = 5 * zoom;
  
  for(int i = 0; i < pumpData.length; i++)
  {
    int x = PApplet.parseInt(pumpData[i].x + xofs);
    int y = PApplet.parseInt(pumpData[i].y + yofs);
    
    x -= zoom * mapSize / 4;
    y -= zoom * mapSize / 4;
    
    x *= zoom;
    y *= zoom;
    
    rect(x - 3, y - 3, radius, radius);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public String dayToString(int day)
{
  if(day < 13)
  {
    return str(day + 19) + "-Aug";
  }
  return str(day - 13) + "-Sep";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawPlotBase(int x, int y, int width, int height, String x1, String x2, String x3, String y1, String y2, String y3, String label)
{
  textFont(fnt, 14);
  
  stroke(255);
  strokeWeight(1);
  
  line(x, y, x, y + height);
  line(x, y + height, x + width, y + height);
  
  fill(255);
  textAlign(CENTER);
  text(x1, x, y + height + 15); 
  text(x2, x + width / 2, y + height + 15); 
  text(x3, x + width, y + height + 15); 
  
  textAlign(RIGHT);
  text(y1, x - 5, y + height); 
  text(y2, x - 5, y + height / 2); 
  text(y3, x - 5, y + 5); 
  
  textAlign(CENTER);
  text(label, x + width / 2, y - 5); 
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawDeathSexPlot()
{
  int deathSexPlotX = 650;
  int deathSexPlotY = 20;
  int plotWidth = 350;
  int plotHeight = 150;
  
  noStroke();
  
  float curX;

  fill(maleColor);
  beginShape();
  vertex(deathSexPlotX, deathSexPlotY + plotHeight);
  curX = deathSexPlotX;
  if(dayLength > 0)
  {
    for(int i = 0; i < dayData.length; i++)
    {
      float ptValue = deathSexPlotY + plotHeight - PApplet.parseFloat(dayData[i].m + dayData[i].f) * yScale * plotHeight;
      vertex(curX, ptValue);
      curX += PApplet.parseFloat(plotWidth) * xScale[i];
    }
  }
  else
  {
    float ptValue = deathSexPlotY + plotHeight - PApplet.parseFloat(dayData[dayStart].m + dayData[dayStart].f) * yScale * plotHeight;
    vertex(deathSexPlotX, ptValue);
    vertex(deathSexPlotX + plotWidth, ptValue);
  }
  vertex(deathSexPlotX + plotWidth, deathSexPlotY + plotHeight);
  endShape(CLOSE);

  fill(femaleColor);
  beginShape();
  vertex(deathSexPlotX, deathSexPlotY + plotHeight);
  curX = deathSexPlotX;
  if(dayLength > 0)
  {
    for(int i = 0; i < dayData.length; i++)
    {
      if(i == 20 && xScale[i] != 0)
      {
        stroke(255);
        strokeWeight(2);
        line(curX, deathSexPlotY, curX, deathSexPlotY + plotHeight);
        noStroke();
      }
      float ptValue = deathSexPlotY + plotHeight - PApplet.parseFloat(dayData[i].f) * yScale * plotHeight;
      vertex(curX, ptValue);
      curX += PApplet.parseFloat(plotWidth) * xScale[i];
    }
  }
  else
  {
    float ptValue = deathSexPlotY + plotHeight - PApplet.parseFloat(dayData[dayStart].f) * yScale * plotHeight;
    vertex(deathSexPlotX, ptValue);
    vertex(deathSexPlotX + plotWidth, ptValue);
  }
  vertex(deathSexPlotX + plotWidth, deathSexPlotY + plotHeight);
  endShape(CLOSE);
  
  drawPlotBase(deathSexPlotX, deathSexPlotY, plotWidth, plotHeight, 
    dayToString(dayStart), dayToString(dayStart + dayLength / 2), dayToString(dayStart + dayLength),
    "0", str(curMaxDeaths / 2), str(curMaxDeaths), "Deaths by Sex");
    
  // Draw legend
  legendButton[0].x = deathSexPlotX;
  legendButton[0].y = deathSexPlotY + plotHeight + 20;
  legendButton[1].x = deathSexPlotX + 100;
  legendButton[1].y = deathSexPlotY + plotHeight + 20;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawDeathAgePlot()
{
  int deathAgePlotX = 650;
  int deathAgePlotY = 250;
  int plotWidth = 350;
  int plotHeight = 150;
  
  noStroke();
  
  float curX;

  int curAge = 0;
  for(int j = 0; j < 6; j++)
  {
    switch(j)
    {
      case 0:
        fill(age1Color);
        break;
      case 1:
        fill(age2Color);
        break;
      case 2:
        fill(age3Color);
        break;
      case 3:
        fill(age4Color);
        break;
      case 4:
        fill(age5Color);
        break;
      case 5:
        fill(age6Color);
        break;
    }
    
    beginShape();
    vertex(deathAgePlotX, deathAgePlotY + plotHeight);
    curX = deathAgePlotX;
    if(dayLength > 0)
    {
      for(int i = 0; i < dayData.length; i++)
      {
        if(i == 20 && xScale[i] != 0)
        {
          stroke(255);
          strokeWeight(2);
          line(curX, deathAgePlotY, curX, deathAgePlotY + plotHeight);
          noStroke();
        }
        
        int val = 0;
        for(int k = 0; k < 6 - j; k++)
        {
          val += dayData[i].age[k];
        }
        
        float ptValue = deathAgePlotY + plotHeight - PApplet.parseFloat(val) * yScale * plotHeight;
        vertex(curX, ptValue);
        curX += PApplet.parseFloat(plotWidth) * xScale[i];
      }
    }
    else
    {
      int val = 0;
      for(int k = 0; k < 6 - j; k++)
      {
        val += dayData[dayStart].age[k];
      }
      float ptValue = deathAgePlotY + plotHeight - PApplet.parseFloat(val) * yScale * plotHeight;
      vertex(deathAgePlotX, ptValue);
      vertex(deathAgePlotX + plotWidth, ptValue);
    }
    vertex(deathAgePlotX + plotWidth, deathAgePlotY + plotHeight);
    endShape(CLOSE);
  }
  
  drawPlotBase(deathAgePlotX, deathAgePlotY, plotWidth, plotHeight,
    dayToString(dayStart), dayToString(dayStart + dayLength / 2), dayToString(dayStart + dayLength),
    "0", str(curMaxDeaths / 2), str(curMaxDeaths), "Deaths by Age");

  // Draw legend.
  for(int i = 0; i < 6; i++)
  {
    legendButton[i + 2].x = deathAgePlotX + i * 62;
    legendButton[i + 2].y = deathAgePlotY + plotHeight + 20;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawLegendButtons()
{
  for(int i = 0; i < legendButton.length; i++)
  {
    stroke(255);
    strokeWeight(1);
    fill(legendButton[i].c);
    rect(legendButton[i].x, legendButton[i].y, 10, 10);
    textAlign(LEFT);
    fill(255);
    text(legendButton[i].label, legendButton[i].x + 15, legendButton[i].y + 11);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawClusterButtons()
{
  stroke(255);
  strokeWeight(1);

  fill(0);
  rect(clusterX, clusterY, 90, 20);
  rect(clusterX + 95, clusterY, 20, 20);
  rect(clusterX + 120, clusterY, 20, 20);
  
  fill(255);
  textAlign(CENTER);
  if(clusteringEnabled)
  {
    text("[X] Clustering", clusterX + 45, clusterY + 14);
  }    
  else
  {
    text("[  ] Clustering", clusterX + 45, clusterY + 14);
  }
  text("+", clusterX + 105, clusterY + 14);
  text("-", clusterX + 130, clusterY + 14);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawDeathSexPie()
{
  int pieX = 750;
  int pieY = 520;
  int pieRadius = 80;
  
  noStroke();
  
  float mTot = 0;
  float fTot = 0;
  for(int i = dayStart; i < dayStart + dayLength; i++)
  {
    mTot += dayData[i].m;
    fTot += dayData[i].f;
  }
  
  float tot = mTot + fTot;

  fill(maleColor);
  arc(pieX, pieY, pieRadius, pieRadius, 0, TWO_PI * mTot / tot);
  fill(femaleColor);
  arc(pieX, pieY, pieRadius, pieRadius, TWO_PI * mTot / tot, TWO_PI);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void drawDeathAgePie()
{
  int pieX = 900;
  int pieY = 520;
  int pieRadius = 80;
  
  noStroke();
  
  float[] aTot = new float[6];
  for(int i = dayStart; i < dayStart + dayLength; i++)
  {
    for(int j = 0; j < 6; j++)
    {
      aTot[j] += dayData[i].age[j];
    }
  }
  
  float tot = aTot[0] + aTot[1] + aTot[2] + aTot[3] + aTot[4] + aTot[5];
  float lastAngle = 0;
  float newAngle = 0;

  fill(age1Color);
  newAngle += TWO_PI * aTot[0] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, newAngle);
  lastAngle = newAngle;
  
  fill(age2Color);
  newAngle += TWO_PI * aTot[1] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, newAngle);
  lastAngle = newAngle;
  
  fill(age3Color);
  newAngle += TWO_PI * aTot[2] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, newAngle);
  lastAngle = newAngle;
  
  fill(age4Color);
  newAngle += TWO_PI * aTot[3] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, newAngle);
  lastAngle = newAngle;
  
  fill(age5Color);
  newAngle += TWO_PI * aTot[4] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, newAngle);
  lastAngle = newAngle;
  
  fill(age6Color);
  newAngle += TWO_PI * aTot[5] / tot;
  arc(pieX, pieY, pieRadius, pieRadius, lastAngle, TWO_PI);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
int winX = 80;
int winY = 580;
int winHeight = 40;
int winWidth = width - 160;
public void drawTimeline()
{
  
  noFill();
  stroke(180);
  strokeWeight(1);
  
  rect(winX - 4, winY - 4, winWidth + 8, winHeight + 8);
  
  noStroke();
  fill(255, 190, 0);
  
  float ix = PApplet.parseFloat(winWidth) / deathDays.length;
  float iy = PApplet.parseFloat(winHeight) / maxDeaths;
  
  float curX = winX;
  for(int i = 0; i < deathDays.length; i++)
  {
    if(i == 20)
    {
      stroke(255);
      strokeWeight(2);
      line(curX, winY - 1, curX, winY + winHeight + 2);
      noStroke();
    }
    float curY = winY + winHeight;
    for(int j = 0; j < deathDays[i]; j++)
    {
      ellipse(curX, curY, 4, 4);
      curY -= iy;
    }
    curX += ix;
  }
  
  // Draw the day window selector
  fill(180, 180, 255, 80);
  stroke(255);
  rect(winX + dayStart * ix - 2, winY - 2, dayLength * ix + 4, winHeight + 4);
  // Draw the window selector handles
  fill(200, 200, 255);
  ellipse(winX + dayStart * ix - 2, winY + winHeight / 2, 8, 8);
  ellipse(winX + dayStart * ix + dayLength * ix + 2, winY + winHeight / 2, 8, 8);
  
  ellipse(winX + dayStart * ix - 2 + dayLength * ix / 2, winY, 8, 8);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void updatePlotScales()
{
  int md = 0;
  for(int i = 0; i < dayStart; i++)
  {
    xScale[i] = 0;
  }
  if(dayLength > 0)
  {
    for(int i = dayStart; i <= dayStart + dayLength; i++)
    {
      if(i < dayData.length)
      {
        xScale[i] = 1 / PApplet.parseFloat(dayLength);
        if(dayData[i].m + dayData[i].f > md) md = dayData[i].m + dayData[i].f;
      }
    }
    for(int i = dayStart + dayLength; i < dayData.length; i++)
    {
      xScale[i] = 0;
    }
  }
  else
  {
    xScale[dayStart] = 1;
    md = deathDays[dayStart];
    for(int i = dayStart + 1; i < dayData.length; i++)
    {
      xScale[i] = 0;
    }
  }
  
  yScale = 1 / PApplet.parseFloat(md);
  curMaxDeaths = md;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup()
{
  smooth();
  size(width, height);
  
  filterMode = -1;
  
  fnt = loadFont("ArialMT-14.vlw");
  fnt2 = loadFont("Arial-Black-20.vlw");
  textFont(fnt, 14);
  
  initMapData();
  initDeathDays();
  initDeaths();
  initDayData();
  initPumps();
  
  initLegendButtons();
  
  initPlotData();
  
  dayStart = 0;
  dayLength = dayData.length;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void draw()
{
  background(0x222222);
  
  if(clusteringEnabled)
  {
    drawClusteredDeaths();
  }
  else
  {
    drawDeaths();
  }
  
  drawPumps();
  drawMap();
  
  updatePlotScales();
  
  fill(0, 0, 0, 180);
  noStroke();
  rect(600, 0, width - 600, height - 65);
  rect(0, height - 65, width, height);
  
  drawDeathSexPlot();
  drawDeathAgePlot();
  drawLegendButtons();
  
  drawDeathSexPie();
  drawDeathAgePie();
  
  drawTimeline();
  
  drawClusterButtons();
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void mousePressed()
{
  float ix = PApplet.parseFloat(winWidth) / deathDays.length;
  float iy = PApplet.parseFloat(winHeight) / maxDeaths;
  if(dist(winX + dayStart * ix - 2, winY + winHeight / 2, mouseX, mouseY) < 10)
  {
    dragMode = 1;
    return;
  }
  else if(dist(winX + dayStart * ix + dayLength * ix + 2, winY + winHeight / 2, mouseX, mouseY) < 10)
  {
    dragMode = 2;
    return;
  }
  else if(dist(winX + dayStart * ix - 2 + dayLength * ix / 2, winY, mouseX, mouseY) < 10)
  {
    dragMode = 3;
    return;
  }
  
  for(int i = 0; i < legendButton.length; i++)
  {
    if(mouseX > legendButton[i].x && mouseY > legendButton[i].y &&
      mouseX < legendButton[i].x + 10 && mouseY < legendButton[i].y + 10)
      {
        filterMode = i;
        initDayData();
        return;
      }
  }
  
  if(mouseY > clusterY && mouseY < clusterY + 20 && mouseX > clusterX && mouseX < clusterX + 140)
  {
    if(mouseX < clusterX + 90)
    {
      rect(clusterX, clusterY, 90, 20);
      clusteringEnabled = !clusteringEnabled;
      return;
    }
    else if(mouseX < clusterX + 115)
    {
      rect(clusterX + 95, clusterY, 20, 20);
      clusterSize += 20;
    }
    else if(mouseX < clusterX + 140)
    {
      rect(clusterX + 120, clusterY, 20, 20);
      if(clusterSize > 20)
      {
        clusterSize -= 20;
      }
    }
    clusterDeaths = new int[width / clusterSize * height / clusterSize + clusterOfs];
    clusterVal = new float[width / clusterSize * height / clusterSize + clusterOfs];
    clusterOfs = width / clusterSize;
    return;
  }
  
  if(mouseButton == LEFT)
  {
    filterMode = -1;
    initDayData();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void mouseDragged()
{
  if(dragMode != 0)
  {
    float ix = PApplet.parseFloat(winWidth) / deathDays.length;
    float iy = PApplet.parseFloat(winHeight) / maxDeaths;
    int curDay = 0;
    int dst = 1000;
    float curX = winX;
    for(int i = 0; i < deathDays.length; i++)
    {
      int cd = PApplet.parseInt(abs(mouseX - curX));
      if(dst > cd)
      {
        curDay = i;
        dst = cd;
      }
      curX += ix;
    }
    
    if(dragMode == 1)
    {
      dayLength = dayLength - (curDay - dayStart);
      dayStart = curDay;
      if(dayLength < 0) dayLength = 0;
    }
    else if(dragMode == 2)
    {
      dayLength = curDay - dayStart + 1;
      if(dayLength < 0) dayLength = 0;
    }
    else if(dragMode == 3)
    {
      int oldDayStart = dayStart;
      dayStart = curDay - dayLength / 2;
      if(dayStart < 0) dayStart = 0;
      if(dayStart + dayLength > dayData.length || dayStart < 0)
      {
        dayStart = oldDayStart;
      }
    }
  }
  else
  {
    if(mouseButton == RIGHT && !keyPressed)
    {
      xofs += (mouseX - pmouseX);
      yofs += (mouseY - pmouseY);
      return;
    }
    if(mouseButton == CENTER)
    {
      zoom += PApplet.parseFloat(pmouseY - mouseY) / height;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
public void mouseReleased()
{
  dragMode = 0;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "cholera" });
  }
}
