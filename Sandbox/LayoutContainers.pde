import java.util.List;

public class Canvas extends Element implements IContainer{    
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
      this._children.clear();
    }
    
    public void AddChild(Element child){
      this._children.add(child);
    }
    
    public List<Element> GetChildren(){
      return this._children;
    }
    
    public void Draw(){
      int thisWidth = this.GetAbsoluteSize().XOffset;
      int thisHeight = this.GetAbsoluteSize().YOffset;
      for (Element child : this._children){
        pushMatrix();
          float xTranslate = (float)(thisWidth * child.GetPosition().XScale) + child.GetPosition().XOffset;
          float yTranslate = (float)(thisHeight * child.GetPosition().YScale) + child.GetPosition().YOffset;
          translate(xTranslate, yTranslate);
          child.Draw();
        popMatrix();
      }      
    }
}

public class ColumnContainer extends Element implements IContainer{    
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
      this._children.clear();
    }
    
    public void AddChild(Element child){
      this._children.add(child);
    }
    
    public List<Element> GetChildren(){
      return this._children;
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
    this._child.Draw();
  }
}

public class RowContainer extends Element implements IContainer{   
  
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
      this._children.clear();
    }
    
    public void AddChild(Element child){
      this._children.add(child);
    }
    
    public List<Element> GetChildren(){
      return this._children;
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
    this._child.Draw();
  }
  
}