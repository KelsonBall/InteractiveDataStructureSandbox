public class Button extends Element implements IClickable, IDrawable{
    private IAction<Button> _clickTrigger;
  
    public String Content;
  
    public void InvokeClickTrigger(){
        this._clickTrigger.Invoke(this); 
    }
  
    public int HitTest(int mousePosX, int mousePosY)
    {
         return -1;
    }
  
    public void SetClickTrigger(IAction trigger){
        this._clickTrigger = trigger;
    }
  
    public IAction GetClickTrigger(){
        return this._clickTrigger;
    }
  
    public void Draw(){
        super.Draw();
        pushMatrix();
            float xTranslation = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetPosition().XScale) + this.GetPosition().XOffset;
            float yTranslation = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetPosition().YScale) + this.GetPosition().YOffset;
            translate(xTranslation, yTranslation);           
            float xWidth = (float)(this.parent.GetAbsoluteSize().XOffset * this.GetSize().XScale) + this.GetSize().XOffset;
            float yWidth = (float)(this.parent.GetAbsoluteSize().YOffset * this.GetSize().YScale) + this.GetSize().YOffset;
            stroke(this.Foreground);
            text(this.Content, xWidth / 2 - textWidth(this.Content)/2, yWidth / 2 - 7);
        popMatrix();
    }    
}