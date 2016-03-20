public class ColumnContainer extends Element implements IContainer{    
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
        this._children.clear();
    }
    
    public void AddChild(Element child){      
        this._children.add(new ColumnItem(child));
    }
    
    public Element RemoveChild(Element child){
        Element container = null;
        for (Element column : this._children){
            if (((IWrapper)column).GetChild() == child){
                container = column;
                break;
            }
        }
      
        this._children.remove(container);
      
        if (container != null){
            return ((IWrapper)container).GetChild();
        }
        return null;                 
    }
    
    public List<Element> GetChildren(){
        return this._children;
    }
    
    public ColumnItem GetColumn(int column){
      return (ColumnItem)this._children.get(column);
    }
    
    public void Draw(){
        pushMatrix();
            for (Element child : this._children){
                child.Draw();
                translate(child.GetAbsoluteSize().XOffset, 0);
            }
        popMatrix();
    }
    
    
    
}

public class ColumnItem extends Element implements IWrapper{
  
  private Element _child;    
  
  public ColumnItem(Element content){
      this._child = content; 
  }
  
  public void ClearChild(){    
      this._child = null;    
  }
  
  public void AssignChild(Element child){
      this._child = child;
  }
  
  public Element GetChild(){
      return this._child;
  }
  
  public void SetWidth(double scale, int offset){
      this.SetSize(scale, offset, 0, 0);
  }
  
  public void Draw(){
      this._child.Draw();
  }
}