VisualRoot App;

void setup(){
    size(800,600);
    surface.setResizable(true);
    background(200);
  
    App = new VisualRoot();
  
    //noLoop();
}

void draw(){
    
}


void mousePressed()
{
   //element topClickedItem;
   //int topClickedItemZIndex;
   // for each element in the visual tree
       // if element is IClickable
           // if (element.HitTest(mouseX,mouseY) > topClickedItemZIndex)
               //topClickedItem = element
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