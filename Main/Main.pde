

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