// Basic type that encapuslates all items in the visual tree
public abstract class Element implements IDrawable{
  private UIDimensions size, absoluteSize, position;   
  protected Element parent;
  
  public Element(){
   this.absoluteSize = new UIDimensions(0, 0, 0, 0); 
  }
  
  public void SetSize(UIDimensions elementSize){
    this.size = elementSize;
    if (this.parent == null)
    {
      this.absoluteSize.XOffset = (int)(width * elementSize.XScale) + elementSize.XOffset;
      this.absoluteSize.YOffset = (int)(height * elementSize.YScale) + elementSize.YOffset;
    }
    else
    {
      this.absoluteSize.XOffset = (int)(this.parent.absoluteSize.XOffset * elementSize.XScale) + elementSize.XOffset;
      this.absoluteSize.YOffset = (int)(this.parent.absoluteSize.YOffset * elementSize.YScale) + elementSize.YOffset;
    }
  }
  
  public UIDimensions GetAbsoluteSize()
  {
    return this.absoluteSize; 
  }
  
  public UIDimensions GetSize(){
    return this.size;
  }
  
  public void SetPosition(UIDimensions elementOffset){
    this.position = elementOffset;
  }
  
  public UIDimensions GetPosition(){
    return this.position;
  }
}



public class Button extends Element implements IClickable, IDrawable{
  private IAction<Button> _clickTrigger;
  
    
  
  public String Background;
  
  public void InvokeClickTrigger(){
    this._clickTrigger.Invoke(this); 
  }
  
  public int HitTest(int mousePosX, int mousePosY)
  {
     return -1;
  }
  
  public void SetClickTrigger(IAction trigger){
    this._clickTrigger = trigger;
  }
  
  public IAction GetClickTrigger(){
    return this._clickTrigger;
  }
  
  public void Draw(){
    pushMatrix();
      float xTranslation = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetPosition().XScale) + this.GetPosition().XOffset;
      float yTranslation = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetPosition().YScale) + this.GetPosition().YOffset;
      translate(xTranslation, yTranslation);           
      float xWidth = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetSize().XScale) + this.GetSize().XOffset;
      float yWidth = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetSize().YScale) + this.GetSize().YOffset;
      rect(0, 0, xWidth, yWidth);
    popMatrix();
  }
  
  
  
}