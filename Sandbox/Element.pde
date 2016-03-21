public static class Elements{
    public static Stack<UUID> TranslationId = new Stack<UUID>();
}

// Basic type that encapuslates all items in the visual tree.
// Defines default behaviors and properties.
public abstract class Element implements IDrawable{
    private IAction<Element> _clickTrigger;
    private UIDimensions _size, _absoluteSize, _position, _absolutePosition;
    private Vector4 _margin;
    private UUID _translationId;
     
    protected Element parent;

    public StyleTemplate Style; 

    public Element(){
        this._absoluteSize = new UIDimensions(0, 0, 0, 0); 
        this._absolutePosition = new UIDimensions(0, 0, 0, 0);
        this._margin = new Vector4(0, 0, 0, 0);
        this.Style = new StyleTemplate();
    }

    public final void SetSize(UIDimensions elementSize){
        this._size = elementSize;
        int xMarginMod = this._margin.Left + this._margin.Right;
        int yMarginMod = this._margin.Top + this._margin.Bottom;
        int x, y;
        if (this.parent == null)
        {            
            x = (int)(width * elementSize.XScale) + elementSize.XOffset + xMarginMod;            
            y = (int)(height * elementSize.YScale) + elementSize.YOffset + yMarginMod;
        } else {
            x = (int)(this.parent.GetAbsoluteSize().XOffset * elementSize.XScale) + elementSize.XOffset + xMarginMod;
            y = (int)(this.parent.GetAbsoluteSize().YOffset * elementSize.YScale) + elementSize.YOffset + yMarginMod;
        }
        
        this._absoluteSize = new UIDimensions(0, x, 0, y);
        
        // Propegate changes down visual tree
        if (this instanceof IWrapper){
            Element child = ((IWrapper)this).GetChild();
            if (child != null){
                child.SetSize(child.GetSize());
            }
        } else if (this instanceof IContainer){
            List<Element> children = ((IContainer)this).GetChildren();
            for (Element child : children){
                child.SetSize(child.GetSize());
            }
        }
        
        
    }

    public final void SetSize(double xScale, int xOffset, double yScale, int yOffset){
        this.SetSize(new UIDimensions(xScale, xOffset, yScale, yOffset));
    }

    public final UIDimensions GetAbsoluteSize(){
        return this._absoluteSize; 
    }

    public final UIDimensions GetSize(){
        return this._size;
    }

    public final void SetPosition(UIDimensions elementOffset){
        elementOffset.XOffset += this._margin.Left;
        elementOffset.YOffset += this._margin.Top;        
        this._position = elementOffset;        
        int x, y;
        if (this.parent == null){
            x = (int)(width * elementOffset.GetXScale()) + elementOffset.GetXOffset();
            y = (int)(height * elementOffset.GetYScale()) + elementOffset.GetYOffset();
        } else {
            x = (int)(this.parent.GetAbsolutePosition().GetXOffset() * elementOffset.GetXScale()) + elementOffset.GetXOffset();
            y = (int)(this.parent.GetAbsolutePosition().GetYOffset() * elementOffset.GetYScale()) + elementOffset.GetYOffset();
        }
        
        this._absolutePosition = new UIDimensions(0, x, 0, y);
        
        // Propegate changes down visual tree
        if (this instanceof IWrapper){
            Element child = ((IWrapper)this).GetChild();
            if (child != null){
                child.SetPosition(child.GetPosition());
            }
        } else if (this instanceof IContainer){
            List<Element> children = ((IContainer)this).GetChildren();
            for (Element child : children){
                child.SetPosition(child.GetPosition());
            }
        }
    }       

    public final void SetPosition(double xScale, int xOffset, double yScale, int yOffset){
        this.SetPosition(new UIDimensions(xScale, xOffset, yScale, yOffset));
    }       

    public final UIDimensions GetPosition(){
        return this._position;
    }

    public final UIDimensions GetAbsolutePosition(){
        return this._absolutePosition;   
    }
    
    public final void SetMargin(int left, int top, int right, int bottom){
        this.SetMargin(new Vector4(left, top, right, bottom));
    }
    
    public final void SetMargin(Vector4 margin){
        this._margin = margin;
        this.SetSize(this.GetSize());
        this.SetPosition(this.GetPosition());
    }
    
    public final Vector4 GetMargin(){
        return this._margin;   
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
    
    public final void PushTranslation(){
        if (this.parent == null){
            return;
        }
            
        this._translationId = UUID.randomUUID();
        Elements.TranslationId.push(this._translationId);
        pushMatrix();
        float xTranslation = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetPosition().XScale) + this.GetPosition().XOffset;
        float yTranslation = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetPosition().YScale) + this.GetPosition().YOffset;
        translate(xTranslation, yTranslation);
    }
    
    public final void PopTranslation() throws IllegalStateException{
        if (this.parent == null){
            return;
        }
        
        if (this._translationId == Elements.TranslationId.peek()){
            Elements.TranslationId.pop();
            popMatrix();
        } else {
            throw new IllegalStateException("Attempted to pop a translation that was not at the top of the stack.");
        }
    }
    
    public final void InvokeClickTrigger(){
        this._clickTrigger.Invoke(this); 
    }
  
    public final int HitTest(int mousePosX, int mousePosY)
    {
         return -1;
    }
  
    public final void SetClickTrigger(IAction<Element> trigger){
        this._clickTrigger = trigger;
    }
  
    public final IAction<Element> GetClickTrigger(){
        return this._clickTrigger;
    }
    
    public void Display(){
        this.PushTranslation();
            this.Style.Push();
                this.Draw();
            this.Style.Pop();
        this.PopTranslation();        
    }
    
    public void Draw(){
        rect(0, 0, this._absoluteSize.XOffset, this._absoluteSize.YOffset);
    }
}