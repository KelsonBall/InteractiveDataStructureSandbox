public static class Styles{
    public enum Templates {
        DEFAULT, DARK, LIGHT
    }    
    public static Stack<UUID> StyleId = new Stack<UUID>();    
}

public class StyleTemplate{
    private UUID _pushId;       
    
    public boolean HasFill, HasStroke, HasTint;
    public color Fill, Stroke, Tint;
    public int StrokeWeight, StrokeCap, StrokeJoin;
    public int EllipseMode, RectMode, ShapeMode, TextureMode, ImageMode, ColorMode, ColorModeMaxR, ColorModeMaxG, ColorModeMaxB, ColorModeMaxA;
    public int TextSize, TextAlignX, TextAlignY, TextLeading;   
    public PFont Font;    
    
    public StyleTemplate(Styles.Templates Type){
        if (Type == Styles.Templates.DEFAULT){
            this.HasFill = true;
            this.Fill = 0xDDDDDDFF;
            this.HasStroke = true;
            this.Stroke = 0x333333FF;
            this.HasTint = false;
            this.StrokeWeight = 4;
            this.StrokeCap = SQUARE;
            this.StrokeJoin = MITER;
            this.EllipseMode = CORNER;
            this.RectMode = CORNER;
            this.ImageMode = CORNER;
            this.TextureMode = NORMAL;
        }
    }
    
    public void Push(){
        this._pushId = UUID.randomUUID();
        Styles.StyleId.push(this._pushId);
        pushStyle();
        
        if (this.HasFill){
            fill(this.Fill);
        } else {
            noFill();            
        }
        
        if (this.HasStroke){
            stroke(this.Stroke);
        } else {                   
            noStroke();
        }
        
        if (this.HasTint){
            tint(this.Tint);
        } else {                    
            noTint();
        }
        
        strokeWeight(this.StrokeWeight);
        strokeCap(this.StrokeCap);
        strokeJoin(this.StrokeJoin);
        
        ellipseMode(this.EllipseMode);
        rectMode(this.RectMode);
        shapeMode(this.ShapeMode);
        textureMode(this.TextureMode);
        imageMode(this.ImageMode);
        colorMode(this.ColorMode, this.ColorModeMaxR, this.ColorModeMaxG, this.ColorModeMaxB, this.ColorModeMaxA);
        
        if (this.Font == null){
            textSize(this.TextSize);
        } else {
            textFont(this.Font, this.TextSize);
        }        
        textAlign(this.TextAlignX, this.TextAlignY);
        textLeading(this.TextLeading);            
    }
    
    public void Pop() throws IllegalStateException{
        if (this._pushId == Styles.StyleId.peek()){
            Styles.StyleId.pop();
            popStyle();
        } else {
            throw new IllegalStateException("Attempted to pop a style that was not at the top of the stack.");
        }
        
    }
    
}