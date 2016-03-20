public static class Elements{
    public static Stack<UUID> TranslationId = new Stack<UUID>();
}

// Basic type that encapuslates all items in the visual tree
public abstract class Element implements IDrawable{
    private UIDimensions size, absoluteSize, position, absolutePosition, margin;
    private UUID _translationId;
    protected StyleTemplate style; 
    protected Element parent;

    public color Background, Foreground; 

    public Element(){
        this.absoluteSize = new UIDimensions(0, 0, 0, 0); 
        this.absolutePosition = new UIDimensions(0, 0, 0, 0);
        this.margin = new UIDimensions(0, 0, 0, 0);
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
        this.PushTranslation();
            this.style.Push();                
                rect(0, 0, this.absolutePosition.XOffset, this.absolutePosition.YOffset);
            this.style.Pop();
        this.PopTranslation();
        
    }
    
    public void PushTranslation(){
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
    
    public void PopTranslation() throws IllegalStateException{
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
}