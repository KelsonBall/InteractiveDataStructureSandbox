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