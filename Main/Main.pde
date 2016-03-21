int pWidth, pHeight;

void setup(){
    size(800,600);
    pWidth = width;
    pHeight = height;        
    
    surface.setResizable(true);    
    
    background(200); 
    
    // Build the visual tree.
    Initialize();    
}

void draw(){
    if (pWidth != width || pHeight != height){
        App.SetSize(1, 0, 1, 0);
        pWidth = width;
        pHeight = height;
    }
    
    App.Display();
}

Element elementUnderPoint(int x, int y){
    Element topItemUnderPoint = null;
    
    int top = 0;
    int index;
    List<Element> allElements = App.AllElements();
    for (Element element : allElements){        
        if ((index = element.HitTest(x, y)) > top){
            top = index;
            topItemUnderPoint = element;
        }
    }
       // if element is IClickable
           // if (element.HitTest(mouseX,mouseY) > topClickedItemZIndex)
               //topClickedItem = element
    return topItemUnderPoint;
}

void mousePressed()
{
   
   //topClickedItem.Invoke();  
}

void mouseMoved()
{
    //if there is an item being dragged
        //draw();
}

void mouseReleased()
{
    //if there is an item being dragged
        //end drag
    //draw();
}

void keyPressed()
{
  
}

void keyReleased()
{
  
}