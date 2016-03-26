interface IContainer{  
    public void ClearChildren();   
    public void AddChild(Element child);   
    public Element RemoveChild(Element child);
    public List<Element> GetChildren();
}

interface IWrapper{
    public void ClearChild();
    public void AssignChild(Element child);
    public Element GetChild();
}

public abstract class AbstractWrapper extends Element implements IWrapper{
    
    protected Element _child;    
  
    public void ClearChild(){
        this._child.parent = null;
        this._child = null;    
    }
  
    public void AssignChild(Element child){
        child.parent = this;
        this._child = child;
    }
  
    public Element GetChild(){
        return this._child;
    }
  
  
    public void Draw(){
        if (this._child != null){
            this._child.Draw();
        }
    }
}

interface IDrawable{  
    // Pushes translations and styles before calling Draw, pops translations and styles after Draw call.
    public void Display();
    
    // Draws to the canvas. Assumes all styles and translations have been applied.
    public void Draw();
  
    public void SetSize(UIDimensions elementSize);
    public UIDimensions GetSize();
  
    public void SetPosition(UIDimensions elementOffset);
    public UIDimensions GetPosition();    
}

interface IDraggable{
    public void BeginDrag(int mousePosX, int mousePosY);
    public void EndDrag(int mousePosX, int mousePosY);
}

interface IClickable{
    // Returns -1 if click not in bounds, otherwise returns ZIndex of element.
    // This allows sorting by ZIndex
    public int HitTest(int mousePosX, int mousePosY);    
}

public class UIDimensions{   
    private int XOffset = 0; // Element.width/2
    private double XScale = 0; // 0.5
    private int YOffset = 0; //Element.height/2
    private double YScale = 0; // 0.5
  
    public UIDimensions(double xScale, int xOffset, double yScale, int yOffset)
    {
        this.XOffset = xOffset;
        this.XScale = xScale;
        this.YOffset = yOffset;
        this.YScale = yScale;
    }
    
    public int GetXOffset(){
        return this.XOffset;
    }
    
    public double GetXScale(){
        return this.XScale;
    }
    
    public int GetYOffset(){
        return this.YOffset;
    }
    
    public double GetYScale(){
        return this.YScale;
    }
}

public class Vector4{
   private int Left, Top, Right, Bottom;
   
   public Vector4(int left, int top, int right, int bottom){
      this.Left = left;
      this.Top = top;
      this.Right = right;
      this.Bottom = bottom;
   }
   
   public int GetLeft(){
       return this.Left;
   }
   
   public int GetTop(){
       return this.Top;
   }
   
   public int GetRight(){
       return this.Right;
   }
   
   public int GetBottom(){
       return this.Bottom;
   }
   
}

// Defines an interface for wrapped methods.
public interface IAction<SenderType>{
    public void Invoke(SenderType sender); 
}



public static class Styles{
    public enum Templates {
        DEFAULT, DARK, LIGHT
    }    
    public static Stack<UUID> StyleId = new Stack<UUID>();    
}

public class StyleTemplate{
    private UUID _pushId;       
    private int EllipseMode, RectMode, ShapeMode, TextureMode, ImageMode, ColorMode, ColorModeMaxR, ColorModeMaxG, ColorModeMaxB, ColorModeMaxA;
    private PFont Font;
    
    public boolean Enabled = false;
    public boolean HasFill, HasStroke, HasTint;
    public color Fill, Stroke, Tint;
    public int StrokeWeight, StrokeCap, StrokeJoin;    
    public int TextSize, TextAlignX, TextAlignY, TextLeading;
    
    public StyleTemplate(){
        //A style that is empty and not enabled.
        this.HasFill = false;
        this.HasStroke = false;
        this.HasTint = false;
        this.EllipseMode = CORNER;
        this.RectMode = CORNER;
        this.ImageMode = CORNER;
        this.TextureMode = NORMAL;
        this.ColorMode = RGB;
        this.ColorModeMaxR = 255;
        this.ColorModeMaxG = 255;
        this.ColorModeMaxB = 255;
        this.ColorModeMaxA = 255;
    }
    
    public StyleTemplate(Styles.Templates Type){
        this.EllipseMode = CORNER;
        this.RectMode = CORNER;
        this.ImageMode = CORNER;
        this.TextureMode = NORMAL;
        this.ColorMode = RGB;
        this.ColorModeMaxR = 255;
        this.ColorModeMaxG = 255;
        this.ColorModeMaxB = 255;
        this.ColorModeMaxA = 255;
            
        if (Type == Styles.Templates.DEFAULT){
            this.Enabled = true;
            this.HasFill = true;
            this.Fill = 0xDDDDDDFF;
            this.HasStroke = true;
            this.Stroke = 0x333333FF;
            this.HasTint = false;
            this.StrokeWeight = 4;
            this.StrokeCap = SQUARE;
            this.StrokeJoin = MITER;                        
        }
    }
    
