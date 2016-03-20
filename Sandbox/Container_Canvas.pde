public class Canvas extends Element implements IContainer{    
    private List<Element> _children = new ArrayList<Element>();
    
    public void ClearChildren(){
        this._children.clear();
    }
    
    public void AddChild(Element child){
        this._children.add(child);
    }
    
    public Element RemoveChild(Element child){
        if (this._children.contains(child)){
            this._children.remove(child);
            return child;
        }
        return null;
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