public class VisualRoot extends AbstractWrapper
{
    public Element ElementUnderMouse = null;
    public int ClickMillis = 0;
}
VisualRoot App;

public void Initialize(){
    App = new VisualRoot();
    App.Style.Fill = #FFEE44;
    App.Style.HasFill = true;
}