    public void Push(){
        if (!this.Enabled){
            return;
        }
        
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
        if (!this.Enabled){
            return;
        }
            
        if (this._pushId == Styles.StyleId.peek()){
            Styles.StyleId.pop();
            popStyle();
        } else {
            throw new IllegalStateException("Attempted to pop a style that was not at the top of the stack.");
        }
        
    }  
    public int getEllipseMode(){
      return this.EllipseMode;
    }
    
    public void setEllipseMode(int height, int width){
      //what exactly am i setting?
       Push();
    }
    
    public void setEllipseModeNULL(int EllipseMode){
     this.EllipseMode = EllipseMode;
       //setEllipseMode(null, null); says type mismatch of null and int?
    }
    public int getRectMode(){
      return this.RectMode;
    }
    
    public void setRectMode(int height, int width, int xOffSet, int yOffSet){
      //what exactly am i setting?
       Push();
    }
    
    public void setRectModeNULL(int RectMode){
     this.RectMode = RectMode;
       //setRectMode(null, null); says type mismatch of null and int?
    }
    public int getShapeMode(){
      return this.ShapeMode;
    }
    
    public void setShapeMode(int NotSureOfParameters){
      //what exactly am i setting?
       Push();
    }
    
    public void setShapeModeNULL(int ShapeMode){
     this.ShapeMode = ShapeMode;
       //setShapeMode(null, null); says type mismatch of null and int?
    }
    
    public int getTextureMode(){
      return this.TextureMode;
    }
    
    public void setTextureMode(int NotSureOfParameters){
      //what exactly am i setting?
       Push();
    }
    
    public void setTextureModeNULL(int TextureMode){
     this.TextureMode = TextureMode;
       //setTextureMode(null, null); says type mismatch of null and int?
    }
    
    public int getColorMode(){
      return this.ColorMode;
    }
    
    public void setColorMode(int R, int G, int B){
      //sets the RGB values to ones specified?
       Push();
    }
    
    public void setColorModeNULL(int ColorMode){
     this.ColorMode = ColorMode;
       //setColorMode(null, null); says type mismatch of null and int?
    }
    
    public int getColorModeMaxR(){
      return this.ColorModeMaxR;
    }
    
    public void setColorModeMaxR(int MaxRed){
        MaxRed = 255;
          Push();
      
    }
    
    public void setColorModeMaxRNULL(int MaxR){
     this.ColorModeMaxR = MaxR;
     //MaxR = null; type mismatch
    }
    
    public int getColorModeMaxGMode(){
      return this.ColorModeMaxG;
    }
    
    public void setColorModeMaxG(int MaxGreen){
      MaxGreen = 255;
       Push();
    }
    
    public void setColorModeMaxGNULL(int MaxG){
     this.ColorModeMaxG = MaxG;
     //MaxG = null; type mismatch
    }
    
    public int getColorModeMaxA(){
      return this.ColorModeMaxR;
    }
    
    public void setColorModeMaxA(int MaxA){
      MaxA = 255;
       Push();
    }
    
    public void setColorModeMaxANULL(int MaxA){
     this.ColorModeMaxA = MaxA;
     //MaxA = null; type mismatch
    }
    
    public int getColorModeMaxB(){
      return this.ColorModeMaxR;
    }
    
    public void setColorModeMaxB(int MaxB){
      MaxB = 255;
       Push();
    }
    
    public void setColorModeMaxBNULL(int MaxB){
     this.ColorModeMaxB = MaxB;
     //MaxR = null; type mismatch
    }
    
    public color getFill(){
     return this.Fill;
    }
    
    public void setFill(color Fill){
      this.Fill = Fill;
        Push();
      //is there a way to get input from this user? or do I need to make cases for every color?
    }
    
    public int noFill(){
     //this.Fill = null; how do i set to null w/o type mismatch
       return this.Fill;
    }
    
    public color getStroke(){
     return this.Fill;
    }
    
    public void setStroke(color Stroke){
      this.Stroke = Stroke;
        Push();
      //is there a way to get input from this user? or do I need to make cases for every color?
    }
    
    public int noStroke(){
     //this.Stroke = null; how do i set to null w/o type mismatch
     return this.Stroke;
    }
    
    public color getTint(){
     return this.Tint;
    }
    
    public void setTint(color Tint){
      this.Fill = Tint;
        Push();
      //is there a way to get input from this user? or do I need to make cases for every color?
    }
    
    public int noTint(){
     //this.Tint = null; how do i set to null w/o type mismatch
     return this.Tint;
    }
}