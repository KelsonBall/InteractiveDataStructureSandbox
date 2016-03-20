interface IContainer{  
    public void ClearChildren();   
    public void AddChild(Element child);   
    public Element RemoveChild(Element child);
    public List<Element> GetChildren();
}

interface IWrapper{
    public void ClearChild();
    public void AssignChild(Element child);
    public Element GetChild();
}

public abstract class AbstractWrapper extends Element implements IWrapper{
    
    protected Element _child;    
  
    public void ClearChild(){    
        this._child = null;    
    }
  
    public void AssignChild(Element child){
        this._child = child;
    }
  
    public Element GetChild(){
        return this._child;
    }
  
  
    public void Draw(){
        if (this._child != null){
            this._child.Draw();
        }
    }
}

interface IDrawable{  
    public void Draw();
  
    public void SetSize(UIDimensions elementSize);
    public UIDimensions GetSize();
  
    public void SetPosition(UIDimensions elementOffset);
    public UIDimensions GetPosition();    
}

interface IDraggable{
    public void BeginDrag(int mousePosX, int mousePosY);
    public void EndDrag(int mousePosX, int mousePosY);
}

interface IClickable{
    // Returns -1 if click not in bounds, otherwise returns ZIndex of element.
    // This allows sorting by ZIndex
    public int HitTest(int mousePosX, int mousePosY);
    public void InvokeClickTrigger();
  
    public void SetClickTrigger(IAction trigger);
    public IAction GetClickTrigger();
}

public class UIDimensions{   
    public int XOffset = 0; // Element.width/2
    public double XScale = 0; // 0.5
    public int YOffset = 0; //Element.height/2
    public double YScale = 0; // 0.5
  
    public UIDimensions(double xScale, int xOffset, double yScale, int yOffset)
    {
        this.XOffset = xOffset;
        this.XScale = xScale;
        this.YOffset = yOffset;
        this.YScale = yScale;
    }
}

// Defines an interface for wrapped methods.
public interface IAction<SenderType>{
    public void Invoke(SenderType sender); 
}