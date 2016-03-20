import java.util.List;

interface IContainer{  
  public void ClearChildren();   
  public void AddChild(Element child);   
  public List<Element> GetChildren();
}

interface IWrapper{
  public void ClearChild();
  public void AssignChild(Element child);
  public Element GetChild();
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