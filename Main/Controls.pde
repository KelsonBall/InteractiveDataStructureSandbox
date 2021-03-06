public class Button extends Element{    
    public String Content;
}

public enum ListOrientation { VERTICAL, HORIZONTAL }

public class ListContainer extends Element implements IContainer{    
    
    private List<Element> _children = new ArrayList<Element>();
    
    public ListOrientation Orientation = ListOrientation.VERTICAL;
        
    public void ClearChildren(){
        for (Element child : this._children){
            child.parent = null;
        }
        this._children.clear();
    }
    
    public void AddChild(Element child){
        ListItem index = new ListItem(child);
        index.parent = this;
        this._children.add((Element)index);
    }
    
    public Element RemoveChild(Element child){
        Element container = null;
        for (Element index : this._children){
            if (((IWrapper)index).GetChild() == child){
                container = index;
                break;
            }
        }
        if (container != null){
            container.parent = null;
            this._children.remove(container);
            Element containedElement = ((IWrapper)container).GetChild();
            containedElement.parent = null;
            return containedElement;
        }
        return null;                 
    }
    
    public List<Element> GetChildren(){
        return this._children;
    }
    
    public ListItem GetItem(int index){
      return (ListItem)this._children.get(index);
    }
    
    @Override
    public void Display(){
         this.PushTranslation();            
            this.Style.Push();
                super.Draw();
                pushMatrix();
                    for (Element child : this._children){
                        child.Display();
                        if (this.Orientation == ListOrientation.VERTICAL){
                            translate(child.GetAbsoluteSize().XOffset, 0);
                        } else if (this.Orientation == ListOrientation.HORIZONTAL) {
                            translate(0, child.GetAbsoluteSize().YOffset);
                        }
                    }
                popMatrix();
            this.Style.Pop();           
        this.PopTranslation();                 
    }
}

public class ListItem extends AbstractWrapper{
  
    private Element _child;
  
    public ListItem(Element content){
        this.AssignChild(content);
    }  
    
    public void SetWidth(double scale, int offset) throws IllegalStateException{
        if (((ListContainer)this.parent).Orientation == ListOrientation.VERTICAL){
            this.SetSize(scale, offset, 0, 0);
        } else {
            throw new IllegalStateException("Attempted to set width of a row.");   
        }
    }
    
    public void SetHeight(double scale, int offset) throws IllegalStateException{
        if (((ListContainer)this.parent).Orientation == ListOrientation.HORIZONTAL){
            this.SetSize(0, 0, scale, offset);
        } else {
            throw new IllegalStateException("Attempted to set height of a column.");   
        }
    }
  
    @Override
    public void Display(){
        this._child.Display();
    }
}

public class Canvas extends Element implements IContainer{    
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
        for (Element child : this._children){
            child.parent = null;
        }
        this._children.clear();
    }
    
    public void AddChild(Element child){
        child.parent = this;
        this._children.add(child);
    }
    
    public Element RemoveChild(Element child){
        if (this._children.contains(child)){
            this._children.remove(child);
            child.parent = null;
            return child;
        }
        return null;
    }
    
    public List<Element> GetChildren(){
        return this._children;
    }
    
    @Override
    public void Display(){
         this.PushTranslation();            
            this.Style.Push();
                super.Draw();
                for (Element child : this._children){
                    child.Display();
                }
            this.Style.Pop();           
        this.PopTranslation();                 
    }
}