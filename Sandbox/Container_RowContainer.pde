public class RowContainer extends Element implements IContainer{   
  
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
        this._children.clear();
    }
    
    public void AddChild(Element child){
        this._children.add(child);
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
    
    public RowItem GetRow(int row){
        return (RowItem)this._children.get(row);
    }
    
    public void Draw(){
        pushMatrix();
        for (Element child : this._children){
            child.Draw();
            translate(0, child.GetAbsoluteSize().YOffset);
        }
        popMatrix();
    }
}

public class RowItem extends Element implements IWrapper{
  
    private Element _child;
  
    public RowItem(Element content){
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
  
    public void SetHeight(double scale, int offset){
        this.SetSize(0, 0, scale, offset);
    }
  
    public void Draw(){    
        this._child.Draw();
    }
  
}