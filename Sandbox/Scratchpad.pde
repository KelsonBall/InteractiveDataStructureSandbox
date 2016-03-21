public class SetFillToRandomColorAction implements IAction<Element>
{
    @Override
    public void Invoke(Element sender)
    {
        if (sender.Style.Enabled){
            sender.Style.Fill = color(random(255), random(255), random(255), random(255));
        }
    }
}