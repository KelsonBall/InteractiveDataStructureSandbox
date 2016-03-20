// Basic type that encapuslates all items in the visual tree
public abstract class Element implements IDrawable{
    private UIDimensions size, absoluteSize, position, absolutePosition;   
    protected Element parent;

    public color Background, Foreground; 

    public Element(){
        this.absoluteSize = new UIDimensions(0, 0, 0, 0); 
        this.absolutePosition = new UIDimensions(0, 0, 0, 0);
    }

    public final void SetSize(UIDimensions elementSize){
        this.size = elementSize;
        if (this.parent == null)
        {
            this.absoluteSize.XOffset = (int)(width * elementSize.XScale) + elementSize.XOffset;
            this.absoluteSize.YOffset = (int)(height * elementSize.YScale) + elementSize.YOffset;
        } else {
            this.absoluteSize.XOffset = (int)(this.parent.GetAbsoluteSize().XOffset * elementSize.XScale) + elementSize.XOffset;
            this.absoluteSize.YOffset = (int)(this.parent.GetAbsoluteSize().YOffset * elementSize.YScale) + elementSize.YOffset;
        }
    }

    public final void SetSize(double xScale, int xOffset, double yScale, int yOffset){
        this.SetSize(new UIDimensions(xScale, xOffset, yScale, yOffset));
    }

    public final UIDimensions GetAbsoluteSize(){
        return this.absoluteSize; 
    }

    public final UIDimensions GetSize(){
        return this.size;        
    }

    public final void SetPosition(UIDimensions elementOffset){
        this.position = elementOffset;
        if (this.parent == null){
            this.absolutePosition.XOffset = (int)(width * elementOffset.XScale) + elementOffset.XOffset;
            this.absolutePosition.YOffset = (int)(height * elementOffset.YScale) + elementOffset.YOffset;
        } else {
            this.absolutePosition.XOffset = (int)(this.parent.GetAbsolutePosition().XOffset * elementOffset.XScale) + elementOffset.XOffset;
            this.absolutePosition.YOffset = (int)(this.parent.GetAbsolutePosition().YOffset * elementOffset.YScale) + elementOffset.YOffset;
        }
    }

    public final void SetPosition(double xScale, int xOffset, double yScale, int yOffset){
        this.SetPosition(new UIDimensions(xScale, xOffset, yScale, yOffset));
    }

    public final UIDimensions GetPosition(){
        return this.position;
    }

    public final UIDimensions GetAbsolutePosition(){
        return this.absolutePosition;   
    }

    public final List<Element> AllElements(){
        List<Element> elements = new ArrayList<Element>();
        elements.add(this);
        if (this instanceof IWrapper){
            elements.addAll(((IWrapper)this).GetChild().AllElements());
        }
        else if (this instanceof IContainer){
            for (Element child : ((IContainer)this).GetChildren()){      
                elements.addAll(child.AllElements());
            }
        }    
        return elements;
    }

    public void Draw(){
        pushMatrix();
            float xTranslation = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetPosition().XScale) + this.GetPosition().XOffset;
            float yTranslation = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetPosition().YScale) + this.GetPosition().YOffset;
            translate(xTranslation, yTranslation);           
            float xWidth = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetSize().XScale) + this.GetSize().XOffset;
            float yWidth = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetSize().YScale) + this.GetSize().YOffset;
            fill(this.Background);
            rect(0, 0, xWidth, yWidth);
        popMatrix();
    }
}